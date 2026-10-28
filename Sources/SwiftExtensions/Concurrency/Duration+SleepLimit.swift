extension Duration {
    /// The longest wait the package hands to `Clock.sleep(for:)`: `Int64.max` nanoseconds,
    /// about 292 years.
    ///
    /// `ContinuousClock` and `SuspendingClock` trap with "Not enough bits to represent the
    /// passed value" when the deadline of a sleep does not fit in 64 bits, which a `Duration`
    /// of about 2⁶³ seconds reaches. Shorter waits never trap.
    static let longestSleep = Duration.nanoseconds(Int64.max)
}
