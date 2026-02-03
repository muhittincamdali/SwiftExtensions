import Foundation

// MARK: - Array Grouping Extensions

public extension Array {
    
    // MARK: - Chunking
    
    /// Splits array into chunks of specified size.
    ///
    /// - Parameter size: Size of each chunk.
    /// - Returns: Array of chunks.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].chunked(into: 2)    // [[1, 2], [3, 4], [5]]
    /// ```
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
    /// Splits array into specified number of chunks.
    ///
    /// - Parameter count: Number of chunks.
    /// - Returns: Array of chunks.
    func split(into count: Int) -> [[Element]] {
        guard count > 0 else { return [] }
        
        let chunkSize = (self.count + count - 1) / count
        return chunked(into: chunkSize)
    }
    
    /// Splits array based on condition.
    ///
    /// - Parameter isSeparator: Condition to split on.
    /// - Returns: Array of arrays split at separator elements.
    func split(where isSeparator: (Element) -> Bool) -> [[Element]] {
        var result: [[Element]] = []
        var current: [Element] = []
        
        for element in self {
            if isSeparator(element) {
                if !current.isEmpty {
                    result.append(current)
                    current = []
                }
            } else {
                current.append(element)
            }
        }
        
        if !current.isEmpty {
            result.append(current)
        }
        
        return result
    }
    
    // MARK: - Grouping
    
    /// Groups elements by key.
    ///
    /// - Parameter keySelector: Closure returning group key.
    /// - Returns: Dictionary of grouped elements.
    ///
    /// ```swift
    /// ["apple", "banana", "avocado"].grouped(by: { $0.first! })
    /// // ["a": ["apple", "avocado"], "b": ["banana"]]
    /// ```
    func grouped<Key: Hashable>(by keySelector: (Element) -> Key) -> [Key: [Element]] {
        return Dictionary(grouping: self, by: keySelector)
    }
    
    /// Groups elements by keypath.
    ///
    /// - Parameter keyPath: KeyPath to group by.
    /// - Returns: Dictionary of grouped elements.
    func grouped<Key: Hashable>(by keyPath: KeyPath<Element, Key>) -> [Key: [Element]] {
        return grouped(by: { $0[keyPath: keyPath] })
    }
    
    /// Groups consecutive elements that satisfy condition.
    ///
    /// - Parameter belongToSameGroup: Condition for grouping.
    /// - Returns: Array of consecutive groups.
    func groupedConsecutive(by belongToSameGroup: (Element, Element) -> Bool) -> [[Element]] {
        guard let first = first else { return [] }
        
        var result: [[Element]] = [[first]]
        
        for element in dropFirst() {
            if belongToSameGroup(result.last!.last!, element) {
                result[result.count - 1].append(element)
            } else {
                result.append([element])
            }
        }
        
        return result
    }
    
    // MARK: - Unique
    
    /// Returns array with duplicate elements removed (preserving order).
    ///
    /// - Parameter keySelector: Closure returning unique key.
    /// - Returns: Array with duplicates removed.
    func uniqued<Key: Hashable>(by keySelector: (Element) -> Key) -> [Element] {
        var seen = Set<Key>()
        return filter { element in
            let key = keySelector(element)
            if seen.contains(key) {
                return false
            }
            seen.insert(key)
            return true
        }
    }
    
    /// Returns array with unique elements by keypath.
    ///
    /// - Parameter keyPath: KeyPath for uniqueness.
    /// - Returns: Array with duplicates removed.
    func uniqued<Key: Hashable>(by keyPath: KeyPath<Element, Key>) -> [Element] {
        return uniqued(by: { $0[keyPath: keyPath] })
    }
}

// MARK: - Equatable Element Extensions

public extension Array where Element: Equatable {
    
    /// Returns array with duplicate elements removed.
    ///
    /// ```swift
    /// [1, 2, 2, 3, 1].uniqued    // [1, 2, 3]
    /// ```
    var uniqued: [Element] {
        var result: [Element] = []
        for element in self {
            if !result.contains(element) {
                result.append(element)
            }
        }
        return result
    }
    
    /// Removes duplicate elements in place.
    mutating func removeDuplicates() {
        self = uniqued
    }
    
    /// Returns indices of duplicate elements.
    var duplicateIndices: [Int] {
        var seen: [Element] = []
        var duplicates: [Int] = []
        
        for (index, element) in enumerated() {
            if seen.contains(element) {
                duplicates.append(index)
            } else {
                seen.append(element)
            }
        }
        
        return duplicates
    }
}

// MARK: - Hashable Element Extensions

public extension Array where Element: Hashable {
    
    /// Returns array with duplicate elements removed (faster for Hashable).
    var uniquedHashable: [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
    
    /// Returns duplicate elements.
    var duplicates: [Element] {
        var seen = Set<Element>()
        var duplicates = Set<Element>()
        
        for element in self {
            if !seen.insert(element).inserted {
                duplicates.insert(element)
            }
        }
        
        return Array(duplicates)
    }
    
    /// Returns frequency count of elements.
    var frequencies: [Element: Int] {
        return reduce(into: [:]) { counts, element in
            counts[element, default: 0] += 1
        }
    }
    
    /// Returns most frequent element.
    var mostFrequent: Element? {
        return frequencies.max(by: { $0.value < $1.value })?.key
    }
    
    /// Returns least frequent element.
    var leastFrequent: Element? {
        return frequencies.min(by: { $0.value < $1.value })?.key
    }
}

// MARK: - Partitioning

public extension Array {
    
    /// Partitions array into two arrays based on condition.
    ///
    /// - Parameter condition: Condition for partitioning.
    /// - Returns: Tuple of (matching, non-matching) arrays.
    ///
    /// ```swift
    /// let (evens, odds) = [1, 2, 3, 4, 5].partitioned { $0 % 2 == 0 }
    /// // evens: [2, 4], odds: [1, 3, 5]
    /// ```
    func partitioned(by condition: (Element) -> Bool) -> (matching: [Element], nonMatching: [Element]) {
        var matching: [Element] = []
        var nonMatching: [Element] = []
        
        for element in self {
            if condition(element) {
                matching.append(element)
            } else {
                nonMatching.append(element)
            }
        }
        
        return (matching, nonMatching)
    }
    
    /// Returns head and tail of array.
    ///
    /// - Returns: Tuple of (first element, remaining elements) or nil if empty.
    func headAndTail() -> (head: Element, tail: [Element])? {
        guard let head = first else { return nil }
        return (head, Array(dropFirst()))
    }
    
    /// Returns init and last of array.
    ///
    /// - Returns: Tuple of (all but last, last element) or nil if empty.
    func initAndLast() -> (initial: [Element], last: Element)? {
        guard let last = last else { return nil }
        return (Array(dropLast()), last)
    }
}

// MARK: - Sliding Window

public extension Array {
    
    /// Returns sliding windows of specified size.
    ///
    /// - Parameter size: Window size.
    /// - Returns: Array of windows.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].slidingWindows(of: 3)
    /// // [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
    /// ```
    func slidingWindows(of size: Int) -> [[Element]] {
        guard size > 0 && size <= count else { return [] }
        
        return (0...(count - size)).map { startIndex in
            Array(self[startIndex..<(startIndex + size)])
        }
    }
    
    /// Returns pairs of consecutive elements.
    ///
    /// ```swift
    /// [1, 2, 3, 4].consecutivePairs    // [(1, 2), (2, 3), (3, 4)]
    /// ```
    var consecutivePairs: [(Element, Element)] {
        guard count >= 2 else { return [] }
        return zip(self, dropFirst()).map { ($0, $1) }
    }
    
    /// Returns triplets of consecutive elements.
    var consecutiveTriplets: [(Element, Element, Element)] {
        guard count >= 3 else { return [] }
        return zip(zip(self, dropFirst()), dropFirst(2)).map { ($0.0, $0.1, $1) }
    }
}

// MARK: - Interleaving

public extension Array {
    
    /// Interleaves elements with another array.
    ///
    /// - Parameter other: Array to interleave with.
    /// - Returns: Interleaved array.
    ///
    /// ```swift
    /// [1, 3, 5].interleaved(with: [2, 4, 6])    // [1, 2, 3, 4, 5, 6]
    /// ```
    func interleaved(with other: [Element]) -> [Element] {
        var result: [Element] = []
        let maxLength = Swift.max(count, other.count)
        
        for i in 0..<maxLength {
            if i < count { result.append(self[i]) }
            if i < other.count { result.append(other[i]) }
        }
        
        return result
    }
    
    /// Inserts separator between elements.
    ///
    /// - Parameter separator: Element to insert.
    /// - Returns: Array with separators.
    ///
    /// ```swift
    /// [1, 2, 3].interspersed(with: 0)    // [1, 0, 2, 0, 3]
    /// ```
    func interspersed(with separator: Element) -> [Element] {
        guard count > 1 else { return self }
        
        var result: [Element] = []
        for (index, element) in enumerated() {
            result.append(element)
            if index < count - 1 {
                result.append(separator)
            }
        }
        
        return result
    }
}
