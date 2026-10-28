import Foundation

/// The error that ``_Concurrency/AsyncSequence/collect(limit:isolation:)`` and
/// ``_Concurrency/AsyncSequence/collectData(limit:isolation:)`` throw when a sequence has more
/// elements than the limit allows.
public struct CollectLimitExceededError: Error, Hashable, CustomStringConvertible {
    /// The largest number of elements, or bytes, that was allowed.
    public let limit: Int

    /// Creates the error for a limit.
    public init(limit: Int) {
        self.limit = limit
    }

    public var description: String {
        "The sequence has more than \(limit) elements."
    }
}

extension AsyncSequence {
    /// Reads every element into an array, and throws as soon as there are more than `limit`.
    ///
    /// `Array(asyncSequence)` and a `for await` loop that appends keep reading for as long as
    /// the sequence produces elements, so a sequence fed from the network can fill the memory.
    /// This method stops reading at element `limit + 1` and throws
    /// ``CollectLimitExceededError``; the elements read so far are dropped.
    ///
    /// ```swift
    /// let lines = try await url.lines.collect(limit: 10_000)
    /// ```
    ///
    /// - Parameters:
    ///   - limit: The largest number of elements to accept; values below 0 count as 0.
    ///   - isolation: The actor the sequence is read on; leave the default to use the caller's.
    /// - Returns: All elements, in order, when there are at most `limit`.
    /// - Throws: ``CollectLimitExceededError`` or the error of the sequence.
    public func collect(
        limit: Int,
        isolation: isolated (any Actor)? = #isolation
    ) async throws -> [Element] {
        let limit = Swift.max(0, limit)
        var elements: [Element] = []
        for try await element in self {
            guard elements.count < limit else {
                throw CollectLimitExceededError(limit: limit)
            }
            elements.append(element)
        }
        return elements
    }
}

extension AsyncSequence where Element == UInt8 {
    /// Reads every byte into `Data`, and throws as soon as there are more than `limit`.
    ///
    /// Use it with `URLSession.AsyncBytes`, `FileHandle.AsyncBytes` or any other byte sequence
    /// whose length you do not control. Reading stops at byte `limit + 1`.
    ///
    /// - Parameters:
    ///   - limit: The largest number of bytes to accept; values below 0 count as 0.
    ///   - isolation: The actor the sequence is read on; leave the default to use the caller's.
    /// - Returns: All bytes when there are at most `limit`.
    /// - Throws: ``CollectLimitExceededError`` or the error of the sequence.
    public func collectData(
        limit: Int,
        isolation: isolated (any Actor)? = #isolation
    ) async throws -> Data {
        let limit = Swift.max(0, limit)
        var data = Data()
        data.reserveCapacity(Swift.min(limit, Self.initialCapacity))
        for try await byte in self {
            guard data.count < limit else {
                throw CollectLimitExceededError(limit: limit)
            }
            data.append(byte)
        }
        return data
    }

    // Reserving the whole limit up front would allocate it even for a short response.
    private static var initialCapacity: Int { 16 * 1024 }
}
