/// The error that ``withTimeout(_:tolerance:clock:operation:)`` throws when the operation does
/// not finish in time.
public struct TimeoutError: Error, Hashable, CustomStringConvertible {
    /// The time limit that was exceeded.
    public let timeout: Duration

    /// Creates the error for a time limit.
    public init(timeout: Duration) {
        self.timeout = timeout
    }

    public var description: String {
        "The operation did not finish within \(timeout)."
    }
}

/// Runs an operation and throws ``TimeoutError`` when it does not finish within a time limit.
///
/// The operation runs in a child task next to a timer. Whichever finishes first decides the
/// result, and the other one is cancelled:
///
/// ```swift
/// let profile = try await withTimeout(.seconds(5)) {
///     try await api.profile()
/// }
/// ```
///
/// Cancellation in Swift is cooperative: after the time limit, this function cancels the
/// operation and waits for it to return. An operation that never checks for cancellation (a
/// blocking call, a loop without `Task.checkCancellation()`) delays the ``TimeoutError`` until
/// it returns. `URLSession`, `Task.sleep` and other system APIs stop as soon as they are
/// cancelled.
///
/// A `timeout` of zero or less throws ``TimeoutError`` without starting the operation, and a
/// task that is already cancelled throws `CancellationError`.
///
/// - Parameters:
///   - timeout: How long the operation may run.
///   - tolerance: The leeway the clock may add to the timer; `nil` uses the clock's default.
///   - clock: The clock that measures the time limit. `ContinuousClock` keeps counting while
///     the device sleeps; pass `SuspendingClock()` to pause the limit with the device.
///   - operation: The work to run. It may be isolated to an actor, such as `@MainActor`.
/// - Returns: The value the operation returned.
/// - Throws: ``TimeoutError`` after the time limit, `CancellationError` when the calling task
///   is cancelled, or the error the operation threw.
public func withTimeout<Success: Sendable, C: Clock>(
    _ timeout: Duration,
    tolerance: Duration? = nil,
    clock: C = ContinuousClock(),
    operation: @escaping @Sendable @isolated(any) () async throws -> Success
) async throws -> Success where C.Duration == Duration {
    try Task.checkCancellation()
    guard timeout > .zero else {
        throw TimeoutError(timeout: timeout)
    }
    return try await withThrowingTaskGroup(of: Success.self) { group in
        group.addTask(operation: operation)
        group.addTask {
            try await clock.sleep(for: timeout, tolerance: tolerance)
            throw TimeoutError(timeout: timeout)
        }
        defer { group.cancelAll() }
        guard let first = try await group.next() else {
            throw CancellationError()
        }
        return first
    }
}
