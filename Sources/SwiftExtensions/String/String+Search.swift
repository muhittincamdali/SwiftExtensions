import Foundation

// MARK: - String Search Extensions

public extension String {
    
    // MARK: - Basic Search
    
    /// Checks if string contains substring (case insensitive).
    ///
    /// - Parameter substring: Substring to search for.
    /// - Returns: `true` if contains substring.
    ///
    /// ```swift
    /// "Hello World".containsIgnoringCase("world")    // true
    /// ```
    func containsIgnoringCase(_ substring: String) -> Bool {
        return range(of: substring, options: .caseInsensitive) != nil
    }
    
    /// Checks if string contains any of the given substrings.
    ///
    /// - Parameter substrings: Array of substrings to search for.
    /// - Returns: `true` if contains any substring.
    func containsAny(of substrings: [String]) -> Bool {
        return substrings.contains { contains($0) }
    }
    
    /// Checks if string contains all of the given substrings.
    ///
    /// - Parameter substrings: Array of substrings to search for.
    /// - Returns: `true` if contains all substrings.
    func containsAll(of substrings: [String]) -> Bool {
        return substrings.allSatisfy { contains($0) }
    }
    
    /// Counts occurrences of substring.
    ///
    /// - Parameter substring: Substring to count.
    /// - Returns: Number of occurrences.
    ///
    /// ```swift
    /// "Hello World World".occurrences(of: "World")    // 2
    /// ```
    func occurrences(of substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
    
    /// Counts occurrences of substring (case insensitive).
    ///
    /// - Parameter substring: Substring to count.
    /// - Returns: Number of occurrences.
    func occurrencesIgnoringCase(of substring: String) -> Int {
        return lowercased().occurrences(of: substring.lowercased())
    }
    
    // MARK: - Fuzzy Search
    
    /// Performs fuzzy search matching.
    ///
    /// Returns score based on how well the pattern matches.
    ///
    /// - Parameter pattern: Pattern to match.
    /// - Returns: Match score (higher is better), 0 if no match.
    ///
    /// ```swift
    /// "Hello World".fuzzyMatch("hw")    // Returns score > 0
    /// "Hello World".fuzzyMatch("xyz")   // Returns 0
    /// ```
    func fuzzyMatch(_ pattern: String) -> Int {
        guard !pattern.isEmpty else { return 0 }
        
        let source = lowercased()
        let pattern = pattern.lowercased()
        
        var score = 0
        var patternIndex = pattern.startIndex
        var consecutive = 0
        var previousMatchIndex: String.Index?
        
        for (index, char) in source.enumerated() {
            let sourceIndex = source.index(source.startIndex, offsetBy: index)
            
            if patternIndex < pattern.endIndex && char == pattern[patternIndex] {
                score += 1
                
                // Bonus for consecutive matches
                if let prevIndex = previousMatchIndex {
                    let distance = source.distance(from: prevIndex, to: sourceIndex)
                    if distance == 1 {
                        consecutive += 1
                        score += consecutive * 2
                    } else {
                        consecutive = 0
                    }
                }
                
                // Bonus for match at word start
                if index == 0 || source[source.index(before: sourceIndex)] == " " {
                    score += 5
                }
                
                previousMatchIndex = sourceIndex
                patternIndex = pattern.index(after: patternIndex)
            }
        }
        
        // Return 0 if pattern not fully matched
        return patternIndex == pattern.endIndex ? score : 0
    }
    
    /// Checks if string fuzzy matches pattern.
    ///
    /// - Parameter pattern: Pattern to match.
    /// - Returns: `true` if matches.
    func fuzzyMatches(_ pattern: String) -> Bool {
        return fuzzyMatch(pattern) > 0
    }
    
    /// Returns fuzzy match score normalized to 0-100.
    ///
    /// - Parameter pattern: Pattern to match.
    /// - Returns: Normalized score from 0 to 100.
    func fuzzyMatchScore(_ pattern: String) -> Double {
        guard !isEmpty && !pattern.isEmpty else { return 0 }
        
        let rawScore = fuzzyMatch(pattern)
        guard rawScore > 0 else { return 0 }
        
        let maxPossibleScore = Double(pattern.count) * 8 // Approximate max score
        return min(100, Double(rawScore) / maxPossibleScore * 100)
    }
    
    // MARK: - Levenshtein Distance
    
    /// Calculates Levenshtein distance to another string.
    ///
    /// - Parameter target: String to compare with.
    /// - Returns: Edit distance (number of edits required).
    ///
    /// ```swift
    /// "kitten".levenshteinDistance(to: "sitting")    // 3
    /// ```
    func levenshteinDistance(to target: String) -> Int {
        let source = Array(self)
        let target = Array(target)
        
        if source.isEmpty { return target.count }
        if target.isEmpty { return source.count }
        
        var matrix = [[Int]](
            repeating: [Int](repeating: 0, count: target.count + 1),
            count: source.count + 1
        )
        
        for i in 0...source.count {
            matrix[i][0] = i
        }
        
        for j in 0...target.count {
            matrix[0][j] = j
        }
        
        for i in 1...source.count {
            for j in 1...target.count {
                let cost = source[i - 1] == target[j - 1] ? 0 : 1
                matrix[i][j] = min(
                    matrix[i - 1][j] + 1,      // deletion
                    matrix[i][j - 1] + 1,      // insertion
                    matrix[i - 1][j - 1] + cost // substitution
                )
            }
        }
        
        return matrix[source.count][target.count]
    }
    
    /// Calculates similarity percentage based on Levenshtein distance.
    ///
    /// - Parameter target: String to compare with.
    /// - Returns: Similarity from 0.0 to 1.0.
    func similarity(to target: String) -> Double {
        let maxLength = max(count, target.count)
        guard maxLength > 0 else { return 1.0 }
        
        let distance = levenshteinDistance(to: target)
        return 1.0 - (Double(distance) / Double(maxLength))
    }
    
    // MARK: - Pattern Finding
    
    /// Finds all ranges of substring.
    ///
    /// - Parameter substring: Substring to find.
    /// - Returns: Array of ranges.
    func ranges(of substring: String) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        var searchRange = startIndex..<endIndex
        
        while let range = range(of: substring, options: [], range: searchRange) {
            ranges.append(range)
            searchRange = range.upperBound..<endIndex
        }
        
        return ranges
    }
    
    /// Finds all ranges matching regex pattern.
    ///
    /// - Parameter pattern: Regular expression pattern.
    /// - Returns: Array of ranges.
    func ranges(matching pattern: String) -> [Range<String.Index>] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let nsRange = NSRange(startIndex..., in: self)
        let results = regex.matches(in: self, range: nsRange)
        
        return results.compactMap { Range($0.range, in: self) }
    }
    
    /// Finds all matches for regex pattern.
    ///
    /// - Parameter pattern: Regular expression pattern.
    /// - Returns: Array of matching strings.
    func matches(for pattern: String) -> [String] {
        return ranges(matching: pattern).map { String(self[$0]) }
    }
    
    // MARK: - Word Search
    
    /// Finds all words in string.
    ///
    /// - Returns: Array of words.
    var words: [String] {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
    }
    
    /// Counts words in string.
    var wordCount: Int {
        return words.count
    }
    
    /// Checks if string contains whole word.
    ///
    /// - Parameter word: Word to search for.
    /// - Returns: `true` if contains whole word.
    ///
    /// ```swift
    /// "Hello World".containsWord("World")    // true
    /// "Hello World".containsWord("Wor")      // false
    /// ```
    func containsWord(_ word: String) -> Bool {
        let pattern = "\\b\(NSRegularExpression.escapedPattern(for: word))\\b"
        return range(of: pattern, options: .regularExpression) != nil
    }
    
    /// Finds indices of word occurrences.
    ///
    /// - Parameter word: Word to find.
    /// - Returns: Array of word indices.
    func wordIndices(of word: String) -> [Int] {
        var indices: [Int] = []
        let words = self.words
        
        for (index, w) in words.enumerated() {
            if w.lowercased() == word.lowercased() {
                indices.append(index)
            }
        }
        
        return indices
    }
    
    // MARK: - Character Search
    
    /// Finds indices of character occurrences.
    ///
    /// - Parameter character: Character to find.
    /// - Returns: Array of indices.
    func indices(of character: Character) -> [Int] {
        return enumerated().compactMap { $0.element == character ? $0.offset : nil }
    }
    
    /// Finds first index of character.
    ///
    /// - Parameter character: Character to find.
    /// - Returns: Index or nil if not found.
    func firstIndex(of character: Character) -> Int? {
        return firstIndex(of: character).map { distance(from: startIndex, to: $0) }
    }
    
    /// Finds last index of character.
    ///
    /// - Parameter character: Character to find.
    /// - Returns: Index or nil if not found.
    func lastIndexOf(_ character: Character) -> Int? {
        return lastIndex(of: character).map { distance(from: startIndex, to: $0) }
    }
    
    // MARK: - Highlighting
    
    /// Highlights search term with markers.
    ///
    /// - Parameters:
    ///   - term: Term to highlight.
    ///   - prefix: Highlight prefix (default: "<mark>").
    ///   - suffix: Highlight suffix (default: "</mark>").
    /// - Returns: String with highlighted terms.
    func highlighting(
        _ term: String,
        prefix: String = "<mark>",
        suffix: String = "</mark>"
    ) -> String {
        return replacingOccurrences(
            of: term,
            with: prefix + term + suffix,
            options: .caseInsensitive
        )
    }
    
    /// Creates excerpt around search term.
    ///
    /// - Parameters:
    ///   - term: Term to find.
    ///   - radius: Number of characters around term.
    ///   - ellipsis: Ellipsis for truncation.
    /// - Returns: Excerpt string or nil if not found.
    func excerpt(
        around term: String,
        radius: Int = 50,
        ellipsis: String = "..."
    ) -> String? {
        guard let range = range(of: term, options: .caseInsensitive) else { return nil }
        
        let termStart = distance(from: startIndex, to: range.lowerBound)
        let termEnd = distance(from: startIndex, to: range.upperBound)
        
        let excerptStart = max(0, termStart - radius)
        let excerptEnd = min(count, termEnd + radius)
        
        let startIndex = index(self.startIndex, offsetBy: excerptStart)
        let endIndex = index(self.startIndex, offsetBy: excerptEnd)
        
        var result = String(self[startIndex..<endIndex])
        
        if excerptStart > 0 {
            result = ellipsis + result
        }
        if excerptEnd < count {
            result = result + ellipsis
        }
        
        return result
    }
}
