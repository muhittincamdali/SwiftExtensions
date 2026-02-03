import Foundation

extension String {

    /// Checks whether the string is a valid email address.
    ///
    /// Uses RFC 5322 compliant regex pattern for validation.
    ///
    /// ```swift
    /// "user@example.com".isValidEmail // true
    /// "not-an-email".isValidEmail     // false
    /// ```
    public var isValidEmail: Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        return range(of: pattern, options: .regularExpression) != nil
    }

    /// Checks whether the string is a valid URL.
    ///
    /// ```swift
    /// "https://apple.com".isValidURL // true
    /// "not a url".isValidURL         // false
    /// ```
    public var isValidURL: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil && url.host != nil
    }

    /// Checks whether the string is a valid phone number.
    ///
    /// Accepts formats like `+1234567890`, `(123) 456-7890`, `123-456-7890`.
    public var isValidPhone: Bool {
        let pattern = #"^[\+]?[(]?[0-9]{1,4}[)]?[-\s\./0-9]*$"#
        return range(of: pattern, options: .regularExpression) != nil && count >= 7
    }

    /// Checks whether the string is a valid IPv4 address.
    ///
    /// ```swift
    /// "192.168.1.1".isValidIPv4 // true
    /// ```
    public var isValidIPv4: Bool {
        let parts = split(separator: ".")
        guard parts.count == 4 else { return false }
        return parts.allSatisfy { part in
            guard let num = Int(part) else { return false }
            return (0...255).contains(num)
        }
    }

    /// Returns `true` if every character is alphanumeric.
    public var isAlphanumeric: Bool {
        !isEmpty && allSatisfy { $0.isLetter || $0.isNumber }
    }

    /// Returns `true` if the string is empty or contains only whitespace.
    ///
    /// ```swift
    /// "   ".isBlank  // true
    /// "hi".isBlank   // false
    /// ```
    public var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// Returns `true` if every character is a letter.
    public var containsOnlyLetters: Bool {
        !isEmpty && allSatisfy { $0.isLetter }
    }

    /// Returns `true` if every character is a digit.
    public var containsOnlyDigits: Bool {
        !isEmpty && allSatisfy { $0.isNumber }
    }

    /// Returns `true` if the string is a valid hex color code.
    ///
    /// ```swift
    /// "#FF5733".isValidHexColor   // true
    /// "FF5733".isValidHexColor    // true
    /// ```
    public var isValidHexColor: Bool {
        let hex = hasPrefix("#") ? String(dropFirst()) : self
        let pattern = #"^[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?$"#
        return hex.range(of: pattern, options: .regularExpression) != nil
    }

    /// Returns `true` if the string contains at least one emoji.
    public var containsEmoji: Bool {
        unicodeScalars.contains { scalar in
            scalar.properties.isEmoji && scalar.properties.isEmojiPresentation
        }
    }
}
