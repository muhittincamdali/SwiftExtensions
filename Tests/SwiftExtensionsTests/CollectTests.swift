import Foundation
import Synchronization
import Testing
import SwiftExtensions

/// The number of elements a ``Counter`` produced, shared by its copies.
private final class ReadCount: Sendable {
    private let value = Mutex(0)
    var count: Int { value.withLock { $0 } }
    func increment() { value.withLock { $0 += 1 } }
}

/// A sequence of bytes 0, 1, 2, … that ends after `end` elements, or never, and counts how many
/// elements were read.
private struct Counter: AsyncSequence, Sendable {
    let reads = ReadCount()
    var end: Int? = nil

    struct AsyncIterator: AsyncIteratorProtocol {
        let sequence: Counter
        var next = 0

        mutating func next() async -> UInt8? {
            if let end = sequence.end, next >= end { return nil }
            sequence.reads.increment()
            defer { next += 1 }
            return UInt8(truncatingIfNeeded: next)
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(sequence: self)
    }
}

@Suite("AsyncSequence.collect(limit:)")
struct CollectTests {
    private func stream(_ values: [Int]) -> AsyncStream<Int> {
        AsyncStream { continuation in
            values.forEach { continuation.yield($0) }
            continuation.finish()
        }
    }

    @Test(arguments: [3, 4, 100])
    func returnsEveryElementWhenTheyFit(limit: Int) async throws {
        #expect(try await stream([1, 2, 3]).collect(limit: limit) == [1, 2, 3])
    }

    @Test func throwsAtTheFirstElementOverTheLimit() async {
        await #expect(throws: CollectLimitExceededError(limit: 2)) {
            try await stream([1, 2, 3]).collect(limit: 2)
        }
    }

    @Test func stopsReadingAnEndlessSequence() async {
        let counter = Counter()
        await #expect(throws: CollectLimitExceededError(limit: 1_000)) {
            try await counter.collect(limit: 1_000)
        }
        #expect(counter.reads.count == 1_001)
    }

    @Test(arguments: [0, -1, Int.min])
    func aLimitOfZeroOrLessAcceptsOnlyAnEmptySequence(limit: Int) async throws {
        #expect(try await stream([]).collect(limit: limit).isEmpty)
        await #expect(throws: CollectLimitExceededError(limit: 0)) {
            try await stream([1]).collect(limit: limit)
        }
    }

    @Test func passesOnTheErrorOfTheSequence() async {
        struct Failure: Error, Equatable {}
        let failing = AsyncThrowingStream<Int, any Error> { continuation in
            continuation.yield(1)
            continuation.finish(throwing: Failure())
        }
        await #expect(throws: Failure()) { try await failing.collect(limit: 10) }
    }
}

@Suite("AsyncSequence.collectData(limit:)")
struct CollectDataTests {
    @Test func returnsTheBytesWhenTheyFit() async throws {
        let counter = Counter(end: 5)
        #expect(try await counter.collectData(limit: 5) == Data([0, 1, 2, 3, 4]))
    }

    @Test func stopsReadingAtTheByteAfterTheLimit() async {
        let counter = Counter()
        await #expect(throws: CollectLimitExceededError(limit: 64)) {
            try await counter.collectData(limit: 64)
        }
        #expect(counter.reads.count == 65)
    }

    @Test func aLimitLargerThanTheReservedCapacityStillWorks() async throws {
        let counter = Counter(end: 100_000)
        #expect(try await counter.collectData(limit: 1_000_000).count == 100_000)
    }

    @Test func aNegativeLimitAcceptsNoBytes() async {
        await #expect(throws: CollectLimitExceededError(limit: 0)) {
            try await Counter().collectData(limit: -10)
        }
    }
}
