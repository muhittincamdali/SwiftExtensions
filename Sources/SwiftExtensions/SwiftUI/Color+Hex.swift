#if canImport(SwiftUI)
import SwiftUI

// MARK: - Color Hex Extensions

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Color {
    
    // MARK: - Hex Initialization
    
    /// Creates color from hex string.
    ///
    /// - Parameter hex: Hex string (with or without #, 3/6/8 characters).
    ///
    /// ```swift
    /// Color(hex: "#FF0000")    // Red
    /// Color(hex: "FF0000")     // Red
    /// Color(hex: "F00")        // Red (shorthand)
    /// Color(hex: "#FF000080")  // Red with 50% alpha
    /// ```
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        var r: Double = 0.0
        var g: Double = 0.0
        var b: Double = 0.0
        var a: Double = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        switch length {
        case 3: // RGB (12-bit)
            r = Double((rgb & 0xF00) >> 8) / 15.0
            g = Double((rgb & 0x0F0) >> 4) / 15.0
            b = Double(rgb & 0x00F) / 15.0
            
        case 6: // RGB (24-bit)
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
            
        case 8: // RGBA (32-bit)
            r = Double((rgb & 0xFF000000) >> 24) / 255.0
            g = Double((rgb & 0x00FF0000) >> 16) / 255.0
            b = Double((rgb & 0x0000FF00) >> 8) / 255.0
            a = Double(rgb & 0x000000FF) / 255.0
            
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    /// Creates color from hex integer.
    ///
    /// - Parameters:
    ///   - hex: Hex integer (e.g., 0xFF0000).
    ///   - opacity: Opacity value (default: 1.0).
    init(hex: Int, opacity: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, opacity: opacity)
    }
    
    // MARK: - Hex Output
    
    /// Returns hex string representation.
    var hexString: String? {
        #if canImport(UIKit)
        guard let components = UIColor(self).cgColor.components else { return nil }
        #elseif canImport(AppKit)
        guard let components = NSColor(self).cgColor?.components else { return nil }
        #else
        return nil
        #endif
        
        let r = Int((components[0] * 255).rounded())
        let g = Int((components.count > 1 ? components[1] : components[0]) * 255).rounded()
        let b = Int((components.count > 2 ? components[2] : components[0]) * 255).rounded()
        
        return String(format: "#%02X%02X%02X", r, g, Int(b))
    }
    
    // MARK: - Color Manipulation
    
    /// Returns lighter version of color.
    ///
    /// - Parameter amount: Lightening amount (0-1).
    /// - Returns: Lighter color.
    func lighter(by amount: Double = 0.2) -> Color {
        return adjust(brightness: amount)
    }
    
    /// Returns darker version of color.
    ///
    /// - Parameter amount: Darkening amount (0-1).
    /// - Returns: Darker color.
    func darker(by amount: Double = 0.2) -> Color {
        return adjust(brightness: -amount)
    }
    
    private func adjust(brightness amount: Double) -> Color {
        #if canImport(UIKit)
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor(self).getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return Color(hue: Double(h), saturation: Double(s), brightness: max(min(Double(b) + amount, 1), 0), opacity: Double(a))
        #else
        return self
        #endif
    }
    
    /// Returns color with modified opacity.
    ///
    /// - Parameter opacity: New opacity value (0-1).
    /// - Returns: Color with new opacity.
    func withOpacity(_ opacity: Double) -> Color {
        return self.opacity(opacity)
    }
    
    // MARK: - Common Colors
    
    /// App primary color placeholder.
    static var appPrimary: Color {
        return Color(hex: 0x007AFF)
    }
    
    /// App secondary color placeholder.
    static var appSecondary: Color {
        return Color(hex: 0x5856D6)
    }
    
    /// App accent color placeholder.
    static var appAccent: Color {
        return Color(hex: 0xFF9500)
    }
    
    /// App success color.
    static var success: Color {
        return Color(hex: 0x34C759)
    }
    
    /// App warning color.
    static var warning: Color {
        return Color(hex: 0xFFCC00)
    }
    
    /// App error/danger color.
    static var error: Color {
        return Color(hex: 0xFF3B30)
    }
    
    /// App info color.
    static var info: Color {
        return Color(hex: 0x5AC8FA)
    }
}

// MARK: - Random Color

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Color {
    
    /// Returns random color.
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    
    /// Returns random pastel color.
    static var randomPastel: Color {
        return Color(
            red: .random(in: 0.5...1),
            green: .random(in: 0.5...1),
            blue: .random(in: 0.5...1)
        )
    }
    
    /// Returns random dark color.
    static var randomDark: Color {
        return Color(
            red: .random(in: 0...0.5),
            green: .random(in: 0...0.5),
            blue: .random(in: 0...0.5)
        )
    }
}
#endif
