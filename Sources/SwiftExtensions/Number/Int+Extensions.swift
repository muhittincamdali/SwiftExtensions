import Foundation

// MARK: - Int Extensions

public extension Int {
    
    // MARK: - Clamping
    
    /// Clamps value to range.
    ///
    /// - Parameter range: Closed range to clamp to.
    /// - Returns: Clamped value.
    ///
    /// ```swift
    /// 15.clamped(to: 0...10)    // 10
    /// (-5).clamped(to: 0...10)  // 0
    /// 5.clamped(to: 0...10)     // 5
    /// ```
    func clamped(to range: ClosedRange<Int>) -> Int {
        return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
    
    /// Clamps value between min and max.
    ///
    /// - Parameters:
    ///   - min: Minimum value.
    ///   - max: Maximum value.
    /// - Returns: Clamped value.
    func clamped(min: Int, max: Int) -> Int {
        return clamped(to: min...max)
    }
    
    // MARK: - Ordinal Numbers
    
    /// Returns ordinal string representation.
    ///
    /// ```swift
    /// 1.ordinal    // "1st"
    /// 2.ordinal    // "2nd"
    /// 3.ordinal    // "3rd"
    /// 4.ordinal    // "4th"
    /// 11.ordinal   // "11th"
    /// 21.ordinal   // "21st"
    /// ```
    var ordinal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// Returns ordinal suffix ("st", "nd", "rd", "th").
    var ordinalSuffix: String {
        let absValue = abs(self)
        let lastTwo = absValue % 100
        let lastOne = absValue % 10
        
        if lastTwo >= 11 && lastTwo <= 13 {
            return "th"
        }
        
        switch lastOne {
        case 1: return "st"
        case 2: return "nd"
        case 3: return "rd"
        default: return "th"
        }
    }
    
    // MARK: - Number Formatting
    
    /// Returns formatted string with thousands separator.
    ///
    /// ```swift
    /// 1234567.formatted    // "1,234,567"
    /// ```
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// Formats with specific number of digits (zero-padded).
    ///
    /// - Parameter digits: Minimum number of digits.
    /// - Returns: Zero-padded string.
    ///
    /// ```swift
    /// 42.formatted(digits: 4)    // "0042"
    /// ```
    func formatted(digits: Int) -> String {
        return String(format: "%0\(digits)d", self)
    }
    
    /// Returns spelled out string.
    ///
    /// ```swift
    /// 42.spelledOut    // "forty-two"
    /// ```
    var spelledOut: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// Returns Roman numeral representation.
    ///
    /// ```swift
    /// 2024.romanNumeral    // "MMXXIV"
    /// ```
    var romanNumeral: String? {
        guard self > 0 && self < 4000 else { return nil }
        
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        
        var result = ""
        var remaining = self
        
        for (index, value) in values.enumerated() {
            while remaining >= value {
                result += numerals[index]
                remaining -= value
            }
        }
        
        return result
    }
    
    // MARK: - Byte Formatting
    
    /// Returns formatted byte size string.
    ///
    /// ```swift
    /// 1024.byteSize           // "1 KB"
    /// 1048576.byteSize        // "1 MB"
    /// 1073741824.byteSize     // "1 GB"
    /// ```
    var byteSize: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .binary
        return formatter.string(fromByteCount: Int64(self))
    }
    
    /// Returns formatted file size string.
    var fileSize: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(self))
    }
    
    // MARK: - Mathematical Properties
    
    /// Checks if number is even.
    var isEven: Bool {
        return self % 2 == 0
    }
    
    /// Checks if number is odd.
    var isOdd: Bool {
        return self % 2 != 0
    }
    
    /// Checks if number is positive.
    var isPositive: Bool {
        return self > 0
    }
    
    /// Checks if number is negative.
    var isNegative: Bool {
        return self < 0
    }
    
    /// Checks if number is prime.
    var isPrime: Bool {
        guard self > 1 else { return false }
        guard self > 3 else { return true }
        guard self % 2 != 0 && self % 3 != 0 else { return false }
        
        var i = 5
        while i * i <= self {
            if self % i == 0 || self % (i + 2) == 0 {
                return false
            }
            i += 6
        }
        return true
    }
    
    /// Returns factorial (n!).
    ///
    /// ```swift
    /// 5.factorial    // 120
    /// ```
    var factorial: Int {
        guard self > 0 else { return 1 }
        return (1...self).reduce(1, *)
    }
    
    /// Returns array of digits.
    ///
    /// ```swift
    /// 12345.digits    // [1, 2, 3, 4, 5]
    /// ```
    var digits: [Int] {
        return String(abs(self)).compactMap { $0.wholeNumberValue }
    }
    
    /// Returns sum of digits.
    var digitSum: Int {
        return digits.reduce(0, +)
    }
    
    /// Returns number of digits.
    var digitCount: Int {
        return digits.count
    }
    
    // MARK: - Divisibility
    
    /// Checks if divisible by another number.
    ///
    /// - Parameter divisor: Number to divide by.
    /// - Returns: `true` if divisible.
    func isDivisible(by divisor: Int) -> Bool {
        guard divisor != 0 else { return false }
        return self % divisor == 0
    }
    
    /// Returns all divisors.
    var divisors: [Int] {
        guard self > 0 else { return [] }
        
        var result: [Int] = []
        let sqrtValue = Int(Double(self).squareRoot())
        
        for i in 1...sqrtValue {
            if self % i == 0 {
                result.append(i)
                if i != self / i {
                    result.append(self / i)
                }
            }
        }
        
        return result.sorted()
    }
    
    /// Returns greatest common divisor with another number.
    func gcd(with other: Int) -> Int {
        var a = abs(self)
        var b = abs(other)
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    /// Returns least common multiple with another number.
    func lcm(with other: Int) -> Int {
        guard self != 0 && other != 0 else { return 0 }
        return abs(self * other) / gcd(with: other)
    }
    
    // MARK: - Iteration
    
    /// Executes closure specified number of times.
    ///
    /// - Parameter body: Closure to execute.
    ///
    /// ```swift
    /// 5.times { print("Hello") }
    /// ```
    func times(_ body: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            body()
        }
    }
    
    /// Executes closure with index.
    ///
    /// - Parameter body: Closure with index parameter.
    func times(_ body: (Int) -> Void) {
        guard self > 0 else { return }
        for i in 0..<self {
            body(i)
        }
    }
    
    // MARK: - Conversion
    
    /// Converts to Double.
    var double: Double {
        return Double(self)
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
    
    /// Returns UInt if non-negative.
    var uInt: UInt? {
        return self >= 0 ? UInt(self) : nil
    }
    
    // MARK: - Range Generation
    
    /// Creates range from 0 to self.
    ///
    /// ```swift
    /// 5.range    // 0..<5
    /// ```
    var range: Range<Int> {
        return 0..<Swift.max(0, self)
    }
    
    /// Creates closed range from 1 to self.
    var closedRange: ClosedRange<Int>? {
        guard self >= 1 else { return nil }
        return 1...self
    }
}

// MARK: - Binary/Hex Representation

public extension Int {
    
    /// Returns binary string representation.
    ///
    /// ```swift
    /// 42.binary    // "101010"
    /// ```
    var binary: String {
        return String(self, radix: 2)
    }
    
    /// Returns hexadecimal string representation.
    ///
    /// ```swift
    /// 255.hex    // "ff"
    /// ```
    var hex: String {
        return String(self, radix: 16)
    }
    
    /// Returns octal string representation.
    var octal: String {
        return String(self, radix: 8)
    }
    
    /// Creates Int from binary string.
    ///
    /// - Parameter binary: Binary string.
    init?(binary: String) {
        self.init(binary, radix: 2)
    }
    
    /// Creates Int from hex string.
    ///
    /// - Parameter hex: Hexadecimal string.
    init?(hex: String) {
        var hexString = hex
        if hexString.hasPrefix("0x") {
            hexString = String(hexString.dropFirst(2))
        }
        self.init(hexString, radix: 16)
    }
}
