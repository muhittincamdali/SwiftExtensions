import Foundation

// MARK: - Collection Parallel Extensions

public extension Collection {
    
    // MARK: - Parallel Map
    
    /// Maps elements in parallel using DispatchQueue.
    ///
    /// - Parameter transform: Transformation closure.
    /// - Returns: Transformed array (order preserved).
    ///
    /// ```swift
    /// let results = urls.parallelMap { fetchData(from: $0) }
    /// ```
    func parallelMap<T>(_ transform: @escaping (Element) -> T) -> [T] {
        guard !isEmpty else { return [] }
        
        var results = Array<T?>(repeating: nil, count: count)
        let lock = NSLock()
        
        DispatchQueue.concurrentPerform(iterations: count) { index in
            let element = self[self.index(startIndex, offsetBy: index)]
            let result = transform(element)
            
            lock.lock()
            results[index] = result
            lock.unlock()
        }
        
        return results.compactMap { $0 }
    }
    
    /// Maps elements in parallel with maximum concurrency.
    ///
    /// - Parameters:
    ///   - maxConcurrency: Maximum concurrent operations.
    ///   - transform: Transformation closure.
    /// - Returns: Transformed array.
    func parallelMap<T>(maxConcurrency: Int, _ transform: @escaping (Element) -> T) -> [T] {
        guard !isEmpty else { return [] }
        
        let semaphore = DispatchSemaphore(value: maxConcurrency)
        var results = Array<T?>(repeating: nil, count: count)
        let lock = NSLock()
        let queue = DispatchQueue(label: "parallelMap", attributes: .concurrent)
        let group = DispatchGroup()
        
        for (index, element) in enumerated() {
            group.enter()
            queue.async {
                semaphore.wait()
                let result = transform(element)
                
                lock.lock()
                results[index] = result
                lock.unlock()
                
                semaphore.signal()
                group.leave()
            }
        }
        
        group.wait()
        return results.compactMap { $0 }
    }
    
    // MARK: - Parallel CompactMap
    
    /// Compact maps elements in parallel.
    ///
    /// - Parameter transform: Optional transformation closure.
    /// - Returns: Transformed array with nil values removed.
    func parallelCompactMap<T>(_ transform: @escaping (Element) -> T?) -> [T] {
        return parallelMap(transform).compactMap { $0 }
    }
    
    // MARK: - Parallel ForEach
    
    /// Iterates elements in parallel.
    ///
    /// - Parameter body: Closure to execute for each element.
    func parallelForEach(_ body: @escaping (Element) -> Void) {
        guard !isEmpty else { return }
        
        DispatchQueue.concurrentPerform(iterations: count) { index in
            let element = self[self.index(startIndex, offsetBy: index)]
            body(element)
        }
    }
    
    /// Iterates elements in parallel with index.
    ///
    /// - Parameter body: Closure with index and element.
    func parallelEnumerated(_ body: @escaping (Int, Element) -> Void) {
        guard !isEmpty else { return }
        
        DispatchQueue.concurrentPerform(iterations: count) { index in
            let element = self[self.index(startIndex, offsetBy: index)]
            body(index, element)
        }
    }
    
    // MARK: - Parallel Filter
    
    /// Filters elements in parallel.
    ///
    /// - Parameter isIncluded: Predicate closure.
    /// - Returns: Filtered array (order preserved).
    func parallelFilter(_ isIncluded: @escaping (Element) -> Bool) -> [Element] {
        guard !isEmpty else { return [] }
        
        var included = Array<Bool>(repeating: false, count: count)
        let lock = NSLock()
        
        DispatchQueue.concurrentPerform(iterations: count) { index in
            let element = self[self.index(startIndex, offsetBy: index)]
            let result = isIncluded(element)
            
            lock.lock()
            included[index] = result
            lock.unlock()
        }
        
        var results: [Element] = []
        for (index, include) in included.enumerated() {
            if include {
                results.append(self[self.index(startIndex, offsetBy: index)])
            }
        }
        
        return results
    }
    
    // MARK: - Parallel Reduce
    
    /// Reduces elements in parallel using chunking.
    ///
    /// - Parameters:
    ///   - initialResult: Initial result value.
    ///   - nextPartialResult: Combination closure.
    /// - Returns: Reduced result.
    func parallelReduce<T>(
        _ initialResult: T,
        _ nextPartialResult: @escaping (T, Element) -> T
    ) -> T where T: Sendable {
        guard !isEmpty else { return initialResult }
        
        let chunkSize = Swift.max(1, count / ProcessInfo.processInfo.activeProcessorCount)
        var chunks: [[Element]] = []
        var currentChunk: [Element] = []
        
        for element in self {
            currentChunk.append(element)
            if currentChunk.count >= chunkSize {
                chunks.append(currentChunk)
                currentChunk = []
            }
        }
        if !currentChunk.isEmpty {
            chunks.append(currentChunk)
        }
        
        var results = Array<T?>(repeating: nil, count: chunks.count)
        let lock = NSLock()
        
        DispatchQueue.concurrentPerform(iterations: chunks.count) { index in
            let chunk = chunks[index]
            var result = initialResult
            for element in chunk {
                result = nextPartialResult(result, element)
            }
            
            lock.lock()
            results[index] = result
            lock.unlock()
        }
        
        return results.compactMap { $0 }.reduce(initialResult, nextPartialResult)
    }
}

// MARK: - Async/Await Parallel Extensions

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Collection where Element: Sendable {
    
    /// Maps elements concurrently using async/await.
    ///
    /// - Parameter transform: Async transformation closure.
    /// - Returns: Transformed array.
    func asyncMap<T>(_ transform: @escaping @Sendable (Element) async -> T) async -> [T] {
        await withTaskGroup(of: (Int, T).self) { group in
            for (index, element) in enumerated() {
                group.addTask {
                    let result = await transform(element)
                    return (index, result)
                }
            }
            
            var results = Array<T?>(repeating: nil, count: count)
            for await (index, result) in group {
                results[index] = result
            }
            
            return results.compactMap { $0 }
        }
    }
    
    /// Maps elements concurrently with throwing transform.
    func asyncMap<T>(_ transform: @escaping @Sendable (Element) async throws -> T) async throws -> [T] {
        try await withThrowingTaskGroup(of: (Int, T).self) { group in
            for (index, element) in enumerated() {
                group.addTask {
                    let result = try await transform(element)
                    return (index, result)
                }
            }
            
            var results = Array<T?>(repeating: nil, count: count)
            for try await (index, result) in group {
                results[index] = result
            }
            
            return results.compactMap { $0 }
        }
    }
    
    /// Iterates elements concurrently.
    func asyncForEach(_ body: @escaping @Sendable (Element) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await body(element)
                }
            }
        }
    }
    
    /// Filters elements concurrently.
    func asyncFilter(_ isIncluded: @escaping @Sendable (Element) async -> Bool) async -> [Element] {
        await withTaskGroup(of: (Int, Bool).self) { group in
            for (index, element) in enumerated() {
                group.addTask {
                    let result = await isIncluded(element)
                    return (index, result)
                }
            }
            
            var included = Array<Bool>(repeating: false, count: count)
            for await (index, result) in group {
                included[index] = result
            }
            
            var results: [Element] = []
            for (index, include) in included.enumerated() {
                if include {
                    results.append(self[self.index(startIndex, offsetBy: index)])
                }
            }
            
            return results
        }
    }
}

// MARK: - Batch Processing

public extension Collection {
    
    /// Processes elements in batches.
    ///
    /// - Parameters:
    ///   - batchSize: Size of each batch.
    ///   - process: Batch processing closure.
    func processBatches(of batchSize: Int, _ process: ([Element]) -> Void) {
        var batch: [Element] = []
        
        for element in self {
            batch.append(element)
            if batch.count >= batchSize {
                process(batch)
                batch.removeAll()
            }
        }
        
        if !batch.isEmpty {
            process(batch)
        }
    }
    
    /// Maps elements in batches.
    ///
    /// - Parameters:
    ///   - batchSize: Size of each batch.
    ///   - transform: Batch transformation closure.
    /// - Returns: Flattened results.
    func batchMap<T>(of batchSize: Int, _ transform: ([Element]) -> [T]) -> [T] {
        var results: [T] = []
        
        processBatches(of: batchSize) { batch in
            results.append(contentsOf: transform(batch))
        }
        
        return results
    }
}
