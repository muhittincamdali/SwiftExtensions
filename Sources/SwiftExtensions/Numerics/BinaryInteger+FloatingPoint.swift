extension BinaryInteger {
    /// Rounds a floating-point value to an integer, or returns `nil` when the result does not fit.
    ///
    /// `Int(_:)` stops the app with a fatal error for `.nan`, `.infinity` and values outside the
    /// range of the type, and `Int(exactly:)` refuses every value with a fraction. This
    /// initializer rounds first and then returns `nil` only for a value that has no integer of
    /// this type: NaN, an infinity, or a result outside `min...max`.
    ///
    /// ```swift
    /// let percent = Int(rounding: progress * 100) ?? 0
    /// let index = Int(rounding: offset / rowHeight, .down)
    /// ```
    ///
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - rule: How to round; the default rounds halves away from zero, like `rounded()`.
    public init?<Source: BinaryFloatingPoint>(
        rounding value: Source,
        _ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) {
        guard value.isFinite else { return nil }
        self.init(exactly: value.rounded(rule))
    }
}

extension FixedWidthInteger {
    /// Converts a floating-point value to the nearest representable integer: values beyond the
    /// range become `min` or `max`, and NaN, which has no nearest integer, returns `nil`.
    ///
    /// Use it where an out-of-range value should be held at the edge instead of refused, such
    /// as a slider position, a progress count or a pixel size computed from a scale factor.
    ///
    /// ```swift
    /// let pixels = Int(clamping: width * scale) ?? 0
    /// UInt8(clamping: 300.0) == 255   // true
    /// UInt8(clamping: -2.0) == 0      // true
    /// ```
    ///
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - rule: How to round inside the range; the default drops the fraction, like `Int(_:)`.
    public init?<Source: BinaryFloatingPoint>(
        clamping value: Source,
        rounding rule: FloatingPointRoundingRule = .towardZero
    ) {
        guard !value.isNaN else { return nil }
        let rounded = value.rounded(rule)
        if let exact = Self(exactly: rounded) {
            self = exact
        } else {
            self = rounded > 0 ? .max : .min
        }
    }
}
