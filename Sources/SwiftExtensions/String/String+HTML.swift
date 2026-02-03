import Foundation

// MARK: - String HTML Extensions

public extension String {
    
    // MARK: - HTML Entity Encoding
    
    /// Encodes string for safe HTML display.
    ///
    /// Converts special characters to HTML entities.
    ///
    /// ```swift
    /// "<div>Hello</div>".htmlEncoded    // "&lt;div&gt;Hello&lt;/div&gt;"
    /// ```
    var htmlEncoded: String {
        var result = self
        let entities: [(String, String)] = [
            ("&", "&amp;"),
            ("<", "&lt;"),
            (">", "&gt;"),
            ("\"", "&quot;"),
            ("'", "&#39;")
        ]
        
        for (char, entity) in entities {
            result = result.replacingOccurrences(of: char, with: entity)
        }
        
        return result
    }
    
    /// Decodes HTML entities to plain text.
    ///
    /// ```swift
    /// "&lt;div&gt;".htmlDecoded    // "<div>"
    /// "Hello&nbsp;World".htmlDecoded    // "Hello World"
    /// ```
    var htmlDecoded: String {
        var result = self
        
        // Named entities
        let namedEntities: [(String, String)] = [
            ("&amp;", "&"),
            ("&lt;", "<"),
            ("&gt;", ">"),
            ("&quot;", "\""),
            ("&#39;", "'"),
            ("&apos;", "'"),
            ("&nbsp;", " "),
            ("&copy;", "©"),
            ("&reg;", "®"),
            ("&trade;", "™"),
            ("&mdash;", "—"),
            ("&ndash;", "–"),
            ("&hellip;", "…"),
            ("&laquo;", "«"),
            ("&raquo;", "»"),
            ("&ldquo;", """),
            ("&rdquo;", """),
            ("&lsquo;", "'"),
            ("&rsquo;", "'"),
            ("&bull;", "•"),
            ("&middot;", "·"),
            ("&cent;", "¢"),
            ("&pound;", "£"),
            ("&euro;", "€"),
            ("&yen;", "¥"),
            ("&deg;", "°"),
            ("&plusmn;", "±"),
            ("&times;", "×"),
            ("&divide;", "÷"),
            ("&frac14;", "¼"),
            ("&frac12;", "½"),
            ("&frac34;", "¾")
        ]
        
        for (entity, char) in namedEntities {
            result = result.replacingOccurrences(of: entity, with: char)
        }
        
        // Numeric entities (decimal)
        let decimalPattern = "&#(\\d+);"
        if let regex = try? NSRegularExpression(pattern: decimalPattern) {
            let nsRange = NSRange(result.startIndex..., in: result)
            let matches = regex.matches(in: result, range: nsRange).reversed()
            
            for match in matches {
                if let range = Range(match.range, in: result),
                   let codeRange = Range(match.range(at: 1), in: result),
                   let code = Int(result[codeRange]),
                   let scalar = UnicodeScalar(code) {
                    result.replaceSubrange(range, with: String(Character(scalar)))
                }
            }
        }
        
        // Numeric entities (hexadecimal)
        let hexPattern = "&#[xX]([0-9a-fA-F]+);"
        if let regex = try? NSRegularExpression(pattern: hexPattern) {
            let nsRange = NSRange(result.startIndex..., in: result)
            let matches = regex.matches(in: result, range: nsRange).reversed()
            
            for match in matches {
                if let range = Range(match.range, in: result),
                   let codeRange = Range(match.range(at: 1), in: result),
                   let code = Int(result[codeRange], radix: 16),
                   let scalar = UnicodeScalar(code) {
                    result.replaceSubrange(range, with: String(Character(scalar)))
                }
            }
        }
        
        return result
    }
    
    // MARK: - HTML Stripping
    
    /// Strips all HTML tags from string.
    ///
    /// ```swift
    /// "<p>Hello <b>World</b></p>".strippedHTMLTags    // "Hello World"
    /// ```
    var strippedHTMLTags: String {
        guard let data = data(using: .utf8) else { return self }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        }
        
        // Fallback to regex stripping
        return strippedHTMLTagsWithRegex
    }
    
    /// Strips HTML tags using regex (faster but less accurate).
    var strippedHTMLTagsWithRegex: String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
    /// Strips specific HTML tags.
    ///
    /// - Parameter tags: Array of tag names to strip.
    /// - Returns: String without specified tags.
    func strippingHTMLTags(_ tags: [String]) -> String {
        var result = self
        
        for tag in tags {
            // Remove opening tags with attributes
            let openingPattern = "<\(tag)\\b[^>]*>"
            result = result.replacingOccurrences(of: openingPattern, with: "", options: .regularExpression)
            
            // Remove closing tags
            let closingPattern = "</\(tag)>"
            result = result.replacingOccurrences(of: closingPattern, with: "", options: [.regularExpression, .caseInsensitive])
        }
        
        return result
    }
    
    /// Strips all HTML tags except specified ones.
    ///
    /// - Parameter allowedTags: Tags to keep.
    /// - Returns: String with only allowed tags.
    func strippingHTMLTagsExcept(_ allowedTags: [String]) -> String {
        let tagPattern = "</?([a-zA-Z][a-zA-Z0-9]*)\\b[^>]*>"
        
        guard let regex = try? NSRegularExpression(pattern: tagPattern) else {
            return self
        }
        
        var result = self
        let nsRange = NSRange(result.startIndex..., in: result)
        let matches = regex.matches(in: result, range: nsRange).reversed()
        
        for match in matches {
            guard let range = Range(match.range, in: result),
                  let tagNameRange = Range(match.range(at: 1), in: result) else { continue }
            
            let tagName = String(result[tagNameRange]).lowercased()
            
            if !allowedTags.map({ $0.lowercased() }).contains(tagName) {
                result.replaceSubrange(range, with: "")
            }
        }
        
        return result
    }
    
    // MARK: - HTML Parsing
    
    /// Extracts text content from specific HTML tag.
    ///
    /// - Parameter tag: Tag name to extract from.
    /// - Returns: Array of text contents.
    func extractHTMLTagContent(_ tag: String) -> [String] {
        let pattern = "<\(tag)\\b[^>]*>(.*?)</\(tag)>"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators, .caseInsensitive]) else {
            return []
        }
        
        let nsRange = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: nsRange)
        
        return matches.compactMap { match -> String? in
            guard let range = Range(match.range(at: 1), in: self) else { return nil }
            return String(self[range])
        }
    }
    
    /// Extracts all links (href values) from HTML.
    ///
    /// - Returns: Array of URL strings.
    var htmlLinks: [String] {
        let pattern = "href=[\"']([^\"']+)[\"']"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return []
        }
        
        let nsRange = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: nsRange)
        
        return matches.compactMap { match -> String? in
            guard let range = Range(match.range(at: 1), in: self) else { return nil }
            return String(self[range])
        }
    }
    
    /// Extracts all image sources from HTML.
    ///
    /// - Returns: Array of image URL strings.
    var htmlImageSources: [String] {
        let pattern = "src=[\"']([^\"']+)[\"']"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return []
        }
        
        let nsRange = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: nsRange)
        
        return matches.compactMap { match -> String? in
            guard let range = Range(match.range(at: 1), in: self) else { return nil }
            return String(self[range])
        }
    }
    
    /// Extracts attribute value from HTML tag.
    ///
    /// - Parameters:
    ///   - attribute: Attribute name.
    ///   - tag: Tag name (optional, searches all tags if nil).
    /// - Returns: Array of attribute values.
    func htmlAttributeValues(_ attribute: String, from tag: String? = nil) -> [String] {
        let tagPart = tag ?? "[a-zA-Z][a-zA-Z0-9]*"
        let pattern = "<\(tagPart)\\b[^>]*\\s\(attribute)=[\"']([^\"']+)[\"'][^>]*>"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return []
        }
        
        let nsRange = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: nsRange)
        
        return matches.compactMap { match -> String? in
            guard let range = Range(match.range(at: 1), in: self) else { return nil }
            return String(self[range])
        }
    }
    
    // MARK: - HTML Generation
    
    /// Wraps string in HTML tag.
    ///
    /// - Parameters:
    ///   - tag: HTML tag name.
    ///   - attributes: Optional tag attributes.
    /// - Returns: HTML wrapped string.
    ///
    /// ```swift
    /// "Hello".htmlTag("p")                        // "<p>Hello</p>"
    /// "Hello".htmlTag("a", attributes: ["href": "url"])  // "<a href=\"url\">Hello</a>"
    /// ```
    func htmlTag(_ tag: String, attributes: [String: String] = [:]) -> String {
        let attrString = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<\(tag)\(attrString)>\(self)</\(tag)>"
    }
    
    /// Wraps string in paragraph tag.
    var htmlParagraph: String {
        return htmlTag("p")
    }
    
    /// Wraps string in bold tag.
    var htmlBold: String {
        return htmlTag("strong")
    }
    
    /// Wraps string in italic tag.
    var htmlItalic: String {
        return htmlTag("em")
    }
    
    /// Creates HTML link.
    ///
    /// - Parameter url: Link URL.
    /// - Returns: HTML anchor tag.
    func htmlLink(url: String) -> String {
        return htmlTag("a", attributes: ["href": url])
    }
    
    /// Converts newlines to HTML line breaks.
    var htmlLineBreaks: String {
        return replacingOccurrences(of: "\n", with: "<br>")
    }
    
    /// Converts string to basic HTML document.
    ///
    /// - Parameter title: Document title.
    /// - Returns: Complete HTML document string.
    func htmlDocument(title: String = "") -> String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>\(title.htmlEncoded)</title>
        </head>
        <body>
        \(self)
        </body>
        </html>
        """
    }
}
