import Foundation

extension Date {

    /// Returns `true` if the date is today.
    public var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Returns `true` if the date is yesterday.
    public var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    /// Returns `true` if the date is tomorrow.
    public var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    /// Returns `true` if the date falls on a weekend.
    public var isWeekend: Bool {
        Calendar.current.isDateInWeekend(self)
    }

    /// Returns `true` if both dates fall on the same calendar day.
    ///
    /// - Parameter other: The date to compare against.
    /// - Returns: `true` when both dates share the same year, month, and day.
    public func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    /// Returns the number of days between this date and another.
    ///
    /// ```swift
    /// date1.daysBetween(date2) // 42
    /// ```
    ///
    /// - Parameter other: The target date.
    /// - Returns: The absolute number of days between the two dates.
    public func daysBetween(_ other: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: other)
        return abs(components.day ?? 0)
    }

    /// Returns the start of the day (midnight) for this date.
    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// Returns the end of the day (23:59:59) for this date.
    public var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }

    /// Returns `true` if this date is in the past.
    public var isPast: Bool {
        self < Date()
    }

    /// Returns `true` if this date is in the future.
    public var isFuture: Bool {
        self > Date()
    }

    /// Returns the number of hours between this date and another.
    public func hoursBetween(_ other: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: self, to: other)
        return abs(components.hour ?? 0)
    }

    /// Returns a new date by adding the specified number of days.
    ///
    /// - Parameter days: Number of days to add (negative to subtract).
    /// - Returns: The adjusted date.
    public func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
}
