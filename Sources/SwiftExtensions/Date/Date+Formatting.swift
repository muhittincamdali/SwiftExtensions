import Foundation

extension Date {

    /// Returns the date formatted as an ISO 8601 string.
    ///
    /// ```swift
    /// Date().iso8601String // "2026-01-15T10:30:00Z"
    /// ```
    public var iso8601String: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: self)
    }

    /// Formats the date using the given format string.
    ///
    /// ```swift
    /// Date().formatted(as: "dd MMM yyyy") // "15 Jan 2026"
    /// ```
    ///
    /// - Parameter format: A date format pattern string.
    /// - Returns: Formatted date string.
    public func formatted(as format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }

    /// Returns a human-readable relative time string.
    ///
    /// ```swift
    /// Date().addingTimeInterval(-3600).relativeString // "1 hour ago"
    /// ```
    public var relativeString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    /// Returns a short date representation.
    ///
    /// ```swift
    /// Date().shortDateString // "Jan 15, 2026"
    /// ```
    public var shortDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    /// Returns a time-only representation.
    ///
    /// ```swift
    /// Date().timeString // "10:30 AM"
    /// ```
    public var timeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    /// Returns the full date and time representation.
    public var fullDateTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }

    /// Creates a `Date` from an ISO 8601 string.
    ///
    /// - Parameter string: An ISO 8601 formatted date string.
    /// - Returns: A `Date` if parsing succeeds, otherwise `nil`.
    public static func fromISO8601(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: string)
            ?? ISO8601DateFormatter().date(from: string)
    }

    /// Returns the day of the week as a string.
    ///
    /// ```swift
    /// Date().dayOfWeek // "Wednesday"
    /// ```
    public var dayOfWeek: String {
        formatted(as: "EEEE")
    }
}
