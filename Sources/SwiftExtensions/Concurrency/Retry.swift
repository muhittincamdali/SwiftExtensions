import Foundation

/// How often ``withRetry(_:clock:isolation:shouldRetry:operation:)`` runs an operation and how
/// long it waits between attempts.
///
/// The wait grows exponentially from ``initialDelay`` by ``multiplier`` after each failure, never
/// goes above ``maxDelay``, and is shortened by a random part of up to ``jitter`` so that many
/// clients that failed together do not retry together.
///
/// Every value is checked when the policy is created, so a policy built from remote
/// configuration cannot loop forever or trap: ``maxAttempts`` is kept between 1 and
/// ``attemptLimit``, negative delays become zero, a `maxDelay` above `Int64.max` nanoseconds
/// (about 292 years) is shortened to that, a `multiplier` below 1 or not finite becomes 1, and a
/// `jitter` outside 0...1 or not finite is clamped (NaN becomes 0).
public struct RetryPolicy: Sendable, Hashable {
    /// The largest number of attempts a policy allows.
    public static let attemptLimit = 100

    /// Three attempts, 200 ms after the first failure and 400 ms after the second, with 20 %
    /// jitter and at most 30 seconds between attempts.
    public static let `default` = RetryPolicy()

    /// The number of times the operation runs at most, including the first run.
    public let maxAttempts: Int
    /// The wait after the first failure.
    public let initialDelay: Duration
    /// The factor the wait grows by after each further failure.
    public let multiplier: Double
    /// The longest wait between two attempts.
    public let maxDelay: Duration
    /// The largest part of a wait, from 0 to 1, that is removed at random.
    public let jitter: Double

    /// Creates a policy; out-of-range values are corrected as described in ``RetryPolicy``.
    public init(
        maxAttempts: Int = 3,
        initialDelay: Duration = .milliseconds(200),
        multiplier: Double = 2,
        maxDelay: Duration = .seconds(30),
        jitter: Double = 0.2
    ) {
        self.maxAttempts = min(max(maxAttempts, 1), Self.attemptLimit)
        self.initialDelay = max(initialDelay, .zero)
        self.multiplier = multiplier.isFinite && multiplier >= 1 ? multiplier : 1
        self.maxDelay = min(max(maxDelay, .zero), .longestSleep)
        self.jitter = jitter.isNaN ? 0 : min(max(jitter, 0), 1)
    }

    /// The wait before the attempt that follows a failed one.
    ///
    /// - Parameters:
    ///   - failedAttempt: The number of the attempt that failed, starting at 1.
    ///   - randomFraction: A value in `0..<1` that picks the jitter; values outside 0...1 are
    ///     clamped and NaN counts as 0.
    /// - Returns: `initialDelay × multiplier^(failedAttempt − 1)`, at most ``maxDelay``, minus
    ///   `jitter × randomFraction` of that wait.
    public func delay(afterAttempt failedAttempt: Int, randomFraction: Double) -> Duration {
        // Zero grown by an infinite factor is NaN, which would turn into the maximum below.
        guard initialDelay > .zero else { return .zero }
        let exponent = Double(max(failedAttempt, 1) - 1)
        let ceiling = maxDelay.timeInterval
        let grown = initialDelay.timeInterval * pow(multiplier, exponent)
        let capped = grown.isFinite ? min(grown, ceiling) : ceiling
        let fraction = randomFraction.isNaN ? 0 : min(max(randomFraction, 0), 1)
        let seconds = capped * (1 - jitter * fraction)
        // Whole nanoseconds, so that 0.1 s × 3 is 300 ms and not 300 ms plus 40 attoseconds.
        // Only a wait of about Int64.max nanoseconds rounds to a value that does not fit.
        guard let nanoseconds = Int64(rounding: seconds * 1e9) else { return maxDelay }
        return .nanoseconds(nanoseconds)
    }
}

/// Runs an operation again after a failure, waiting longer before each new attempt.
///
/// ```swift
/// let feed = try await withRetry(RetryPolicy(maxAttempts: 4)) { attempt in
///     try await api.feed()
/// }
/// ```
///
/// The operation runs at most ``RetryPolicy/maxAttempts`` times. A failure is retried only when
/// `shouldRetry` returns `true` for its error; `CancellationError` and a cancelled task always
/// stop at once, also during a wait. When every attempt fails, the last error is thrown.
///
/// The operation and `shouldRetry` run on the caller's actor, so they may use its state without
/// being `Sendable`.
///
/// - Parameters:
///   - policy: The number of attempts and the waits between them.
///   - clock: The clock that measures the waits.
///   - isolation: The actor the operation runs on; leave the default to use the caller's.
///   - shouldRetry: Decides whether an error is worth another attempt. The default retries
///     every error except cancellation.
///   - operation: The work to run. It receives the number of the attempt, starting at 1.
/// - Returns: The value of the first attempt that succeeds.
/// - Throws: The error of the last attempt, an error `shouldRetry` declined, or
///   `CancellationError`.
public func withRetry<Success, C: Clock>(
    _ policy: RetryPolicy = .default,
    clock: C = ContinuousClock(),
    isolation: isolated (any Actor)? = #isolation,
    shouldRetry: (any Error) -> Bool = { _ in true },
    operation: (_ attempt: Int) async throws -> Success
) async throws -> Success where C.Duration == Duration {
    var attempt = 1
    while true {
        try Task.checkCancellation()
        do {
            return try await operation(attempt)
        } catch let cancellation as CancellationError {
            throw cancellation
        } catch {
            guard attempt < policy.maxAttempts, shouldRetry(error) else {
                throw error
            }
            let wait = policy.delay(afterAttempt: attempt, randomFraction: .random(in: 0..<1))
            try await clock.sleep(for: wait)
            attempt += 1
        }
    }
}
