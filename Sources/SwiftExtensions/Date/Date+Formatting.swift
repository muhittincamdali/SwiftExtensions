import Foundation

// MARK: - Date Formatting Extensions

public extension Date {
    
    // MARK: - ISO 8601 Formatting
    
    /// Returns ISO 8601 formatted string.
    ///
    /// ```swift
    /// date.iso8601    // "2024-01-15T10:30:00Z"
    /// ```
    var iso8601: String {
        return ISO8601DateFormatter().string(from: self)
    }
    
    /// Returns ISO 8601 with fractional seconds.
    var iso8601WithFractionalSeconds: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
    
    /// Creates date from ISO 8601 string.
    ///
    /// - Parameter string: ISO 8601 formatted string.
    init?(iso8601 string: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: string) {
            self = date
            return
        }
        
        formatter.formatOptions = [.withInternetDateTime]
        if let date = formatter.date(from: string) {
            self = date
            return
        }
        
        return nil
    }
    
    // MARK: - Custom Format Strings
    
    /// Formats date with custom format string.
    ///
    /// - Parameters:
    ///   - format: Date format string.
    ///   - locale: Locale for formatting (default: current).
    ///   - timeZone: Time zone (default: current).
    /// - Returns: Formatted date string.
    ///
    /// ```swift
    /// date.formatted("yyyy-MM-dd")           // "2024-01-15"
    /// date.formatted("EEEE, MMMM d, yyyy")   // "Monday, January 15, 2024"
    /// ```
    func formatted(_ format: String, locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
    
    /// Creates date from string with format.
    ///
    /// - Parameters:
    ///   - string: Date string.
    ///   - format: Format string.
    ///   - locale: Locale for parsing.
    /// - Returns: Parsed date or nil.
    init?(string: String, format: String, locale: Locale = Locale(identifier: "en_US_POSIX")) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        
        guard let date = formatter.date(from: string) else { return nil }
        self = date
    }
    
    // MARK: - Predefined Formats
    
    /// Returns date as "yyyy-MM-dd".
    var dateOnly: String {
        return formatted("yyyy-MM-dd")
    }
    
    /// Returns time as "HH:mm:ss".
    var timeOnly: String {
        return formatted("HH:mm:ss")
    }
    
    /// Returns time as "HH:mm".
    var shortTime: String {
        return formatted("HH:mm")
    }
    
    /// Returns date and time as "yyyy-MM-dd HH:mm:ss".
    var dateTime: String {
        return formatted("yyyy-MM-dd HH:mm:ss")
    }
    
    /// Returns full date like "Monday, January 15, 2024".
    var fullDate: String {
        return formatted("EEEE, MMMM d, yyyy")
    }
    
    /// Returns medium date like "Jan 15, 2024".
    var mediumDate: String {
        return formatted("MMM d, yyyy")
    }
    
    /// Returns short date like "1/15/24".
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    /// Returns month and year like "January 2024".
    var monthYear: String {
        return formatted("MMMM yyyy")
    }
    
    /// Returns day and month like "15 January".
    var dayMonth: String {
        return formatted("d MMMM")
    }
    
    /// Returns weekday name like "Monday".
    var weekdayName: String {
        return formatted("EEEE")
    }
    
    /// Returns short weekday name like "Mon".
    var shortWeekdayName: String {
        return formatted("EEE")
    }
    
    /// Returns month name like "January".
    var monthName: String {
        return formatted("MMMM")
    }
    
    /// Returns short month name like "Jan".
    var shortMonthName: String {
        return formatted("MMM")
    }
    
    // MARK: - Relative Formatting
    
    /// Returns relative time string like "2 hours ago".
    ///
    /// ```swift
    /// date.relativeTime    // "2 hours ago", "in 3 days", "yesterday"
    /// ```
    var relativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    /// Returns short relative time like "2h ago".
    var shortRelativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    /// Returns relative time with custom reference date.
    ///
    /// - Parameter referenceDate: Date to compare against.
    /// - Returns: Relative time string.
    func relativeTime(to referenceDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: referenceDate)
    }
    
    /// Returns human-readable time difference.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Human-readable string like "3 days, 2 hours".
    func timeDifference(from date: Date = Date()) -> String {
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: min(self, date),
            to: max(self, date)
        )
        
        var parts: [String] = []
        
        if let years = components.year, years > 0 {
            parts.append("\(years) year\(years == 1 ? "" : "s")")
        }
        if let months = components.month, months > 0 {
            parts.append("\(months) month\(months == 1 ? "" : "s")")
        }
        if let days = components.day, days > 0 {
            parts.append("\(days) day\(days == 1 ? "" : "s")")
        }
        if let hours = components.hour, hours > 0 && parts.count < 2 {
            parts.append("\(hours) hour\(hours == 1 ? "" : "s")")
        }
        if let minutes = components.minute, minutes > 0 && parts.count < 2 {
            parts.append("\(minutes) minute\(minutes == 1 ? "" : "s")")
        }
        if parts.isEmpty, let seconds = components.second {
            parts.append("\(seconds) second\(seconds == 1 ? "" : "s")")
        }
        
        return parts.prefix(2).joined(separator: ", ")
    }
    
    // MARK: - Localized Formatting
    
    /// Returns localized date string.
    ///
    /// - Parameters:
    ///   - dateStyle: Date style.
    ///   - timeStyle: Time style.
    ///   - locale: Locale for formatting.
    /// - Returns: Localized string.
    func localized(
        dateStyle: DateFormatter.Style = .medium,
        timeStyle: DateFormatter.Style = .none,
        locale: Locale = .current
    ) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    /// Returns date formatted for specific locale.
    ///
    /// - Parameter localeIdentifier: Locale identifier (e.g., "de_DE").
    /// - Returns: Localized date string.
    func localized(for localeIdentifier: String) -> String {
        return localized(locale: Locale(identifier: localeIdentifier))
    }
    
    // MARK: - Unix Timestamp
    
    /// Returns Unix timestamp (seconds since 1970).
    var unixTimestamp: TimeInterval {
        return timeIntervalSince1970
    }
    
    /// Returns Unix timestamp in milliseconds.
    var unixTimestampMillis: Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
    
    /// Creates date from Unix timestamp.
    ///
    /// - Parameter timestamp: Unix timestamp in seconds.
    init(unixTimestamp: TimeInterval) {
        self.init(timeIntervalSince1970: timestamp)
    }
    
    /// Creates date from Unix timestamp in milliseconds.
    ///
    /// - Parameter millis: Unix timestamp in milliseconds.
    init(unixTimestampMillis: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(millis) / 1000)
    }
    
    // MARK: - Time Zone Conversions
    
    /// Converts date to string in specific time zone.
    ///
    /// - Parameters:
    ///   - timeZone: Target time zone.
    ///   - format: Date format string.
    /// - Returns: Formatted string in time zone.
    func string(in timeZone: TimeZone, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return formatted(format, timeZone: timeZone)
    }
    
    /// Returns date string in UTC.
    var utcString: String {
        return string(in: TimeZone(identifier: "UTC")!)
    }
    
    /// Returns date string in local time zone.
    var localString: String {
        return string(in: .current)
    }
}

// MARK: - Date Formatter Cache

/// Thread-safe date formatter cache for performance
public final class DateFormatterCache {
    public static let shared = DateFormatterCache()
    
    private var formatters: [String: DateFormatter] = [:]
    private let queue = DispatchQueue(label: "com.swiftextensions.dateformattercache", attributes: .concurrent)
    
    private init() {}
    
    /// Returns cached formatter for format string.
    ///
    /// - Parameters:
    ///   - format: Date format string.
    ///   - locale: Locale for formatter.
    /// - Returns: Cached date formatter.
    public func formatter(for format: String, locale: Locale = .current) -> DateFormatter {
        let key = "\(format)-\(locale.identifier)"
        
        return queue.sync {
            if let formatter = formatters[key] {
                return formatter
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = locale
            
            queue.async(flags: .barrier) {
                self.formatters[key] = formatter
            }
            
            return formatter
        }
    }
    
    /// Clears all cached formatters.
    public func clearCache() {
        queue.async(flags: .barrier) {
            self.formatters.removeAll()
        }
    }
}

// MARK: - Date Extension Using Cache

public extension Date {
    
    /// Formats date using cached formatter (better performance for repeated use).
    ///
    /// - Parameter format: Date format string.
    /// - Returns: Formatted date string.
    func cachedFormat(_ format: String) -> String {
        return DateFormatterCache.shared.formatter(for: format).string(from: self)
    }
}
