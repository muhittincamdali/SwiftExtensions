import Foundation

// MARK: - String Localization Extensions

public extension String {
    
    // MARK: - Basic Localization
    
    /// Returns localized string using self as key.
    ///
    /// ```swift
    /// "welcome_message".localized    // Returns localized value or key
    /// ```
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns localized string with specified comment.
    ///
    /// - Parameter comment: Comment for translators.
    /// - Returns: Localized string.
    func localized(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    /// Returns localized string from specific table.
    ///
    /// - Parameters:
    ///   - table: Localization table name.
    ///   - bundle: Bundle containing localizations (default: main).
    ///   - comment: Comment for translators.
    /// - Returns: Localized string.
    func localized(
        table: String,
        bundle: Bundle = .main,
        comment: String = ""
    ) -> String {
        return NSLocalizedString(self, tableName: table, bundle: bundle, comment: comment)
    }
    
    /// Returns localized string with format arguments.
    ///
    /// - Parameter arguments: Format arguments.
    /// - Returns: Formatted localized string.
    ///
    /// ```swift
    /// "greeting_format".localized(with: "John", 5)
    /// // "Hello John, you have 5 messages"
    /// ```
    func localized(with arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
    
    /// Returns localized string with array of arguments.
    ///
    /// - Parameter arguments: Array of format arguments.
    /// - Returns: Formatted localized string.
    func localized(withArguments arguments: [CVarArg]) -> String {
        return String(format: localized, arguments: arguments)
    }
    
    // MARK: - Pluralization
    
    /// Returns localized plural string.
    ///
    /// Uses stringsdict for proper pluralization.
    ///
    /// - Parameters:
    ///   - count: Count for pluralization.
    ///   - comment: Comment for translators.
    /// - Returns: Properly pluralized string.
    ///
    /// ```swift
    /// "items_count".localizedPlural(count: 1)    // "1 item"
    /// "items_count".localizedPlural(count: 5)    // "5 items"
    /// ```
    func localizedPlural(count: Int, comment: String = "") -> String {
        return String.localizedStringWithFormat(
            NSLocalizedString(self, comment: comment),
            count
        )
    }
    
    /// Returns localized plural with multiple counts.
    ///
    /// - Parameters:
    ///   - counts: Array of counts for pluralization.
    ///   - comment: Comment for translators.
    /// - Returns: Pluralized string.
    func localizedPlural(counts: [Int], comment: String = "") -> String {
        let format = NSLocalizedString(self, comment: comment)
        return String(format: format, arguments: counts.map { $0 as CVarArg })
    }
    
    // MARK: - Language Detection
    
    /// Detects dominant language of the string.
    ///
    /// - Returns: BCP-47 language code or nil if unknown.
    ///
    /// ```swift
    /// "Hello world".detectedLanguage    // "en"
    /// "Bonjour le monde".detectedLanguage    // "fr"
    /// ```
    var detectedLanguage: String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(self)
        return recognizer.dominantLanguage?.rawValue
    }
    
    /// Returns language hypotheses with confidence scores.
    ///
    /// - Parameter maxCount: Maximum number of hypotheses.
    /// - Returns: Dictionary of language codes to confidence scores.
    func languageHypotheses(maxCount: Int = 5) -> [String: Double] {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(self)
        
        let hypotheses = recognizer.languageHypotheses(withMaximum: maxCount)
        return Dictionary(uniqueKeysWithValues: hypotheses.map { ($0.key.rawValue, $0.value) })
    }
    
    /// Checks if string is in specified language.
    ///
    /// - Parameter language: BCP-47 language code.
    /// - Returns: `true` if string appears to be in specified language.
    func isLanguage(_ language: String) -> Bool {
        return detectedLanguage == language
    }
    
    // MARK: - Script Detection
    
    /// Detects the dominant script of the string.
    ///
    /// - Returns: Script name or nil if unknown.
    var dominantScript: String? {
        var scripts: [String: Int] = [:]
        
        for scalar in unicodeScalars {
            if let name = scalar.properties.name {
                let parts = name.split(separator: " ")
                if let script = parts.first {
                    let scriptName = String(script)
                    scripts[scriptName, default: 0] += 1
                }
            }
        }
        
        return scripts.max(by: { $0.value < $1.value })?.key
    }
    
    /// Checks if string contains characters from specific script.
    ///
    /// - Parameter script: Script name to check.
    /// - Returns: `true` if contains characters from script.
    func containsScript(_ script: String) -> Bool {
        for scalar in unicodeScalars {
            if let name = scalar.properties.name, name.contains(script.uppercased()) {
                return true
            }
        }
        return false
    }
    
    // MARK: - Locale-Specific Formatting
    
    /// Converts string to locale-specific lowercase.
    ///
    /// - Parameter locale: Locale for case conversion.
    /// - Returns: Lowercased string.
    func lowercased(with locale: Locale) -> String {
        return lowercased(with: locale)
    }
    
    /// Converts string to locale-specific uppercase.
    ///
    /// - Parameter locale: Locale for case conversion.
    /// - Returns: Uppercased string.
    func uppercased(with locale: Locale) -> String {
        return uppercased(with: locale)
    }
    
    /// Compares strings using locale-specific rules.
    ///
    /// - Parameters:
    ///   - other: String to compare with.
    ///   - locale: Locale for comparison.
    /// - Returns: Comparison result.
    func localizedCompare(_ other: String, locale: Locale = .current) -> ComparisonResult {
        return compare(other, options: [], range: nil, locale: locale)
    }
    
    // MARK: - RTL Support
    
    /// Checks if string requires right-to-left layout.
    ///
    /// - Returns: `true` if string is primarily RTL.
    var isRightToLeft: Bool {
        guard let language = detectedLanguage else { return false }
        let rtlLanguages = ["ar", "he", "fa", "ur", "yi", "ps"]
        return rtlLanguages.contains(language)
    }
    
    /// Returns string with RTL/LTR embedding marks.
    ///
    /// - Parameter direction: Text direction to enforce.
    /// - Returns: String with direction marks.
    func withTextDirection(_ direction: TextDirection) -> String {
        switch direction {
        case .leftToRight:
            return "\u{200E}" + self + "\u{200E}"
        case .rightToLeft:
            return "\u{200F}" + self + "\u{200F}"
        case .auto:
            return self
        }
    }
}

// MARK: - Supporting Types

import NaturalLanguage

/// Text direction options
public enum TextDirection {
    case leftToRight
    case rightToLeft
    case auto
}

// MARK: - Bundle Extensions for Localization

public extension Bundle {
    
    /// Returns localized string from bundle.
    ///
    /// - Parameters:
    ///   - key: Localization key.
    ///   - table: Localization table name.
    ///   - value: Default value if not found.
    /// - Returns: Localized string.
    func localizedString(
        forKey key: String,
        table: String? = nil,
        value: String? = nil
    ) -> String {
        return localizedString(forKey: key, value: value, table: table)
    }
    
    /// Returns bundle for specific language.
    ///
    /// - Parameter language: Language code (e.g., "en", "fr").
    /// - Returns: Bundle for language or nil if not available.
    static func bundle(for language: String) -> Bundle? {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            return nil
        }
        return Bundle(path: path)
    }
}
