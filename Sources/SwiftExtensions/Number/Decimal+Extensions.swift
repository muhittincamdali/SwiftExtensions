import Foundation

// MARK: - Decimal Extensions

public extension Decimal {
    
    // MARK: - Rounding
    
    /// Rounds to specified decimal places.
    ///
    /// - Parameters:
    ///   - places: Number of decimal places.
    ///   - mode: Rounding mode (default: plain).
    /// - Returns: Rounded value.
    ///
    /// ```swift
    /// Decimal(3.14159).rounded(to: 2)    // 3.14
    /// ```
    func rounded(to places: Int, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var result = Decimal()
        var value = self
        NSDecimalRound(&result, &value, places, mode)
        return result
    }
    
    /// Rounds up to specified decimal places.
    func roundedUp(to places: Int) -> Decimal {
        return rounded(to: places, mode: .up)
    }
    
    /// Rounds down to specified decimal places.
    func roundedDown(to places: Int) -> Decimal {
        return rounded(to: places, mode: .down)
    }
    
    /// Rounds using banker's rounding.
    func roundedBankers(to places: Int) -> Decimal {
        return rounded(to: places, mode: .bankers)
    }
    
    // MARK: - Currency Formatting
    
    /// Returns formatted currency string.
    ///
    /// - Parameters:
    ///   - locale: Locale for formatting.
    ///   - currencyCode: ISO currency code.
    /// - Returns: Formatted currency string.
    func asCurrency(locale: Locale = .current, currencyCode: String? = nil) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        if let code = currencyCode {
            formatter.currencyCode = code
        }
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
    
    /// Returns formatted currency string with specific symbol.
    func asCurrency(symbol: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
    
    // MARK: - Number Formatting
    
    /// Returns formatted string with thousands separator.
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
    
    /// Returns formatted string with specific decimal places.
    ///
    /// - Parameter decimalPlaces: Number of decimal places.
    /// - Returns: Formatted string.
    func formatted(decimalPlaces: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimalPlaces
        formatter.maximumFractionDigits = decimalPlaces
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
    
    // MARK: - Percentage Formatting
    
    /// Returns formatted percentage string.
    var asPercentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self * 100)%"
    }
    
    // MARK: - Comparison
    
    /// Checks if value is zero.
    var isZero: Bool {
        return self == Decimal.zero
    }
    
    /// Checks if value is positive.
    var isPositive: Bool {
        return self > Decimal.zero
    }
    
    /// Checks if value is negative.
    var isNegative: Bool {
        return self < Decimal.zero
    }
    
    /// Returns absolute value.
    var abs: Decimal {
        return isNegative ? -self : self
    }
    
    // MARK: - Mathematical Operations
    
    /// Returns value raised to integer power.
    ///
    /// - Parameter power: Integer exponent.
    /// - Returns: Result of exponentiation.
    func power(_ power: Int) -> Decimal {
        return pow(self, power)
    }
    
    /// Returns square of value.
    var squared: Decimal {
        return self * self
    }
    
    // MARK: - Conversion
    
    /// Converts to Double.
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
    
    /// Converts to Int (truncated).
    var intValue: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
    
    /// Converts to String.
    var stringValue: String {
        return NSDecimalNumber(decimal: self).stringValue
    }
    
    // MARK: - Initialization
    
    /// Creates Decimal from string.
    ///
    /// - Parameter string: String representation.
    init?(string: String) {
        if let decimal = Decimal(string: string) {
            self = decimal
        } else {
            return nil
        }
    }
}

// MARK: - Decimal Number Helpers

public extension NSDecimalNumber {
    
    /// Returns rounded decimal number.
    ///
    /// - Parameters:
    ///   - scale: Number of decimal places.
    ///   - mode: Rounding mode.
    /// - Returns: Rounded decimal number.
    func rounded(scale: Int16, mode: RoundingMode = .plain) -> NSDecimalNumber {
        let handler = NSDecimalNumberHandler(
            roundingMode: mode,
            scale: scale,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        return rounding(accordingToBehavior: handler)
    }
    
    /// Checks if value is negative.
    var isNegative: Bool {
        return compare(NSDecimalNumber.zero) == .orderedAscending
    }
    
    /// Checks if value is positive.
    var isPositive: Bool {
        return compare(NSDecimalNumber.zero) == .orderedDescending
    }
    
    /// Checks if value is zero.
    var isZero: Bool {
        return compare(NSDecimalNumber.zero) == .orderedSame
    }
}

// MARK: - Decimal Arithmetic Operators

public extension Decimal {
    
    /// Adds two decimals with rounding.
    ///
    /// - Parameters:
    ///   - lhs: First decimal.
    ///   - rhs: Second decimal.
    ///   - scale: Decimal places for result.
    /// - Returns: Rounded sum.
    static func add(_ lhs: Decimal, _ rhs: Decimal, scale: Int) -> Decimal {
        return (lhs + rhs).rounded(to: scale)
    }
    
    /// Subtracts decimals with rounding.
    static func subtract(_ lhs: Decimal, _ rhs: Decimal, scale: Int) -> Decimal {
        return (lhs - rhs).rounded(to: scale)
    }
    
    /// Multiplies decimals with rounding.
    static func multiply(_ lhs: Decimal, _ rhs: Decimal, scale: Int) -> Decimal {
        return (lhs * rhs).rounded(to: scale)
    }
    
    /// Divides decimals with rounding.
    static func divide(_ lhs: Decimal, _ rhs: Decimal, scale: Int) -> Decimal? {
        guard rhs != Decimal.zero else { return nil }
        return (lhs / rhs).rounded(to: scale)
    }
}
