import Synchronization
import Testing
import SwiftExtensions

/// Counts the transforms that run at the same time and the highest count seen.
private final class ConcurrencyProbe: Sendable {
    private let state = Mutex((running: 0, peak: 0, started: 0))

    var peak: Int { state.withLock { $0.peak } }
    var started: Int { state.withLock { $0.started } }

    func enter() {
        state.withLock {
            $0.running += 1
            $0.started += 1
            $0.peak = max($0.peak, $0.running)
        }
    }

    func leave() {
        state.withLock { $0.running -= 1 }
    }
}

@Suite("concurrentMap")
struct ConcurrentMapTests {
    @Test func keepsTheOrderOfTheSequence() async {
        let input = Array(0..<40)
        let output = await input.concurrentMap(maxConcurrency: 8) { value in
            // Later elements finish first.
            try? await Task.sleep(for: .milliseconds(40 - value))
            return value * 2
        }
        #expect(output == input.map { $0 * 2 })
    }

    @Test(arguments: [1, 3, 8])
    func neverRunsMoreThanTheLimit(limit: Int) async {
        let probe = ConcurrencyProbe()
        _ = await Array(0..<24).concurrentMap(maxConcurrency: limit) { value in
            probe.enter()
            try? await Task.sleep(for: .milliseconds(5))
            probe.leave()
            return value
        }
        #expect(probe.peak <= limit)
        #expect(probe.started == 24)
    }

    @Test func usesTheLimitWhenThereIsEnoughWork() async {
        let probe = ConcurrencyProbe()
        _ = await Array(0..<12).concurrentMap(maxConcurrency: 4) { value in
            probe.enter()
            try? await Task.sleep(for: .milliseconds(50))
            probe.leave()
            return value
        }
        #expect(probe.peak > 1)
    }

    @Test(arguments: [0, -5, Int.min])
    func aLimitBelowOneRunsOneAtATime(limit: Int) async {
        let probe = ConcurrencyProbe()
        let output = await Array(0..<6).concurrentMap(maxConcurrency: limit) { value in
            probe.enter()
            try? await Task.sleep(for: .milliseconds(2))
            probe.leave()
            return value
        }
        #expect(output == Array(0..<6))
        #expect(probe.peak == 1)
    }

    @Test func theFirstErrorIsThrownAndNoNewTransformStarts() async {
        struct Failure: Error, Equatable { let value: Int }
        let probe = ConcurrencyProbe()
        await #expect(throws: Failure(value: 2)) {
            try await Array(0..<100).concurrentMap(maxConcurrency: 2) { value throws(Failure) -> Int in
                probe.enter()
                defer { probe.leave() }
                if value == 2 { throw Failure(value: value) }
                return value
            }
        }
        #expect(probe.started < 100)
    }

    @Test func anErrorCancelsTheRunningTransforms() async {
        struct Failure: Error {}
        let cancelled = Mutex(false)
        await #expect(throws: Failure.self) {
            try await [0, 1].concurrentMap(maxConcurrency: 2) { value throws(Failure) -> Int in
                if value == 0 {
                    try? await Task.sleep(for: .milliseconds(10))
                    throw Failure()
                }
                try? await Task.sleep(for: .seconds(30))
                cancelled.withLock { $0 = Task.isCancelled }
                return value
            }
        }
        #expect(cancelled.withLock { $0 })
    }

    @Test func anEmptySequenceGivesAnEmptyArray() async {
        let output = await [Int]().concurrentMap { $0 }
        #expect(output.isEmpty)
    }

    @Test func compactMapDropsNilAndKeepsTheOrder() async {
        let output = await Array(0..<10).concurrentCompactMap(maxConcurrency: 3) { value in
            value.isMultiple(of: 3) ? "\(value)" : nil
        }
        #expect(output == ["0", "3", "6", "9"])
    }

    @Test func forEachVisitsEveryElement() async {
        let seen = Mutex<Set<Int>>([])
        await Set(0..<50).concurrentForEach(maxConcurrency: 5) { value in
            seen.withLock { _ = $0.insert(value) }
        }
        #expect(seen.withLock { $0 } == Set(0..<50))
    }
}
