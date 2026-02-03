import Foundation

// MARK: - String Formatting Extensions

public extension String {
    
    // MARK: - Case Conversions
    
    /// Converts string to camelCase.
    ///
    /// ```swift
    /// "hello_world".camelCased        // "helloWorld"
    /// "Hello World".camelCased        // "helloWorld"
    /// "HELLO_WORLD".camelCased        // "helloWorld"
    /// ```
    var camelCased: String {
        let words = splitIntoWords()
        guard let first = words.first else { return self }
        
        let rest = words.dropFirst().map { $0.capitalized }
        return first.lowercased() + rest.joined()
    }
    
    /// Converts string to PascalCase (UpperCamelCase).
    ///
    /// ```swift
    /// "hello_world".pascalCased       // "HelloWorld"
    /// "hello world".pascalCased       // "HelloWorld"
    /// ```
    var pascalCased: String {
        return splitIntoWords().map { $0.capitalized }.joined()
    }
    
    /// Converts string to snake_case.
    ///
    /// ```swift
    /// "helloWorld".snakeCased         // "hello_world"
    /// "HelloWorld".snakeCased         // "hello_world"
    /// "Hello World".snakeCased        // "hello_world"
    /// ```
    var snakeCased: String {
        return splitIntoWords().map { $0.lowercased() }.joined(separator: "_")
    }
    
    /// Converts string to SCREAMING_SNAKE_CASE.
    ///
    /// ```swift
    /// "helloWorld".screamingSnakeCased // "HELLO_WORLD"
    /// ```
    var screamingSnakeCased: String {
        return splitIntoWords().map { $0.uppercased() }.joined(separator: "_")
    }
    
    /// Converts string to kebab-case.
    ///
    /// ```swift
    /// "helloWorld".kebabCased         // "hello-world"
    /// "Hello World".kebabCased        // "hello-world"
    /// ```
    var kebabCased: String {
        return splitIntoWords().map { $0.lowercased() }.joined(separator: "-")
    }
    
    /// Converts string to Train-Case.
    ///
    /// ```swift
    /// "helloWorld".trainCased         // "Hello-World"
    /// ```
    var trainCased: String {
        return splitIntoWords().map { $0.capitalized }.joined(separator: "-")
    }
    
    /// Converts string to Title Case.
    ///
    /// ```swift
    /// "hello world".titleCased        // "Hello World"
    /// "HELLO WORLD".titleCased        // "Hello World"
    /// ```
    var titleCased: String {
        return splitIntoWords().map { $0.capitalized }.joined(separator: " ")
    }
    
    /// Converts string to Sentence case.
    ///
    /// ```swift
    /// "hello world".sentenceCased     // "Hello world"
    /// ```
    var sentenceCased: String {
        guard let first = first else { return self }
        return first.uppercased() + dropFirst().lowercased()
    }
    
    /// Splits string into words for case conversion.
    private func splitIntoWords() -> [String] {
        var words: [String] = []
        var currentWord = ""
        
        let separators = CharacterSet(charactersIn: "_ -")
        
        for character in self {
            let charString = String(character)
            
            if separators.contains(character.unicodeScalars.first!) {
                if !currentWord.isEmpty {
                    words.append(currentWord)
                    currentWord = ""
                }
            } else if character.isUppercase && !currentWord.isEmpty && currentWord.last?.isLowercase == true {
                words.append(currentWord)
                currentWord = charString
            } else {
                currentWord += charString
            }
        }
        
        if !currentWord.isEmpty {
            words.append(currentWord)
        }
        
        return words
    }
    
    // MARK: - Truncation
    
    /// Truncates string to specified length with ellipsis.
    ///
    /// - Parameters:
    ///   - length: Maximum length including ellipsis.
    ///   - trailing: Trailing string to append (default: "...").
    /// - Returns: Truncated string.
    ///
    /// ```swift
    /// "Hello World".truncated(to: 8)              // "Hello..."
    /// "Hello World".truncated(to: 8, trailing: "…") // "Hello W…"
    /// ```
    func truncated(to length: Int, trailing: String = "...") -> String {
        guard count > length else { return self }
        let truncatedLength = length - trailing.count
        guard truncatedLength > 0 else { return trailing }
        return String(prefix(truncatedLength)) + trailing
    }
    
    /// Truncates string in the middle.
    ///
    /// - Parameters:
    ///   - length: Maximum total length.
    ///   - separator: Middle separator (default: "...").
    /// - Returns: String with middle truncated.
    ///
    /// ```swift
    /// "Hello Beautiful World".truncatedMiddle(to: 15) // "Hello...World"
    /// ```
    func truncatedMiddle(to length: Int, separator: String = "...") -> String {
        guard count > length else { return self }
        
        let charsToShow = length - separator.count
        guard charsToShow > 0 else { return separator }
        
        let frontChars = (charsToShow + 1) / 2
        let backChars = charsToShow / 2
        
        return String(prefix(frontChars)) + separator + String(suffix(backChars))
    }
    
    /// Truncates string at word boundary.
    ///
    /// - Parameters:
    ///   - length: Maximum length.
    ///   - trailing: Trailing string.
    /// - Returns: String truncated at word boundary.
    func truncatedAtWord(to length: Int, trailing: String = "...") -> String {
        guard count > length else { return self }
        
        let truncatedLength = length - trailing.count
        guard truncatedLength > 0 else { return trailing }
        
        let substring = String(prefix(truncatedLength))
        if let lastSpace = substring.lastIndex(of: " ") {
            return String(substring[..<lastSpace]) + trailing
        }
        
        return substring + trailing
    }
    
    // MARK: - Padding
    
    /// Pads string on the left to reach specified length.
    ///
    /// - Parameters:
    ///   - length: Target length.
    ///   - character: Padding character (default: space).
    /// - Returns: Left-padded string.
    ///
    /// ```swift
    /// "42".paddedLeft(to: 5, with: "0")    // "00042"
    /// ```
    func paddedLeft(to length: Int, with character: Character = " ") -> String {
        guard count < length else { return self }
        return String(repeating: character, count: length - count) + self
    }
    
    /// Pads string on the right to reach specified length.
    ///
    /// - Parameters:
    ///   - length: Target length.
    ///   - character: Padding character (default: space).
    /// - Returns: Right-padded string.
    func paddedRight(to length: Int, with character: Character = " ") -> String {
        guard count < length else { return self }
        return self + String(repeating: character, count: length - count)
    }
    
    /// Centers string with padding on both sides.
    ///
    /// - Parameters:
    ///   - length: Target length.
    ///   - character: Padding character.
    /// - Returns: Centered string.
    func centered(to length: Int, with character: Character = " ") -> String {
        guard count < length else { return self }
        let padding = length - count
        let leftPadding = padding / 2
        let rightPadding = padding - leftPadding
        return String(repeating: character, count: leftPadding) + self + String(repeating: character, count: rightPadding)
    }
    
    // MARK: - Whitespace Handling
    
    /// Removes all whitespace from string.
    ///
    /// ```swift
    /// "Hello World".withoutSpaces    // "HelloWorld"
    /// ```
    var withoutSpaces: String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    /// Removes all whitespace and newlines.
    ///
    /// ```swift
    /// "Hello\n World".withoutWhitespace    // "HelloWorld"
    /// ```
    var withoutWhitespace: String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    /// Collapses multiple whitespaces into single space.
    ///
    /// ```swift
    /// "Hello    World".condensedWhitespace    // "Hello World"
    /// ```
    var condensedWhitespace: String {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
    
    /// Trims whitespace and newlines from both ends.
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Trims only leading whitespace.
    var trimmedLeading: String {
        guard let index = firstIndex(where: { !$0.isWhitespace }) else { return "" }
        return String(self[index...])
    }
    
    /// Trims only trailing whitespace.
    var trimmedTrailing: String {
        guard let index = lastIndex(where: { !$0.isWhitespace }) else { return "" }
        return String(self[...index])
    }
    
    // MARK: - Number Formatting
    
    /// Formats string as currency.
    ///
    /// - Parameters:
    ///   - locale: Locale for formatting (default: current).
    ///   - currencyCode: ISO currency code (optional).
    /// - Returns: Formatted currency string or nil.
    func asCurrency(locale: Locale = .current, currencyCode: String? = nil) -> String? {
        guard let number = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        if let code = currencyCode {
            formatter.currencyCode = code
        }
        
        return formatter.string(from: NSNumber(value: number))
    }
    
    /// Formats numeric string with thousands separator.
    ///
    /// ```swift
    /// "1234567".withThousandsSeparator    // "1,234,567"
    /// ```
    var withThousandsSeparator: String? {
        guard let number = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number))
    }
    
    // MARK: - String Manipulation
    
    /// Repeats string specified number of times.
    ///
    /// - Parameter count: Number of repetitions.
    /// - Returns: Repeated string.
    ///
    /// ```swift
    /// "ab".repeated(3)    // "ababab"
    /// ```
    func repeated(_ count: Int) -> String {
        return String(repeating: self, count: max(0, count))
    }
    
    /// Reverses the string.
    ///
    /// ```swift
    /// "Hello".reversed    // "olleH"
    /// ```
    var reversed: String {
        return String(self.reversed())
    }
    
    /// Returns string with first character capitalized.
    ///
    /// ```swift
    /// "hello world".capitalizedFirst    // "Hello world"
    /// ```
    var capitalizedFirst: String {
        guard let first = first else { return self }
        return first.uppercased() + dropFirst()
    }
    
    /// Returns string with first character lowercased.
    var lowercasedFirst: String {
        guard let first = first else { return self }
        return first.lowercased() + dropFirst()
    }
    
    /// Wraps string with specified wrapper.
    ///
    /// - Parameter wrapper: String to wrap with.
    /// - Returns: Wrapped string.
    ///
    /// ```swift
    /// "text".wrapped(with: "**")    // "**text**"
    /// ```
    func wrapped(with wrapper: String) -> String {
        return wrapper + self + wrapper
    }
    
    /// Wraps string with different left and right wrappers.
    ///
    /// - Parameters:
    ///   - left: Left wrapper.
    ///   - right: Right wrapper.
    /// - Returns: Wrapped string.
    func wrapped(left: String, right: String) -> String {
        return left + self + right
    }
    
    /// Removes specified prefix if present.
    ///
    /// - Parameter prefix: Prefix to remove.
    /// - Returns: String without prefix.
    func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    /// Removes specified suffix if present.
    ///
    /// - Parameter suffix: Suffix to remove.
    /// - Returns: String without suffix.
    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
    
    // MARK: - Line Operations
    
    /// Returns array of lines.
    var lines: [String] {
        return components(separatedBy: .newlines)
    }
    
    /// Returns number of lines.
    var lineCount: Int {
        return lines.count
    }
    
    /// Returns first line.
    var firstLine: String? {
        return lines.first
    }
    
    /// Returns last line.
    var lastLine: String? {
        return lines.last
    }
    
    /// Prefixes each line with specified string.
    ///
    /// - Parameter prefix: Prefix for each line.
    /// - Returns: String with prefixed lines.
    func prefixingLines(with prefix: String) -> String {
        return lines.map { prefix + $0 }.joined(separator: "\n")
    }
    
    // MARK: - Slug Generation
    
    /// Converts string to URL-safe slug.
    ///
    /// ```swift
    /// "Hello World!".slugified    // "hello-world"
    /// "Café au Lait".slugified    // "cafe-au-lait"
    /// ```
    var slugified: String {
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz0123456789-")
        
        return self
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .components(separatedBy: allowed.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "-")
    }
    
    /// Converts string to filename-safe format.
    ///
    /// ```swift
    /// "My File: 2023/01".filenameSafe    // "My-File-2023-01"
    /// ```
    var filenameSafe: String {
        let invalidChars = CharacterSet(charactersIn: ":/\\?%*|\"<>")
        return components(separatedBy: invalidChars).joined(separator: "-")
    }
}
