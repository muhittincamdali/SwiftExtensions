import Foundation
import CoreGraphics

// MARK: - CGFloat Extensions

public extension CGFloat {
    
    // MARK: - Rounding
    
    /// Rounds to specified decimal places.
    ///
    /// - Parameter places: Number of decimal places.
    /// - Returns: Rounded value.
    func rounded(to places: Int) -> CGFloat {
        let multiplier = pow(10, CGFloat(places))
        return (self * multiplier).rounded() / multiplier
    }
    
    /// Rounds up to specified decimal places.
    func roundedUp(to places: Int) -> CGFloat {
        let multiplier = pow(10, CGFloat(places))
        return ceil(self * multiplier) / multiplier
    }
    
    /// Rounds down to specified decimal places.
    func roundedDown(to places: Int) -> CGFloat {
        let multiplier = pow(10, CGFloat(places))
        return floor(self * multiplier) / multiplier
    }
    
    // MARK: - Clamping
    
    /// Clamps value to range.
    ///
    /// - Parameter range: Closed range to clamp to.
    /// - Returns: Clamped value.
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
    
    /// Clamps value between 0 and 1.
    var clampedToUnit: CGFloat {
        return clamped(to: 0...1)
    }
    
    // MARK: - Mathematical Operations
    
    /// Returns absolute value.
    var abs: CGFloat {
        return Swift.abs(self)
    }
    
    /// Returns ceiling value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// Returns floor value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// Returns square root.
    var sqrt: CGFloat {
        return CoreGraphics.sqrt(self)
    }
    
    /// Returns square of value.
    var squared: CGFloat {
        return self * self
    }
    
    /// Returns cube of value.
    var cubed: CGFloat {
        return self * self * self
    }
    
    /// Returns value raised to power.
    ///
    /// - Parameter power: Exponent.
    /// - Returns: Result of exponentiation.
    func power(_ power: CGFloat) -> CGFloat {
        return pow(self, power)
    }
    
    // MARK: - Angle Conversions
    
    /// Converts degrees to radians.
    var degreesToRadians: CGFloat {
        return self * .pi / 180
    }
    
    /// Converts radians to degrees.
    var radiansToDegrees: CGFloat {
        return self * 180 / .pi
    }
    
    // MARK: - Interpolation
    
    /// Linear interpolation to target value.
    ///
    /// - Parameters:
    ///   - target: Target value.
    ///   - amount: Interpolation amount (0-1).
    /// - Returns: Interpolated value.
    func lerp(to target: CGFloat, amount: CGFloat) -> CGFloat {
        return self + (target - self) * amount.clampedToUnit
    }
    
    /// Maps value from one range to another.
    ///
    /// - Parameters:
    ///   - fromRange: Source range.
    ///   - toRange: Target range.
    /// - Returns: Mapped value.
    func mapped(from fromRange: ClosedRange<CGFloat>, to toRange: ClosedRange<CGFloat>) -> CGFloat {
        let fromLength = fromRange.upperBound - fromRange.lowerBound
        let toLength = toRange.upperBound - toRange.lowerBound
        
        guard fromLength != 0 else { return toRange.lowerBound }
        
        let normalized = (self - fromRange.lowerBound) / fromLength
        return toRange.lowerBound + normalized * toLength
    }
    
    // MARK: - Comparison
    
    /// Checks if value is approximately equal to another.
    ///
    /// - Parameters:
    ///   - other: Value to compare with.
    ///   - tolerance: Allowed difference.
    /// - Returns: `true` if within tolerance.
    func isApproximatelyEqual(to other: CGFloat, tolerance: CGFloat = 0.0001) -> Bool {
        return Swift.abs(self - other) <= tolerance
    }
    
    /// Checks if value is approximately zero.
    var isApproximatelyZero: Bool {
        return isApproximatelyEqual(to: 0)
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
    
    /// Converts to Double.
    var double: Double {
        return Double(self)
    }
    
    /// Converts to Float.
    var float: Float {
        return Float(self)
    }
    
    /// Converts to String.
    var string: String {
        return String(describing: self)
    }
    
    // MARK: - UI Helpers
    
    /// Returns half of value.
    var half: CGFloat {
        return self / 2
    }
    
    /// Returns double of value.
    var doubled: CGFloat {
        return self * 2
    }
    
    /// Returns negative of value.
    var negated: CGFloat {
        return -self
    }
}

// MARK: - Static Constants

public extension CGFloat {
    
    /// Golden ratio (phi).
    static let goldenRatio: CGFloat = 1.618033988749895
    
    /// Square root of 2.
    static let sqrt2: CGFloat = 1.4142135623730951
    
    /// Square root of 3.
    static let sqrt3: CGFloat = 1.7320508075688772
    
    /// Natural logarithm of 2.
    static let ln2: CGFloat = 0.6931471805599453
    
    /// Natural logarithm of 10.
    static let ln10: CGFloat = 2.302585092994046
}
