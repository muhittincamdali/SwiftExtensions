import Foundation

extension Sequence where Element: Sendable {
    /// Transforms every element in parallel, with at most `maxConcurrency` transforms running at
    /// once, and returns the results in the order of the sequence.
    ///
    /// ```swift
    /// let thumbnails = try await photoIDs.concurrentMap(maxConcurrency: 4) { id in
    ///     try await loader.thumbnail(for: id)
    /// }
    /// ```
    ///
    /// The limit keeps a long sequence from starting thousands of tasks, network requests or
    /// decodes at the same time: a new transform starts only when a running one returns. The
    /// first error cancels the transforms that are still running and is thrown; no new
    /// transform starts after it. When `transform` cannot throw, neither does this method.
    ///
    /// Cancelling the calling task cancels the running transforms; the method itself keeps
    /// starting the remaining ones, so a transform that should stop early checks
    /// `Task.isCancelled`.
    ///
    /// - Parameters:
    ///   - maxConcurrency: The largest number of transforms that run at the same time; values
    ///     below 1 count as 1. The default is the number of active processor cores.
    ///   - transform: The work for one element.
    /// - Returns: The transformed elements, in the order of the sequence.
    public func concurrentMap<T: Sendable, Failure: Error>(
        maxConcurrency: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ transform: @escaping @Sendable (Element) async throws(Failure) -> T
    ) async throws(Failure) -> [T] {
        let limit = Swift.max(1, maxConcurrency)
        var iterator = makeIterator()
        let outcome = await withTaskGroup(
            of: (Int, Result<T, Failure>).self,
            returning: Result<[T], Failure>.self
        ) { group in
            var results: [T?] = []
            func start(_ element: Element) {
                let index = results.count
                results.append(nil)
                group.addTask {
                    do throws(Failure) {
                        return (index, .success(try await transform(element)))
                    } catch {
                        return (index, .failure(error))
                    }
                }
            }
            while results.count < limit, let element = iterator.next() {
                start(element)
            }
            while let (index, result) = await group.next() {
                switch result {
                case .success(let value):
                    results[index] = value
                case .failure(let error):
                    group.cancelAll()
                    return .failure(error)
                }
                if let element = iterator.next() {
                    start(element)
                }
            }
            return .success(results.map { $0! })
        }
        return try outcome.get()
    }

    /// Transforms every element in parallel like ``concurrentMap(maxConcurrency:_:)`` and keeps
    /// the results that are not `nil`, in the order of the sequence.
    public func concurrentCompactMap<T: Sendable, Failure: Error>(
        maxConcurrency: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ transform: @escaping @Sendable (Element) async throws(Failure) -> T?
    ) async throws(Failure) -> [T] {
        try await concurrentMap(maxConcurrency: maxConcurrency, transform).compactMap { $0 }
    }

    /// Runs `body` for every element in parallel, with at most `maxConcurrency` calls at once,
    /// and returns when all of them have finished.
    ///
    /// The first error cancels the calls that are still running and is thrown.
    public func concurrentForEach<Failure: Error>(
        maxConcurrency: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ body: @escaping @Sendable (Element) async throws(Failure) -> Void
    ) async throws(Failure) {
        _ = try await concurrentMap(maxConcurrency: maxConcurrency, body)
    }
}
