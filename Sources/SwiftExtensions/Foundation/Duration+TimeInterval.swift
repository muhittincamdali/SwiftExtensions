import Foundation

extension Duration {
    /// The duration in seconds, as the `TimeInterval` that Foundation, UIKit and Core Animation
    /// take.
    ///
    /// The value is exact up to the precision of `Double`, about a microsecond for durations of
    /// a few years.
    public var timeInterval: TimeInterval {
        let (seconds, attoseconds) = components
        return Double(seconds) + Double(attoseconds) * 1e-18
    }

    /// Creates a duration from a `TimeInterval`, or returns `nil` when the value has no duration.
    ///
    /// `Duration.seconds(_:)` stops the app with a fatal error for `.nan`, `.infinity` and
    /// values too large for a duration. Values like these arrive from division by zero, from
    /// decoded JSON or from `Date` arithmetic, and this initializer returns `nil` for them
    /// instead: for a value that is not finite, and for one whose magnitude is 2⁶³ seconds or
    /// more.
    ///
    /// ```swift
    /// let wait = Duration(timeInterval: config.retryAfter) ?? .seconds(5)
    /// ```
    ///
    /// - Parameter timeInterval: A number of seconds; the fraction is kept to the nearest
    ///   attosecond.
    public init?(timeInterval: TimeInterval) {
        guard timeInterval.isFinite else { return nil }
        let whole = timeInterval.rounded(.towardZero)
        guard let seconds = Int64(exactly: whole) else { return nil }
        let attoseconds = Int64(((timeInterval - whole) * 1e18).rounded())
        self.init(secondsComponent: seconds, attosecondsComponent: attoseconds)
    }
}

extension Date {
    /// Returns the date that is `duration` later, or earlier for a negative duration.
    ///
    /// Use it to schedule with the values that `Clock` and `Task.sleep(for:)` already use, such
    /// as `.seconds(30)` or `.milliseconds(250)`, without converting them by hand.
    public func advanced(by duration: Duration) -> Date {
        addingTimeInterval(duration.timeInterval)
    }
}
