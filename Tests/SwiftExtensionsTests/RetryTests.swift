import Foundation
import Synchronization
import Testing
import SwiftExtensions

@Suite("RetryPolicy")
struct RetryPolicyTests {
    @Test func theWaitGrowsByTheMultiplier() {
        let policy = RetryPolicy(initialDelay: .milliseconds(100), multiplier: 3, jitter: 0)
        #expect(policy.delay(afterAttempt: 1, randomFraction: 0) == .milliseconds(100))
        #expect(policy.delay(afterAttempt: 2, randomFraction: 0) == .milliseconds(300))
        #expect(policy.delay(afterAttempt: 3, randomFraction: 0) == .milliseconds(900))
    }

    @Test func theWaitStopsAtTheMaximum() {
        let policy = RetryPolicy(initialDelay: .seconds(1), multiplier: 10, maxDelay: .seconds(5), jitter: 0)
        #expect(policy.delay(afterAttempt: 2, randomFraction: 0) == .seconds(5))
    }

    @Test(arguments: [Int.max, 10_000, 1_025])
    func aHugeAttemptNumberGivesTheMaximumInsteadOfOverflowing(attempt: Int) {
        let policy = RetryPolicy(initialDelay: .seconds(1), multiplier: 2, maxDelay: .seconds(30), jitter: 0)
        #expect(policy.delay(afterAttempt: attempt, randomFraction: 0) == .seconds(30))
    }

    @Test func attemptNumbersBelowOneCountAsOne() {
        let policy = RetryPolicy(initialDelay: .seconds(1), jitter: 0)
        #expect(policy.delay(afterAttempt: 0, randomFraction: 0) == .seconds(1))
        #expect(policy.delay(afterAttempt: Int.min, randomFraction: 0) == .seconds(1))
    }

    @Test func jitterRemovesUpToItsShareOfTheWait() {
        let policy = RetryPolicy(initialDelay: .seconds(10), jitter: 0.5)
        #expect(policy.delay(afterAttempt: 1, randomFraction: 0) == .seconds(10))
        #expect(policy.delay(afterAttempt: 1, randomFraction: 1) == .seconds(5))
        #expect(policy.delay(afterAttempt: 1, randomFraction: 0.5) == .milliseconds(7_500))
    }

    @Test(arguments: [Double.nan, -3, 7, .infinity, -.infinity])
    func anInvalidRandomFractionIsClamped(fraction: Double) {
        let policy = RetryPolicy(initialDelay: .seconds(10), jitter: 0.5)
        let wait = policy.delay(afterAttempt: 1, randomFraction: fraction)
        #expect(wait >= .seconds(5) && wait <= .seconds(10))
    }

    @Test func invalidSettingsAreCorrected() {
        let policy = RetryPolicy(
            maxAttempts: 0,
            initialDelay: .seconds(-1),
            multiplier: .nan,
            maxDelay: .seconds(-5),
            jitter: .nan
        )
        #expect(policy.maxAttempts == 1)
        #expect(policy.initialDelay == .zero)
        #expect(policy.multiplier == 1)
        #expect(policy.maxDelay == .zero)
        #expect(policy.jitter == 0)
        #expect(policy.delay(afterAttempt: 5, randomFraction: 0.5) == .zero)
    }

    @Test func aMaximumBeyondWhatAClockCanSleepIsShortened() {
        // A Duration this long traps in Clock.sleep(for:); the policy keeps Int64.max nanoseconds.
        let longest = Duration.nanoseconds(Int64.max)
        let policy = RetryPolicy(
            initialDelay: .milliseconds(10),
            multiplier: 1e300,
            maxDelay: .seconds(Int64.max),
            jitter: 0
        )
        #expect(policy.maxDelay == longest)
        #expect(policy.delay(afterAttempt: 2, randomFraction: 0) == longest)
        #expect(RetryPolicy(initialDelay: .seconds(Int64.max), jitter: 0).delay(afterAttempt: 1, randomFraction: 0) <= longest)
    }

    @Test(arguments: [
        (Int.max, RetryPolicy.attemptLimit),
        (-7, 1),
        (101, 100),
        (5, 5)
    ])
    func maxAttemptsStaysInItsRange(requested: Int, expected: Int) {
        #expect(RetryPolicy(maxAttempts: requested).maxAttempts == expected)
    }

    @Test(arguments: [0.5, -.infinity, .infinity, 0])
    func aMultiplierBelowOneOrNotFiniteBecomesOne(multiplier: Double) {
        #expect(RetryPolicy(multiplier: multiplier).multiplier == 1)
    }

    @Test(arguments: [(-0.5, 0.0), (1.5, 1.0), (Double.infinity, 1.0), (0.25, 0.25)])
    func jitterStaysBetweenZeroAndOne(requested: Double, expected: Double) {
        #expect(RetryPolicy(jitter: requested).jitter == expected)
    }
}

@Suite("withRetry")
struct WithRetryTests {
    struct Flaky: Error, Equatable { let attempt: Int }

    private let instant = RetryPolicy(maxAttempts: 5, initialDelay: .zero, jitter: 0)

    @Test func returnsTheFirstSuccessAndCountsAttempts() async throws {
        var attempts: [Int] = []
        let value = try await withRetry(instant) { attempt in
            attempts.append(attempt)
            if attempt < 3 { throw Flaky(attempt: attempt) }
            return "ok"
        }
        #expect(value == "ok")
        #expect(attempts == [1, 2, 3])
    }

    @Test func throwsTheLastErrorAfterTheLastAttempt() async {
        var calls = 0
        await #expect(throws: Flaky(attempt: 5)) {
            try await withRetry(instant) { attempt -> Int in
                calls += 1
                throw Flaky(attempt: attempt)
            }
        }
        #expect(calls == 5)
    }

    @Test func stopsWhenShouldRetryDeclines() async {
        var calls = 0
        await #expect(throws: Flaky(attempt: 1)) {
            try await withRetry(instant, shouldRetry: { _ in false }) { attempt -> Int in
                calls += 1
                throw Flaky(attempt: attempt)
            }
        }
        #expect(calls == 1)
    }

    @Test func neverRetriesCancellation() async {
        var calls = 0
        await #expect(throws: CancellationError.self) {
            try await withRetry(instant) { _ -> Int in
                calls += 1
                throw CancellationError()
            }
        }
        #expect(calls == 1)
    }

    @Test func cancellingDuringAWaitStopsAtOnce() async {
        let slow = RetryPolicy(maxAttempts: 3, initialDelay: .seconds(60), jitter: 0)
        let started = ContinuousClock.now
        let task = Task {
            try await withRetry(slow) { attempt -> Int in throw Flaky(attempt: attempt) }
        }
        try? await Task.sleep(for: .milliseconds(50))
        task.cancel()
        await #expect(throws: CancellationError.self) { try await task.value }
        #expect(ContinuousClock.now - started < .seconds(10))
    }

    @Test func aHugeMaximumWaitsUntilCancelledInsteadOfTrapping() async {
        let endless = RetryPolicy(
            maxAttempts: 3,
            initialDelay: .milliseconds(10),
            multiplier: 1e300,
            maxDelay: .seconds(Int64.max),
            jitter: 0
        )
        let attempts = Mutex(0)
        let task = Task {
            try await withRetry(endless) { attempt -> Int in
                attempts.withLock { $0 = attempt }
                throw Flaky(attempt: attempt)
            }
        }
        try? await Task.sleep(for: .milliseconds(300))
        task.cancel()
        await #expect(throws: CancellationError.self) { try await task.value }
        #expect(attempts.withLock { $0 } == 2)
    }

    @MainActor
    @Test func theOperationRunsOnTheCallersActor() async throws {
        let onMain = try await withRetry(instant) { _ in pthread_main_np() == 1 }
        #expect(onMain)
    }
}
