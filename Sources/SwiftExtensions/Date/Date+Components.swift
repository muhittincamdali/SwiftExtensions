import Foundation

// MARK: - Date Component Extensions

public extension Date {
    
    // MARK: - Year Components
    
    /// Returns year component.
    ///
    /// ```swift
    /// date.year    // 2024
    /// ```
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// Checks if year is leap year.
    var isLeapYear: Bool {
        let year = self.year
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    /// Returns number of days in year.
    var daysInYear: Int {
        return isLeapYear ? 366 : 365
    }
    
    /// Returns day of year (1-366).
    var dayOfYear: Int {
        return Calendar.current.ordinality(of: .day, in: .year, for: self) ?? 0
    }
    
    /// Returns week of year.
    var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    // MARK: - Month Components
    
    /// Returns month component (1-12).
    ///
    /// ```swift
    /// date.month    // 1 for January
    /// ```
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// Returns number of days in month.
    var daysInMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    /// Returns number of weeks in month.
    var weeksInMonth: Int {
        return Calendar.current.range(of: .weekOfMonth, in: .month, for: self)?.count ?? 0
    }
    
    /// Returns week of month.
    var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    /// Returns quarter (1-4).
    var quarter: Int {
        return (month - 1) / 3 + 1
    }
    
    // MARK: - Day Components
    
    /// Returns day component (1-31).
    ///
    /// ```swift
    /// date.day    // 15
    /// ```
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Returns weekday (1 = Sunday, 7 = Saturday).
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /// Returns weekday ordinal (e.g., 2nd Tuesday of month).
    var weekdayOrdinal: Int {
        return Calendar.current.component(.weekdayOrdinal, from: self)
    }
    
    /// Returns ISO weekday (1 = Monday, 7 = Sunday).
    var isoWeekday: Int {
        let weekday = self.weekday
        return weekday == 1 ? 7 : weekday - 1
    }
    
    // MARK: - Time Components
    
    /// Returns hour component (0-23).
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// Returns minute component (0-59).
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// Returns second component (0-59).
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// Returns nanosecond component.
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    /// Returns millisecond (0-999).
    var millisecond: Int {
        return nanosecond / 1_000_000
    }
    
    // MARK: - All Components
    
    /// Returns all date components.
    var components: DateComponents {
        return Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday, .weekOfYear],
            from: self
        )
    }
    
    /// Returns specific components.
    ///
    /// - Parameter components: Set of components to extract.
    /// - Returns: DateComponents with specified values.
    func components(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    // MARK: - Time of Day
    
    /// Returns time of day as decimal hours (0-24).
    ///
    /// ```swift
    /// // At 2:30 PM
    /// date.decimalHour    // 14.5
    /// ```
    var decimalHour: Double {
        return Double(hour) + Double(minute) / 60.0 + Double(second) / 3600.0
    }
    
    /// Returns seconds since midnight.
    var secondsSinceMidnight: Int {
        return hour * 3600 + minute * 60 + second
    }
    
    /// Returns minutes since midnight.
    var minutesSinceMidnight: Int {
        return hour * 60 + minute
    }
    
    /// Checks if date is in AM.
    var isAM: Bool {
        return hour < 12
    }
    
    /// Checks if date is in PM.
    var isPM: Bool {
        return hour >= 12
    }
    
    /// Returns 12-hour format hour (1-12).
    var hour12: Int {
        let h = hour % 12
        return h == 0 ? 12 : h
    }
    
    // MARK: - Period of Day
    
    /// Returns period of day.
    var periodOfDay: PeriodOfDay {
        switch hour {
        case 0..<6: return .night
        case 6..<12: return .morning
        case 12..<17: return .afternoon
        case 17..<21: return .evening
        default: return .night
        }
    }
    
    // MARK: - Era
    
    /// Returns era (0 = BC, 1 = AD).
    var era: Int {
        return Calendar.current.component(.era, from: self)
    }
    
    /// Checks if date is in Common Era (AD).
    var isCommonEra: Bool {
        return era == 1
    }
    
    // MARK: - Start and End of Components
    
    /// Returns start of day.
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// Returns end of day (23:59:59).
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }
    
    /// Returns start of week.
    var startOfWeek: Date {
        let components = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Returns end of week.
    var endOfWeek: Date {
        guard let start = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return self
        }
        return start.endOfDay
    }
    
    /// Returns start of month.
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Returns end of month.
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth) ?? self
    }
    
    /// Returns start of year.
    var startOfYear: Date {
        let components = Calendar.current.dateComponents([.year], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Returns end of year.
    var endOfYear: Date {
        var components = DateComponents()
        components.year = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfYear) ?? self
    }
    
    /// Returns start of quarter.
    var startOfQuarter: Date {
        let month = ((self.month - 1) / 3) * 3 + 1
        var components = Calendar.current.dateComponents([.year], from: self)
        components.month = month
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Returns end of quarter.
    var endOfQuarter: Date {
        var components = DateComponents()
        components.month = 3
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfQuarter) ?? self
    }
}

// MARK: - Period of Day Enum

/// Represents periods of the day
public enum PeriodOfDay: String, CaseIterable {
    case night
    case morning
    case afternoon
    case evening
    
    /// Returns localized greeting for period.
    public var greeting: String {
        switch self {
        case .night: return "Good night"
        case .morning: return "Good morning"
        case .afternoon: return "Good afternoon"
        case .evening: return "Good evening"
        }
    }
    
    /// Returns typical hour range for period.
    public var hourRange: ClosedRange<Int> {
        switch self {
        case .night: return 21...5
        case .morning: return 6...11
        case .afternoon: return 12...16
        case .evening: return 17...20
        }
    }
}

// MARK: - Date Creation from Components

public extension Date {
    
    /// Creates date from components.
    ///
    /// - Parameters:
    ///   - year: Year.
    ///   - month: Month (1-12).
    ///   - day: Day (1-31).
    ///   - hour: Hour (0-23).
    ///   - minute: Minute (0-59).
    ///   - second: Second (0-59).
    ///   - calendar: Calendar to use.
    /// - Returns: Date or nil if invalid.
    init?(
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        calendar: Calendar = .current
    ) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        guard let date = calendar.date(from: components) else { return nil }
        self = date
    }
}
