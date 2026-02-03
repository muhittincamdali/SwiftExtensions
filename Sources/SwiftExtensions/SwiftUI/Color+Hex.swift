import SwiftUI

extension Color {

    /// Creates a color from a hex string.
    ///
    /// ```swift
    /// Color(hex: "#FF5733")
    /// Color(hex: "FF5733")
    /// ```
    ///
    /// - Parameter hex: A hex color string with optional `#` prefix.
    public init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let hexString = cleaned.hasPrefix("#") ? String(cleaned.dropFirst()) : cleaned

        var hexValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hexValue)

        let red, green, blue, alpha: Double

        if hexString.count == 8 {
            red = Double((hexValue & 0xFF000000) >> 24) / 255.0
            green = Double((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = Double((hexValue & 0x0000FF00) >> 8) / 255.0
            alpha = Double(hexValue & 0x000000FF) / 255.0
        } else {
            red = Double((hexValue & 0xFF0000) >> 16) / 255.0
            green = Double((hexValue & 0x00FF00) >> 8) / 255.0
            blue = Double(hexValue & 0x0000FF) / 255.0
            alpha = 1.0
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Creates a color from an integer hex value.
    ///
    /// ```swift
    /// Color(hex: 0xFF5733)
    /// Color(hex: 0xFF5733, opacity: 0.8)
    /// ```
    ///
    /// - Parameters:
    ///   - hex: Integer hex value (e.g., `0xFF5733`).
    ///   - opacity: Opacity level. Defaults to `1.0`.
    public init(hex: Int, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: opacity
        )
    }
}
