import Foundation

// MARK: - Double Extensions

public extension Double {
    
    // MARK: - Rounding
    
    /// Rounds to specified decimal places.
    ///
    /// - Parameter places: Number of decimal places.
    /// - Returns: Rounded value.
    ///
    /// ```swift
    /// 3.14159.rounded(to: 2)    // 3.14
    /// 3.14159.rounded(to: 4)    // 3.1416
    /// ```
    func rounded(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
    
    /// Rounds up to specified decimal places.
    func roundedUp(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        return ceil(self * multiplier) / multiplier
    }
    
    /// Rounds down to specified decimal places.
    func roundedDown(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        return floor(self * multiplier) / multiplier
    }
    
    // MARK: - Currency Formatting
    
    /// Returns formatted currency string.
    ///
    /// - Parameters:
    ///   - locale: Locale for formatting.
    ///   - currencyCode: ISO currency code (optional).
    /// - Returns: Formatted currency string.
    ///
    /// ```swift
    /// 1234.56.asCurrency()                      // "$1,234.56"
    /// 1234.56.asCurrency(currencyCode: "EUR")   // "€1,234.56"
    /// ```
    func asCurrency(locale: Locale = .current, currencyCode: String? = nil) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        if let code = currencyCode {
            formatter.currencyCode = code
        }
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// Returns formatted currency string with specific symbol.
    ///
    /// - Parameter symbol: Currency symbol (e.g., "$", "€").
    /// - Returns: Formatted string.
    func asCurrency(symbol: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    // MARK: - Percentage Formatting
    
    /// Returns formatted percentage string.
    ///
    /// ```swift
    /// 0.75.asPercentage    // "75%"
    /// 0.756.asPercentage   // "76%"
    /// ```
    var asPercentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: self)) ?? "\(self * 100)%"
    }
    
    /// Returns percentage string with decimal places.
    ///
    /// - Parameter decimalPlaces: Number of decimal places.
    /// - Returns: Formatted percentage string.
    func asPercentage(decimalPlaces: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = decimalPlaces
        formatter.maximumFractionDigits = decimalPlaces
        return formatter.string(from: NSNumber(value: self)) ?? "\(self * 100)%"
    }
    
    // MARK: - Scientific Notation
    
    /// Returns scientific notation string.
    ///
    /// ```swift
    /// 1234567.0.scientific    // "1.234567E6"
    /// ```
    var scientific: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    // MARK: - Number Formatting
    
    /// Returns formatted string with thousands separator.
    ///
    /// ```swift
    /// 1234567.89.formatted    // "1,234,567.89"
    /// ```
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// Returns formatted string with specific decimal places.
    ///
    /// - Parameter decimalPlaces: Number of decimal places.
    /// - Returns: Formatted string.
    func formatted(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
    
    // MARK: - Clamping
    
    /// Clamps value to range.
    ///
    /// - Parameter range: Closed range to clamp to.
    /// - Returns: Clamped value.
    func clamped(to range: ClosedRange<Double>) -> Double {
        return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
    
    /// Clamps value between 0 and 1.
    var clampedToUnit: Double {
        return clamped(to: 0...1)
    }
    
    // MARK: - Mathematical Operations
    
    /// Returns absolute value.
    var abs: Double {
        return Swift.abs(self)
    }
    
    /// Returns ceiling value.
    var ceil: Double {
        return Foundation.ceil(self)
    }
    
    /// Returns floor value.
    var floor: Double {
        return Foundation.floor(self)
    }
    
    /// Returns square root.
    var sqrt: Double {
        return Foundation.sqrt(self)
    }
    
    /// Returns square of value.
    var squared: Double {
        return self * self
    }
    
    /// Returns cube of value.
    var cubed: Double {
        return self * self * self
    }
    
    /// Returns value raised to power.
    ///
    /// - Parameter power: Exponent.
    /// - Returns: Result of exponentiation.
    func power(_ power: Double) -> Double {
        return pow(self, power)
    }
    
    // MARK: - Angle Conversions
    
    /// Converts degrees to radians.
    var degreesToRadians: Double {
        return self * .pi / 180
    }
    
    /// Converts radians to degrees.
    var radiansToDegrees: Double {
        return self * 180 / .pi
    }
    
    // MARK: - Trigonometric Functions
    
    /// Returns sine of value (in radians).
    var sin: Double {
        return Foundation.sin(self)
    }
    
    /// Returns cosine of value (in radians).
    var cos: Double {
        return Foundation.cos(self)
    }
    
    /// Returns tangent of value (in radians).
    var tan: Double {
        return Foundation.tan(self)
    }
    
    // MARK: - Comparison
    
    /// Checks if value is approximately equal to another.
    ///
    /// - Parameters:
    ///   - other: Value to compare with.
    ///   - tolerance: Allowed difference.
    /// - Returns: `true` if within tolerance.
    func isApproximatelyEqual(to other: Double, tolerance: Double = 1e-10) -> Bool {
        return Swift.abs(self - other) <= tolerance
    }
    
    /// Checks if value is zero (within tolerance).
    var isApproximatelyZero: Bool {
        return isApproximatelyEqual(to: 0)
    }
    
    // MARK: - Interpolation
    
    /// Linear interpolation to target value.
    ///
    /// - Parameters:
    ///   - target: Target value.
    ///   - amount: Interpolation amount (0-1).
    /// - Returns: Interpolated value.
    ///
    /// ```swift
    /// 0.0.lerp(to: 100, amount: 0.5)    // 50.0
    /// ```
    func lerp(to target: Double, amount: Double) -> Double {
        return self + (target - self) * amount.clampedToUnit
    }
    
    /// Inverse linear interpolation.
    ///
    /// - Parameters:
    ///   - start: Range start.
    ///   - end: Range end.
    /// - Returns: Position of value in range (0-1).
    func inverseLerp(start: Double, end: Double) -> Double {
        guard start != end else { return 0 }
        return (self - start) / (end - start)
    }
    
    /// Maps value from one range to another.
    ///
    /// - Parameters:
    ///   - fromRange: Source range.
    ///   - toRange: Target range.
    /// - Returns: Mapped value.
    func mapped(from fromRange: ClosedRange<Double>, to toRange: ClosedRange<Double>) -> Double {
        let fromLength = fromRange.upperBound - fromRange.lowerBound
        let toLength = toRange.upperBound - toRange.lowerBound
        
        guard fromLength != 0 else { return toRange.lowerBound }
        
        let normalized = (self - fromRange.lowerBound) / fromLength
        return toRange.lowerBound + normalized * toLength
    }
    
    // MARK: - Conversion
    
    /// Converts to Int (truncated).
    var int: Int {
        return Int(self)
    }
    
    /// Converts to Int (rounded).
    var roundedInt: Int {
        return Int(rounded())
    }
    
    /// Converts to Float.
    var float: Float {
        return Float(self)
    }
    
    /// Converts to CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// Converts to String.
    var string: String {
        return String(self)
    }
}

// MARK: - Duration Formatting

public extension Double {
    
    /// Interprets value as seconds and returns formatted duration.
    ///
    /// ```swift
    /// 3661.0.durationString    // "1:01:01"
    /// 125.0.durationString     // "2:05"
    /// ```
    var durationString: String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
    
    /// Returns human-readable duration string.
    ///
    /// ```swift
    /// 3661.0.humanReadableDuration    // "1 hour, 1 minute, 1 second"
    /// ```
    var humanReadableDuration: String {
        let totalSeconds = Int(self)
        
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        var parts: [String] = []
        
        if hours > 0 {
            parts.append("\(hours) hour\(hours == 1 ? "" : "s")")
        }
        if minutes > 0 {
            parts.append("\(minutes) minute\(minutes == 1 ? "" : "s")")
        }
        if seconds > 0 || parts.isEmpty {
            parts.append("\(seconds) second\(seconds == 1 ? "" : "s")")
        }
        
        return parts.joined(separator: ", ")
    }
}

// MARK: - File Size Formatting

public extension Double {
    
    /// Interprets value as bytes and returns formatted size.
    ///
    /// ```swift
    /// 1048576.0.byteSize    // "1 MB"
    /// ```
    var byteSize: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .binary
        return formatter.string(fromByteCount: Int64(self))
    }
}
