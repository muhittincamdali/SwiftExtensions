import Foundation

extension Int {

    /// Clamps the value to the given range.
    ///
    /// ```swift
    /// 15.clamp(low: 1, high: 10) // 10
    /// 5.clamp(low: 1, high: 10)  // 5
    /// ```
    public func clamp(low: Int, high: Int) -> Int {
        Swift.min(Swift.max(self, low), high)
    }

    /// Returns the ordinal string representation.
    ///
    /// ```swift
    /// 1.ordinal  // "1st"
    /// 22.ordinal // "22nd"
    /// 3.ordinal  // "3rd"
    /// ```
    public var ordinal: String {
        let suffix: String
        let ones = self % 10
        let tens = (self % 100) / 10

        if tens == 1 {
            suffix = "th"
        } else {
            switch ones {
            case 1: suffix = "st"
            case 2: suffix = "nd"
            case 3: suffix = "rd"
            default: suffix = "th"
            }
        }
        return "\(self)\(suffix)"
    }

    /// Returns an abbreviated string for large numbers.
    ///
    /// ```swift
    /// 1_500.abbreviated     // "1.5K"
    /// 2_300_000.abbreviated // "2.3M"
    /// ```
    public var abbreviated: String {
        let abs = abs(self)
        let sign = self < 0 ? "-" : ""
        switch abs {
        case 1_000_000_000...:
            return "\(sign)\(Double(abs) / 1_000_000_000.0)B"
        case 1_000_000...:
            return "\(sign)\(Double(abs) / 1_000_000.0)M"
        case 1_000...:
            return "\(sign)\(Double(abs) / 1_000.0)K"
        default:
            return "\(self)"
        }
    }

    /// Returns `true` if the number is even.
    public var isEven: Bool { self % 2 == 0 }

    /// Returns `true` if the number is odd.
    public var isOdd: Bool { self % 2 != 0 }

    /// Returns `true` if the number is positive.
    public var isPositive: Bool { self > 0 }

    /// Returns `true` if the number is negative.
    public var isNegative: Bool { self < 0 }
}
