import Foundation

// MARK: - String Validation Extensions

public extension String {
    
    // MARK: - Email Validation
    
    /// Validates if the string is a valid email address.
    ///
    /// Uses RFC 5322 compliant regex pattern for email validation.
    ///
    /// - Returns: `true` if the string is a valid email, `false` otherwise.
    ///
    /// ```swift
    /// "user@example.com".isValidEmail // true
    /// "invalid-email".isValidEmail    // false
    /// ```
    var isValidEmail: Bool {
        let emailPattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return range(of: emailPattern, options: .regularExpression) != nil
    }
    
    /// Validates email with strict RFC 5322 compliance.
    ///
    /// - Returns: `true` if strictly valid, `false` otherwise.
    var isStrictlyValidEmail: Bool {
        let strictPattern = #"^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$"#
        return range(of: strictPattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
    
    /// Extracts the domain from an email address.
    ///
    /// - Returns: The domain portion of the email, or `nil` if invalid.
    var emailDomain: String? {
        guard isValidEmail else { return nil }
        return components(separatedBy: "@").last
    }
    
    /// Extracts the local part (username) from an email address.
    ///
    /// - Returns: The local part of the email, or `nil` if invalid.
    var emailLocalPart: String? {
        guard isValidEmail else { return nil }
        return components(separatedBy: "@").first
    }
    
    // MARK: - URL Validation
    
    /// Validates if the string is a valid URL.
    ///
    /// - Returns: `true` if the string is a valid URL, `false` otherwise.
    ///
    /// ```swift
    /// "https://example.com".isValidURL // true
    /// "not a url".isValidURL           // false
    /// ```
    var isValidURL: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil && url.host != nil
    }
    
    /// Validates if the string is a valid HTTP or HTTPS URL.
    ///
    /// - Returns: `true` if valid HTTP(S) URL, `false` otherwise.
    var isValidHTTPURL: Bool {
        guard let url = URL(string: self),
              let scheme = url.scheme?.lowercased() else { return false }
        return (scheme == "http" || scheme == "https") && url.host != nil
    }
    
    /// Validates if the string is a valid file URL.
    ///
    /// - Returns: `true` if valid file URL, `false` otherwise.
    var isValidFileURL: Bool {
        guard let url = URL(string: self) else { return false }
        return url.isFileURL
    }
    
    /// Validates URL with specific allowed schemes.
    ///
    /// - Parameter schemes: Array of allowed URL schemes.
    /// - Returns: `true` if URL has one of the allowed schemes.
    func isValidURL(withSchemes schemes: [String]) -> Bool {
        guard let url = URL(string: self),
              let scheme = url.scheme?.lowercased() else { return false }
        return schemes.map { $0.lowercased() }.contains(scheme)
    }
    
    // MARK: - Phone Number Validation
    
    /// Validates if the string is a valid phone number.
    ///
    /// Supports international formats with optional country code.
    ///
    /// - Returns: `true` if valid phone number, `false` otherwise.
    ///
    /// ```swift
    /// "+1-555-123-4567".isValidPhoneNumber // true
    /// "(555) 123-4567".isValidPhoneNumber  // true
    /// ```
    var isValidPhoneNumber: Bool {
        let phonePattern = #"^[\+]?[(]?[0-9]{1,4}[)]?[-\s\.]?[(]?[0-9]{1,3}[)]?[-\s\.]?[0-9]{1,4}[-\s\.]?[0-9]{1,4}[-\s\.]?[0-9]{1,9}$"#
        return range(of: phonePattern, options: .regularExpression) != nil
    }
    
    /// Validates US phone number format.
    ///
    /// - Returns: `true` if valid US phone number.
    var isValidUSPhoneNumber: Bool {
        let usPattern = #"^(\+1[-.\s]?)?(\(?\d{3}\)?[-.\s]?)?\d{3}[-.\s]?\d{4}$"#
        return range(of: usPattern, options: .regularExpression) != nil
    }
    
    /// Validates international phone number with E.164 format.
    ///
    /// - Returns: `true` if valid E.164 format.
    var isValidE164PhoneNumber: Bool {
        let e164Pattern = #"^\+[1-9]\d{6,14}$"#
        return range(of: e164Pattern, options: .regularExpression) != nil
    }
    
    /// Extracts digits from phone number.
    ///
    /// - Returns: String containing only digits.
    var phoneDigitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    // MARK: - Numeric Validation
    
    /// Checks if the string contains only numeric characters.
    ///
    /// - Returns: `true` if string is numeric, `false` otherwise.
    ///
    /// ```swift
    /// "12345".isNumeric   // true
    /// "12.34".isNumeric   // false
    /// "12abc".isNumeric   // false
    /// ```
    var isNumeric: Bool {
        return !isEmpty && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// Checks if string represents a valid integer.
    ///
    /// - Returns: `true` if string can be converted to Int.
    var isInteger: Bool {
        return Int(self) != nil
    }
    
    /// Checks if string represents a valid decimal number.
    ///
    /// - Returns: `true` if string can be converted to Double.
    var isDecimal: Bool {
        return Double(self) != nil
    }
    
    /// Checks if string represents a valid positive number.
    ///
    /// - Returns: `true` if positive number.
    var isPositiveNumber: Bool {
        guard let number = Double(self) else { return false }
        return number > 0
    }
    
    /// Checks if string represents a valid negative number.
    ///
    /// - Returns: `true` if negative number.
    var isNegativeNumber: Bool {
        guard let number = Double(self) else { return false }
        return number < 0
    }
    
    // MARK: - Alphanumeric Validation
    
    /// Checks if string contains only alphanumeric characters.
    ///
    /// - Returns: `true` if alphanumeric only.
    var isAlphanumeric: Bool {
        return !isEmpty && CharacterSet.alphanumerics.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// Checks if string contains only letters.
    ///
    /// - Returns: `true` if letters only.
    var isAlphabetic: Bool {
        return !isEmpty && CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// Checks if string contains only lowercase letters.
    ///
    /// - Returns: `true` if lowercase only.
    var isLowercase: Bool {
        return self == lowercased() && isAlphabetic
    }
    
    /// Checks if string contains only uppercase letters.
    ///
    /// - Returns: `true` if uppercase only.
    var isUppercase: Bool {
        return self == uppercased() && isAlphabetic
    }
    
    // MARK: - Credit Card Validation
    
    /// Validates credit card number using Luhn algorithm.
    ///
    /// - Returns: `true` if valid credit card number.
    var isValidCreditCard: Bool {
        let digits = phoneDigitsOnly
        guard digits.count >= 13 && digits.count <= 19 else { return false }
        return luhnCheck(digits)
    }
    
    /// Detects credit card type.
    ///
    /// - Returns: Credit card type or nil if unknown.
    var creditCardType: CreditCardType? {
        let digits = phoneDigitsOnly
        
        if digits.hasPrefix("4") { return .visa }
        if digits.hasPrefix("34") || digits.hasPrefix("37") { return .amex }
        if digits.hasPrefix("5") { return .mastercard }
        if digits.hasPrefix("6011") || digits.hasPrefix("65") { return .discover }
        if digits.hasPrefix("35") { return .jcb }
        if digits.hasPrefix("30") || digits.hasPrefix("36") || digits.hasPrefix("38") { return .dinersClub }
        
        return nil
    }
    
    private func luhnCheck(_ number: String) -> Bool {
        var sum = 0
        let reversedDigits = number.reversed().map { Int(String($0))! }
        
        for (index, digit) in reversedDigits.enumerated() {
            if index % 2 == 1 {
                let doubled = digit * 2
                sum += doubled > 9 ? doubled - 9 : doubled
            } else {
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
    
    // MARK: - Password Validation
    
    /// Validates password strength.
    ///
    /// - Parameter requirements: Password requirements to check.
    /// - Returns: `true` if password meets requirements.
    func isValidPassword(requirements: PasswordRequirements = .default) -> Bool {
        guard count >= requirements.minLength else { return false }
        guard count <= requirements.maxLength else { return false }
        
        if requirements.requiresUppercase {
            guard range(of: "[A-Z]", options: .regularExpression) != nil else { return false }
        }
        
        if requirements.requiresLowercase {
            guard range(of: "[a-z]", options: .regularExpression) != nil else { return false }
        }
        
        if requirements.requiresDigit {
            guard range(of: "[0-9]", options: .regularExpression) != nil else { return false }
        }
        
        if requirements.requiresSpecialCharacter {
            guard range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) != nil else { return false }
        }
        
        return true
    }
    
    /// Calculates password strength score (0-100).
    ///
    /// - Returns: Strength score from 0 (weak) to 100 (strong).
    var passwordStrengthScore: Int {
        var score = 0
        
        // Length bonus
        score += min(count * 4, 40)
        
        // Uppercase bonus
        if range(of: "[A-Z]", options: .regularExpression) != nil { score += 10 }
        
        // Lowercase bonus
        if range(of: "[a-z]", options: .regularExpression) != nil { score += 10 }
        
        // Digit bonus
        if range(of: "[0-9]", options: .regularExpression) != nil { score += 10 }
        
        // Special character bonus
        if range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) != nil { score += 15 }
        
        // Mixed case bonus
        if range(of: "[A-Z]", options: .regularExpression) != nil &&
           range(of: "[a-z]", options: .regularExpression) != nil { score += 15 }
        
        return min(score, 100)
    }
    
    // MARK: - IP Address Validation
    
    /// Validates IPv4 address format.
    ///
    /// - Returns: `true` if valid IPv4 address.
    var isValidIPv4: Bool {
        let parts = components(separatedBy: ".")
        guard parts.count == 4 else { return false }
        
        for part in parts {
            guard let number = Int(part), number >= 0, number <= 255 else { return false }
        }
        return true
    }
    
    /// Validates IPv6 address format.
    ///
    /// - Returns: `true` if valid IPv6 address.
    var isValidIPv6: Bool {
        let ipv6Pattern = #"^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$|^::$|^([0-9a-fA-F]{1,4}:){1,7}:$|^::[0-9a-fA-F]{1,4}(:[0-9a-fA-F]{1,4}){0,6}$|^([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}$"#
        return range(of: ipv6Pattern, options: .regularExpression) != nil
    }
    
    // MARK: - Date Validation
    
    /// Validates date string with format.
    ///
    /// - Parameter format: Date format string (e.g., "yyyy-MM-dd").
    /// - Returns: `true` if valid date.
    func isValidDate(format: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self) != nil
    }
    
    /// Validates ISO 8601 date format.
    ///
    /// - Returns: `true` if valid ISO 8601 date.
    var isValidISO8601Date: Bool {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self) != nil || isValidDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    // MARK: - Regex Validation
    
    /// Validates string against custom regex pattern.
    ///
    /// - Parameter pattern: Regular expression pattern.
    /// - Returns: `true` if string matches pattern.
    func matches(pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression) != nil
    }
    
    /// Validates string against regex with options.
    ///
    /// - Parameters:
    ///   - pattern: Regular expression pattern.
    ///   - options: Regex matching options.
    /// - Returns: `true` if string matches pattern.
    func matches(pattern: String, options: NSRegularExpression.Options) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return false }
        let range = NSRange(location: 0, length: utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}

// MARK: - Supporting Types

/// Credit card types
public enum CreditCardType: String, CaseIterable {
    case visa = "Visa"
    case mastercard = "Mastercard"
    case amex = "American Express"
    case discover = "Discover"
    case jcb = "JCB"
    case dinersClub = "Diners Club"
}

/// Password validation requirements
public struct PasswordRequirements {
    public let minLength: Int
    public let maxLength: Int
    public let requiresUppercase: Bool
    public let requiresLowercase: Bool
    public let requiresDigit: Bool
    public let requiresSpecialCharacter: Bool
    
    public static let `default` = PasswordRequirements(
        minLength: 8,
        maxLength: 128,
        requiresUppercase: true,
        requiresLowercase: true,
        requiresDigit: true,
        requiresSpecialCharacter: false
    )
    
    public static let strong = PasswordRequirements(
        minLength: 12,
        maxLength: 128,
        requiresUppercase: true,
        requiresLowercase: true,
        requiresDigit: true,
        requiresSpecialCharacter: true
    )
    
    public init(
        minLength: Int = 8,
        maxLength: Int = 128,
        requiresUppercase: Bool = true,
        requiresLowercase: Bool = true,
        requiresDigit: Bool = true,
        requiresSpecialCharacter: Bool = false
    ) {
        self.minLength = minLength
        self.maxLength = maxLength
        self.requiresUppercase = requiresUppercase
        self.requiresLowercase = requiresLowercase
        self.requiresDigit = requiresDigit
        self.requiresSpecialCharacter = requiresSpecialCharacter
    }
}
