import Foundation

// MARK: - Date Comparison Extensions

public extension Date {
    
    // MARK: - Day Comparisons
    
    /// Checks if date is today.
    ///
    /// ```swift
    /// Date().isToday    // true
    /// ```
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Checks if date is yesterday.
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    /// Checks if date is tomorrow.
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    /// Checks if date is in the past.
    var isPast: Bool {
        return self < Date()
    }
    
    /// Checks if date is in the future.
    var isFuture: Bool {
        return self > Date()
    }
    
    /// Checks if date is on the same day as another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: `true` if same day.
    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    /// Checks if date is within the same week as another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: `true` if same week.
    func isSameWeek(as date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    
    /// Checks if date is within the same month as another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: `true` if same month.
    func isSameMonth(as date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    /// Checks if date is within the same year as another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: `true` if same year.
    func isSameYear(as date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    
    // MARK: - Week Comparisons
    
    /// Checks if date is in this week.
    var isThisWeek: Bool {
        return isSameWeek(as: Date())
    }
    
    /// Checks if date is in last week.
    var isLastWeek: Bool {
        guard let lastWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) else {
            return false
        }
        return isSameWeek(as: lastWeek)
    }
    
    /// Checks if date is in next week.
    var isNextWeek: Bool {
        guard let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) else {
            return false
        }
        return isSameWeek(as: nextWeek)
    }
    
    // MARK: - Month Comparisons
    
    /// Checks if date is in this month.
    var isThisMonth: Bool {
        return isSameMonth(as: Date())
    }
    
    /// Checks if date is in last month.
    var isLastMonth: Bool {
        guard let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else {
            return false
        }
        return isSameMonth(as: lastMonth)
    }
    
    /// Checks if date is in next month.
    var isNextMonth: Bool {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date()) else {
            return false
        }
        return isSameMonth(as: nextMonth)
    }
    
    // MARK: - Year Comparisons
    
    /// Checks if date is in this year.
    var isThisYear: Bool {
        return isSameYear(as: Date())
    }
    
    /// Checks if date is in last year.
    var isLastYear: Bool {
        guard let lastYear = Calendar.current.date(byAdding: .year, value: -1, to: Date()) else {
            return false
        }
        return isSameYear(as: lastYear)
    }
    
    /// Checks if date is in next year.
    var isNextYear: Bool {
        guard let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: Date()) else {
            return false
        }
        return isSameYear(as: nextYear)
    }
    
    // MARK: - Weekend/Weekday
    
    /// Checks if date is a weekend (Saturday or Sunday).
    var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    
    /// Checks if date is a weekday (Monday through Friday).
    var isWeekday: Bool {
        return !isWeekend
    }
    
    /// Checks if date is on specific weekday.
    ///
    /// - Parameter weekday: Weekday to check (1 = Sunday, 7 = Saturday).
    /// - Returns: `true` if on specified weekday.
    func isOn(weekday: Int) -> Bool {
        return Calendar.current.component(.weekday, from: self) == weekday
    }
    
    /// Checks if date is Monday.
    var isMonday: Bool { return isOn(weekday: 2) }
    
    /// Checks if date is Tuesday.
    var isTuesday: Bool { return isOn(weekday: 3) }
    
    /// Checks if date is Wednesday.
    var isWednesday: Bool { return isOn(weekday: 4) }
    
    /// Checks if date is Thursday.
    var isThursday: Bool { return isOn(weekday: 5) }
    
    /// Checks if date is Friday.
    var isFriday: Bool { return isOn(weekday: 6) }
    
    /// Checks if date is Saturday.
    var isSaturday: Bool { return isOn(weekday: 7) }
    
    /// Checks if date is Sunday.
    var isSunday: Bool { return isOn(weekday: 1) }
    
    // MARK: - Time Range Comparisons
    
    /// Checks if date is between two dates (inclusive).
    ///
    /// - Parameters:
    ///   - startDate: Start date of range.
    ///   - endDate: End date of range.
    /// - Returns: `true` if date is in range.
    func isBetween(_ startDate: Date, and endDate: Date) -> Bool {
        return self >= startDate && self <= endDate
    }
    
    /// Checks if date is between two dates (exclusive).
    ///
    /// - Parameters:
    ///   - startDate: Start date of range.
    ///   - endDate: End date of range.
    /// - Returns: `true` if date is in range (exclusive).
    func isStrictlyBetween(_ startDate: Date, and endDate: Date) -> Bool {
        return self > startDate && self < endDate
    }
    
    /// Checks if date is within last N days.
    ///
    /// - Parameter days: Number of days.
    /// - Returns: `true` if within last N days.
    func isWithinLast(days: Int) -> Bool {
        guard let pastDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) else {
            return false
        }
        return self >= pastDate && self <= Date()
    }
    
    /// Checks if date is within next N days.
    ///
    /// - Parameter days: Number of days.
    /// - Returns: `true` if within next N days.
    func isWithinNext(days: Int) -> Bool {
        guard let futureDate = Calendar.current.date(byAdding: .day, value: days, to: Date()) else {
            return false
        }
        return self >= Date() && self <= futureDate
    }
    
    // MARK: - Distance Calculations
    
    /// Returns number of days from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of days (positive if self is later).
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Returns number of hours from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of hours.
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns number of minutes from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of minutes.
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns number of seconds from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of seconds.
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns number of weeks from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of weeks.
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    
    /// Returns number of months from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of months.
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns number of years from another date.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Number of years.
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    // MARK: - Comparison Operators
    
    /// Returns earlier of two dates.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Earlier date.
    func earlier(than date: Date) -> Date {
        return self < date ? self : date
    }
    
    /// Returns later of two dates.
    ///
    /// - Parameter date: Date to compare with.
    /// - Returns: Later date.
    func later(than date: Date) -> Date {
        return self > date ? self : date
    }
}

// MARK: - Date Comparison with Tolerance

public extension Date {
    
    /// Checks if date is approximately equal to another date.
    ///
    /// - Parameters:
    ///   - date: Date to compare with.
    ///   - tolerance: Allowed difference in seconds.
    /// - Returns: `true` if within tolerance.
    func isApproximatelyEqual(to date: Date, tolerance: TimeInterval = 60) -> Bool {
        return abs(timeIntervalSince(date)) <= tolerance
    }
    
    /// Checks if date is close to another date (within specified component).
    ///
    /// - Parameters:
    ///   - date: Date to compare with.
    ///   - component: Calendar component for comparison.
    /// - Returns: `true` if same up to component.
    func isClose(to date: Date, toGranularity component: Calendar.Component) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: component)
    }
}
