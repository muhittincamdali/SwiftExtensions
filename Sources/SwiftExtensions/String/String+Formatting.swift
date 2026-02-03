import Foundation

extension String {

    /// Converts the string to camelCase.
    ///
    /// ```swift
    /// "hello world".camelCased    // "helloWorld"
    /// "some-variable".camelCased  // "someVariable"
    /// ```
    public var camelCased: String {
        let words = splitIntoWords()
        guard let first = words.first else { return self }
        return first.lowercased() + words.dropFirst().map { $0.capitalized }.joined()
    }

    /// Converts the string to snake_case.
    ///
    /// ```swift
    /// "helloWorld".snakeCased     // "hello_world"
    /// "Hello World".snakeCased    // "hello_world"
    /// ```
    public var snakeCased: String {
        splitIntoWords().map { $0.lowercased() }.joined(separator: "_")
    }

    /// Capitalizes the first letter of each word.
    ///
    /// ```swift
    /// "hello world".titleCased    // "Hello World"
    /// ```
    public var titleCased: String {
        split(separator: " ").map { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }.joined(separator: " ")
    }

    /// Creates a URL-friendly slug from the string.
    ///
    /// ```swift
    /// "Hello World!".slugified    // "hello-world"
    /// ```
    public var slugified: String {
        let allowed = CharacterSet.alphanumerics.union(.init(charactersIn: " "))
        return unicodeScalars
            .filter { allowed.contains($0) }
            .reduce(into: "") { $0.unicodeScalars.append($1) }
            .lowercased()
            .split(separator: " ")
            .joined(separator: "-")
    }

    /// Truncates the string to the specified length, appending a suffix.
    ///
    /// - Parameters:
    ///   - length: Maximum character count before truncation.
    ///   - trailing: Suffix appended when truncated. Defaults to `"..."`.
    /// - Returns: Truncated string or the original if short enough.
    public func truncated(to length: Int, trailing: String = "...") -> String {
        count > length ? prefix(length) + trailing : self
    }

    /// Returns the string with leading and trailing whitespace removed.
    public var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Pads the string on the left to reach the desired length.
    ///
    /// - Parameters:
    ///   - length: Target length.
    ///   - character: Padding character. Defaults to `" "`.
    /// - Returns: Left-padded string.
    public func padded(toLength length: Int, with character: Character = " ") -> String {
        guard count < length else { return self }
        return String(repeating: character, count: length - count) + self
    }

    /// Returns the string with the first letter capitalized.
    public var capitalizedFirst: String {
        prefix(1).uppercased() + dropFirst()
    }

    /// Splits the string into words by detecting camelCase, spaces, hyphens, and underscores.
    private func splitIntoWords() -> [String] {
        var words: [String] = []
        var current = ""
        let replaced = replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: "_", with: " ")

        for char in replaced {
            if char == " " {
                if !current.isEmpty { words.append(current) }
                current = ""
            } else if char.isUppercase && !current.isEmpty {
                words.append(current)
                current = String(char)
            } else {
                current.append(char)
            }
        }
        if !current.isEmpty { words.append(current) }
        return words
    }
}
