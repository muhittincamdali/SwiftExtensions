import Foundation

// MARK: - Date Manipulation Extensions

public extension Date {
    
    // MARK: - Adding/Subtracting Components
    
    /// Adds years to date.
    ///
    /// - Parameter years: Number of years to add.
    /// - Returns: New date with years added.
    func adding(years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
    }
    
    /// Adds months to date.
    ///
    /// - Parameter months: Number of months to add.
    /// - Returns: New date with months added.
    func adding(months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self) ?? self
    }
    
    /// Adds weeks to date.
    ///
    /// - Parameter weeks: Number of weeks to add.
    /// - Returns: New date with weeks added.
    func adding(weeks: Int) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: weeks, to: self) ?? self
    }
    
    /// Adds days to date.
    ///
    /// - Parameter days: Number of days to add.
    /// - Returns: New date with days added.
    ///
    /// ```swift
    /// date.adding(days: 5)     // 5 days later
    /// date.adding(days: -3)    // 3 days earlier
    /// ```
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    /// Adds hours to date.
    ///
    /// - Parameter hours: Number of hours to add.
    /// - Returns: New date with hours added.
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? self
    }
    
    /// Adds minutes to date.
    ///
    /// - Parameter minutes: Number of minutes to add.
    /// - Returns: New date with minutes added.
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
    }
    
    /// Adds seconds to date.
    ///
    /// - Parameter seconds: Number of seconds to add.
    /// - Returns: New date with seconds added.
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self) ?? self
    }
    
    /// Adds multiple components at once.
    ///
    /// - Parameter components: DateComponents to add.
    /// - Returns: New date with components added.
    func adding(_ components: DateComponents) -> Date {
        return Calendar.current.date(byAdding: components, to: self) ?? self
    }
    
    // MARK: - Subtracting Shortcuts
    
    /// Subtracts years from date.
    func subtracting(years: Int) -> Date {
        return adding(years: -years)
    }
    
    /// Subtracts months from date.
    func subtracting(months: Int) -> Date {
        return adding(months: -months)
    }
    
    /// Subtracts weeks from date.
    func subtracting(weeks: Int) -> Date {
        return adding(weeks: -weeks)
    }
    
    /// Subtracts days from date.
    func subtracting(days: Int) -> Date {
        return adding(days: -days)
    }
    
    /// Subtracts hours from date.
    func subtracting(hours: Int) -> Date {
        return adding(hours: -hours)
    }
    
    /// Subtracts minutes from date.
    func subtracting(minutes: Int) -> Date {
        return adding(minutes: -minutes)
    }
    
    /// Subtracts seconds from date.
    func subtracting(seconds: Int) -> Date {
        return adding(seconds: -seconds)
    }
    
    // MARK: - Setting Components
    
    /// Sets year component.
    ///
    /// - Parameter year: Year to set.
    /// - Returns: New date with year set.
    func setting(year: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.year = year
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Sets month component.
    ///
    /// - Parameter month: Month to set (1-12).
    /// - Returns: New date with month set.
    func setting(month: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.month = month
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Sets day component.
    ///
    /// - Parameter day: Day to set (1-31).
    /// - Returns: New date with day set.
    func setting(day: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.day = day
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Sets hour component.
    ///
    /// - Parameter hour: Hour to set (0-23).
    /// - Returns: New date with hour set.
    func setting(hour: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = hour
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Sets minute component.
    ///
    /// - Parameter minute: Minute to set (0-59).
    /// - Returns: New date with minute set.
    func setting(minute: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.minute = minute
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Sets second component.
    ///
    /// - Parameter second: Second to set (0-59).
    /// - Returns: New date with second set.
    func setting(second: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.second = second
        return Calendar.current.date(from: components) ?? self
    }
    
    /// Sets time components.
    ///
    /// - Parameters:
    ///   - hour: Hour (0-23).
    ///   - minute: Minute (0-59).
    ///   - second: Second (0-59).
    /// - Returns: New date with time set.
    func setting(hour: Int, minute: Int, second: Int = 0) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components) ?? self
    }
    
    // MARK: - Next/Previous Occurrences
    
    /// Returns next occurrence of weekday.
    ///
    /// - Parameter weekday: Weekday (1 = Sunday, 7 = Saturday).
    /// - Returns: Next occurrence of weekday.
    func next(weekday: Int) -> Date {
        var components = DateComponents()
        components.weekday = weekday
        
        return Calendar.current.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime
        ) ?? self
    }
    
    /// Returns previous occurrence of weekday.
    ///
    /// - Parameter weekday: Weekday (1 = Sunday, 7 = Saturday).
    /// - Returns: Previous occurrence of weekday.
    func previous(weekday: Int) -> Date {
        var components = DateComponents()
        components.weekday = weekday
        
        return Calendar.current.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime,
            direction: .backward
        ) ?? self
    }
    
    /// Returns next Monday.
    var nextMonday: Date { return next(weekday: 2) }
    
    /// Returns next Friday.
    var nextFriday: Date { return next(weekday: 6) }
    
    /// Returns next weekend (Saturday).
    var nextWeekend: Date { return next(weekday: 7) }
    
    // MARK: - Rounding
    
    /// Rounds date to nearest interval.
    ///
    /// - Parameter minutes: Interval in minutes.
    /// - Returns: Rounded date.
    ///
    /// ```swift
    /// // At 10:13
    /// date.rounded(toNearest: 15)    // 10:15
    /// date.rounded(toNearest: 30)    // 10:00
    /// ```
    func rounded(toNearest minutes: Int) -> Date {
        let seconds = TimeInterval(minutes * 60)
        let roundedInterval = (timeIntervalSinceReferenceDate / seconds).rounded() * seconds
        return Date(timeIntervalSinceReferenceDate: roundedInterval)
    }
    
    /// Rounds date down to interval.
    ///
    /// - Parameter minutes: Interval in minutes.
    /// - Returns: Floored date.
    func floored(toNearest minutes: Int) -> Date {
        let seconds = TimeInterval(minutes * 60)
        let flooredInterval = floor(timeIntervalSinceReferenceDate / seconds) * seconds
        return Date(timeIntervalSinceReferenceDate: flooredInterval)
    }
    
    /// Rounds date up to interval.
    ///
    /// - Parameter minutes: Interval in minutes.
    /// - Returns: Ceiled date.
    func ceiled(toNearest minutes: Int) -> Date {
        let seconds = TimeInterval(minutes * 60)
        let ceiledInterval = ceil(timeIntervalSinceReferenceDate / seconds) * seconds
        return Date(timeIntervalSinceReferenceDate: ceiledInterval)
    }
    
    // MARK: - Date Range Generation
    
    /// Generates array of dates to end date.
    ///
    /// - Parameters:
    ///   - endDate: End date.
    ///   - component: Calendar component to step by.
    ///   - step: Step value.
    /// - Returns: Array of dates.
    func dates(to endDate: Date, by component: Calendar.Component = .day, step: Int = 1) -> [Date] {
        var dates: [Date] = []
        var current = self
        
        while current <= endDate {
            dates.append(current)
            guard let next = Calendar.current.date(byAdding: component, value: step, to: current) else { break }
            current = next
        }
        
        return dates
    }
    
    /// Generates array of dates for N units.
    ///
    /// - Parameters:
    ///   - count: Number of dates.
    ///   - component: Calendar component.
    /// - Returns: Array of dates.
    func dates(count: Int, by component: Calendar.Component = .day) -> [Date] {
        return (0..<count).compactMap { index in
            Calendar.current.date(byAdding: component, value: index, to: self)
        }
    }
    
    // MARK: - Business Days
    
    /// Adds business days (skipping weekends).
    ///
    /// - Parameter days: Number of business days to add.
    /// - Returns: Date after adding business days.
    func addingBusinessDays(_ days: Int) -> Date {
        var count = 0
        var current = self
        let step = days >= 0 ? 1 : -1
        
        while count < abs(days) {
            current = current.adding(days: step)
            if current.isWeekday {
                count += 1
            }
        }
        
        return current
    }
    
    /// Returns number of business days to another date.
    ///
    /// - Parameter date: Target date.
    /// - Returns: Number of business days.
    func businessDays(to date: Date) -> Int {
        var count = 0
        var current = self
        
        let step = date > self ? 1 : -1
        
        while (step > 0 && current < date) || (step < 0 && current > date) {
            current = current.adding(days: step)
            if current.isWeekday {
                count += 1
            }
        }
        
        return count * step
    }
    
    // MARK: - Age Calculation
    
    /// Calculates age in years from this date.
    ///
    /// - Parameter referenceDate: Reference date (default: now).
    /// - Returns: Age in years.
    func age(at referenceDate: Date = Date()) -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: referenceDate).year ?? 0
    }
}

// MARK: - Operators

public extension Date {
    
    /// Adds time interval to date.
    static func + (lhs: Date, rhs: TimeInterval) -> Date {
        return lhs.addingTimeInterval(rhs)
    }
    
    /// Subtracts time interval from date.
    static func - (lhs: Date, rhs: TimeInterval) -> Date {
        return lhs.addingTimeInterval(-rhs)
    }
    
    /// Returns time interval between dates.
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSince(rhs)
    }
}
