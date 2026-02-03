#if canImport(UIKit)
import UIKit

extension UIColor {

    /// Creates a color from a hex string.
    ///
    /// ```swift
    /// UIColor(hex: "#FF5733")
    /// UIColor(hex: "FF5733")
    /// ```
    ///
    /// - Parameter hex: A hex color string with optional `#` prefix.
    public convenience init?(hex: String) {
        let cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let hexString = cleaned.hasPrefix("#") ? String(cleaned.dropFirst()) : cleaned

        guard hexString.count == 6 || hexString.count == 8 else { return nil }

        var hexValue: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&hexValue) else { return nil }

        if hexString.count == 8 {
            self.init(
                red: CGFloat((hexValue & 0xFF000000) >> 24) / 255.0,
                green: CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0,
                blue: CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0,
                alpha: CGFloat(hexValue & 0x000000FF) / 255.0
            )
        } else {
            self.init(
                red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        }
    }

    /// Creates a color from an integer hex value.
    ///
    /// ```swift
    /// UIColor(hex: 0xFF5733)
    /// ```
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }

    /// Returns a lighter version of the color.
    ///
    /// - Parameter percentage: Amount to lighten (0.0 to 1.0).
    /// - Returns: A lighter color.
    public func lighter(by percentage: CGFloat = 0.2) -> UIColor {
        adjust(by: abs(percentage))
    }

    /// Returns a darker version of the color.
    ///
    /// - Parameter percentage: Amount to darken (0.0 to 1.0).
    /// - Returns: A darker color.
    public func darker(by percentage: CGFloat = 0.2) -> UIColor {
        adjust(by: -abs(percentage))
    }

    /// Returns the hex string representation of the color.
    ///
    /// ```swift
    /// UIColor.red.hexString // "#FF0000"
    /// ```
    public var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(
            format: "#%02X%02X%02X",
            Int(red * 255),
            Int(green * 255),
            Int(blue * 255)
        )
    }

    private func adjust(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(
            red: min(max(red + percentage, 0), 1),
            green: min(max(green + percentage, 0), 1),
            blue: min(max(blue + percentage, 0), 1),
            alpha: alpha
        )
    }
}
#endif
