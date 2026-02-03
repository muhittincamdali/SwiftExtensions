#if canImport(UIKit)
import UIKit

// MARK: - UIColor Extensions

public extension UIColor {
    
    // MARK: - Hex Initialization
    
    /// Creates color from hex string.
    ///
    /// - Parameter hex: Hex string (with or without #, 3/6/8 characters).
    ///
    /// ```swift
    /// UIColor(hex: "#FF0000")    // Red
    /// UIColor(hex: "FF0000")     // Red
    /// UIColor(hex: "F00")        // Red (shorthand)
    /// UIColor(hex: "#FF000080")  // Red with 50% alpha
    /// ```
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        switch length {
        case 3: // RGB (12-bit)
            r = CGFloat((rgb & 0xF00) >> 8) / 15.0
            g = CGFloat((rgb & 0x0F0) >> 4) / 15.0
            b = CGFloat(rgb & 0x00F) / 15.0
            
        case 6: // RGB (24-bit)
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        case 8: // RGBA (32-bit)
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Creates color from hex integer.
    ///
    /// - Parameters:
    ///   - hex: Hex integer (e.g., 0xFF0000).
    ///   - alpha: Alpha value (default: 1.0).
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    // MARK: - Hex Output
    
    /// Returns hex string representation.
    ///
    /// ```swift
    /// UIColor.red.hexString    // "#FF0000"
    /// ```
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb = (Int(r * 255) << 16) | (Int(g * 255) << 8) | Int(b * 255)
        return String(format: "#%06X", rgb)
    }
    
    /// Returns hex string with alpha.
    var hexStringWithAlpha: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgba = (Int(r * 255) << 24) | (Int(g * 255) << 16) | (Int(b * 255) << 8) | Int(a * 255)
        return String(format: "#%08X", rgba)
    }
    
    // MARK: - Color Components
    
    /// Returns red component (0-1).
    var redComponent: CGFloat {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return r
    }
    
    /// Returns green component (0-1).
    var greenComponent: CGFloat {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return g
    }
    
    /// Returns blue component (0-1).
    var blueComponent: CGFloat {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return b
    }
    
    /// Returns alpha component (0-1).
    var alphaComponent: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    /// Returns RGBA components as tuple.
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    /// Returns HSB components as tuple.
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    // MARK: - Color Manipulation
    
    /// Returns lighter version of color.
    ///
    /// - Parameter amount: Lightening amount (0-1).
    /// - Returns: Lighter color.
    func lighter(by amount: CGFloat = 0.2) -> UIColor {
        return adjustBrightness(by: abs(amount))
    }
    
    /// Returns darker version of color.
    ///
    /// - Parameter amount: Darkening amount (0-1).
    /// - Returns: Darker color.
    func darker(by amount: CGFloat = 0.2) -> UIColor {
        return adjustBrightness(by: -abs(amount))
    }
    
    private func adjustBrightness(by amount: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: max(min(b + amount, 1), 0), alpha: a)
    }
    
    /// Returns saturated version of color.
    ///
    /// - Parameter amount: Saturation increase (0-1).
    /// - Returns: More saturated color.
    func saturated(by amount: CGFloat = 0.2) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: max(min(s + amount, 1), 0), brightness: b, alpha: a)
    }
    
    /// Returns desaturated version of color.
    ///
    /// - Parameter amount: Saturation decrease (0-1).
    /// - Returns: Less saturated color.
    func desaturated(by amount: CGFloat = 0.2) -> UIColor {
        return saturated(by: -amount)
    }
    
    /// Returns color with modified alpha.
    ///
    /// - Parameter alpha: New alpha value (0-1).
    /// - Returns: Color with new alpha.
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
    
    /// Returns inverted color.
    var inverted: UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: 1 - r, green: 1 - g, blue: 1 - b, alpha: a)
    }
    
    /// Returns grayscale version of color.
    var grayscale: UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let gray = 0.299 * r + 0.587 * g + 0.114 * b
        return UIColor(white: gray, alpha: a)
    }
    
    // MARK: - Color Blending
    
    /// Blends with another color.
    ///
    /// - Parameters:
    ///   - color: Color to blend with.
    ///   - amount: Blend amount (0 = self, 1 = other).
    /// - Returns: Blended color.
    func blended(with color: UIColor, amount: CGFloat = 0.5) -> UIColor {
        let amount = max(min(amount, 1), 0)
        
        let c1 = rgba
        let c2 = color.rgba
        
        return UIColor(
            red: c1.red + (c2.red - c1.red) * amount,
            green: c1.green + (c2.green - c1.green) * amount,
            blue: c1.blue + (c2.blue - c1.blue) * amount,
            alpha: c1.alpha + (c2.alpha - c1.alpha) * amount
        )
    }
    
    /// Returns complementary color.
    var complementary: UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: (h + 0.5).truncatingRemainder(dividingBy: 1), saturation: s, brightness: b, alpha: a)
    }
    
    // MARK: - Color Analysis
    
    /// Checks if color is light.
    var isLight: Bool {
        return luminance > 0.5
    }
    
    /// Checks if color is dark.
    var isDark: Bool {
        return !isLight
    }
    
    /// Returns luminance value (0-1).
    var luminance: CGFloat {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: nil)
        return 0.299 * r + 0.587 * g + 0.114 * b
    }
    
    /// Returns contrasting color (black or white).
    var contrastingColor: UIColor {
        return isLight ? .black : .white
    }
    
    // MARK: - Random Colors
    
    /// Returns random color.
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    /// Returns random color with specified alpha.
    static func random(alpha: CGFloat) -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: alpha
        )
    }
}
#endif
