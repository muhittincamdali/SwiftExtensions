import Foundation

extension Double {

    /// Rounds the value to the specified number of decimal places.
    ///
    /// ```swift
    /// 3.14159.rounded(toPlaces: 2) // 3.14
    /// ```
    ///
    /// - Parameter places: Number of decimal places.
    /// - Returns: Rounded value.
    public func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Formats the value as a currency string.
    ///
    /// ```swift
    /// 1234.56.currencyString(code: "USD") // "$1,234.56"
    /// ```
    ///
    /// - Parameter code: ISO 4217 currency code.
    /// - Returns: Formatted currency string.
    public func currencyString(code: String = "USD") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }

    /// Returns the value as a percentage string.
    ///
    /// ```swift
    /// 0.756.percentageString // "75.6%"
    /// ```
    public var percentageString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: self)) ?? "\(self * 100)%"
    }

    /// Clamps the value to the given closed range.
    ///
    /// - Parameter range: The allowed range.
    /// - Returns: Clamped value.
    public func clamped(to range: ClosedRange<Double>) -> Double {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }

    /// Returns `true` if the value is approximately equal to another within a tolerance.
    ///
    /// - Parameters:
    ///   - other: The value to compare against.
    ///   - tolerance: Maximum allowed difference. Defaults to `1e-10`.
    public func isApproximatelyEqual(to other: Double, tolerance: Double = 1e-10) -> Bool {
        Swift.abs(self - other) <= tolerance
    }
}
