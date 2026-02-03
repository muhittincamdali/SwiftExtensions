import Foundation

// MARK: - Dictionary Merge Extensions

public extension Dictionary {
    
    // MARK: - Basic Merging
    
    /// Merges with another dictionary, keeping values from other on conflict.
    ///
    /// - Parameter other: Dictionary to merge with.
    /// - Returns: Merged dictionary.
    ///
    /// ```swift
    /// let dict1 = ["a": 1, "b": 2]
    /// let dict2 = ["b": 3, "c": 4]
    /// dict1.merged(with: dict2)    // ["a": 1, "b": 3, "c": 4]
    /// ```
    func merged(with other: [Key: Value]) -> [Key: Value] {
        var result = self
        result.merge(other) { _, new in new }
        return result
    }
    
    /// Merges with another dictionary, keeping values from self on conflict.
    ///
    /// - Parameter other: Dictionary to merge with.
    /// - Returns: Merged dictionary.
    func mergedKeepingCurrent(with other: [Key: Value]) -> [Key: Value] {
        var result = self
        result.merge(other) { current, _ in current }
        return result
    }
    
    /// Merges with custom conflict resolver.
    ///
    /// - Parameters:
    ///   - other: Dictionary to merge with.
    ///   - resolver: Closure to resolve conflicts.
    /// - Returns: Merged dictionary.
    func merged(with other: [Key: Value], uniquingKeysWith resolver: (Value, Value) -> Value) -> [Key: Value] {
        var result = self
        result.merge(other, uniquingKeysWith: resolver)
        return result
    }
    
    /// Merges in place with another dictionary.
    ///
    /// - Parameter other: Dictionary to merge with.
    mutating func merge(with other: [Key: Value]) {
        merge(other) { _, new in new }
    }
    
    // MARK: - Deep Merging
    
    /// Deep merges nested dictionaries.
    ///
    /// When both values are dictionaries, recursively merges them.
    ///
    /// - Parameter other: Dictionary to merge with.
    /// - Returns: Deep merged dictionary.
    func deepMerged(with other: [Key: Value]) -> [Key: Value] where Value == Any {
        var result = self
        
        for (key, otherValue) in other {
            if let currentDict = result[key] as? [Key: Value],
               let otherDict = otherValue as? [Key: Value] {
                result[key] = currentDict.deepMerged(with: otherDict) as? Value
            } else {
                result[key] = otherValue
            }
        }
        
        return result
    }
    
    // MARK: - Merging Multiple Dictionaries
    
    /// Creates dictionary from merging multiple dictionaries.
    ///
    /// - Parameter dictionaries: Dictionaries to merge.
    /// - Returns: Merged dictionary.
    static func merging(_ dictionaries: [[Key: Value]]) -> [Key: Value] {
        var result: [Key: Value] = [:]
        
        for dict in dictionaries {
            result.merge(dict) { _, new in new }
        }
        
        return result
    }
    
    /// Merges with multiple other dictionaries.
    ///
    /// - Parameter others: Dictionaries to merge with.
    /// - Returns: Merged dictionary.
    func merged(with others: [Key: Value]...) -> [Key: Value] {
        var result = self
        
        for other in others {
            result.merge(other) { _, new in new }
        }
        
        return result
    }
    
    // MARK: - Conditional Merging
    
    /// Merges only new keys (doesn't override existing).
    ///
    /// - Parameter other: Dictionary to merge with.
    /// - Returns: Dictionary with new keys added.
    func mergedNewKeysOnly(from other: [Key: Value]) -> [Key: Value] {
        var result = self
        
        for (key, value) in other {
            if result[key] == nil {
                result[key] = value
            }
        }
        
        return result
    }
    
    /// Merges only specified keys from another dictionary.
    ///
    /// - Parameters:
    ///   - other: Source dictionary.
    ///   - keys: Keys to merge.
    /// - Returns: Merged dictionary.
    func merged(from other: [Key: Value], onlyKeys keys: Set<Key>) -> [Key: Value] {
        var result = self
        
        for key in keys {
            if let value = other[key] {
                result[key] = value
            }
        }
        
        return result
    }
    
    /// Merges excluding specified keys.
    ///
    /// - Parameters:
    ///   - other: Source dictionary.
    ///   - keys: Keys to exclude.
    /// - Returns: Merged dictionary.
    func merged(from other: [Key: Value], excludingKeys keys: Set<Key>) -> [Key: Value] {
        var result = self
        
        for (key, value) in other {
            if !keys.contains(key) {
                result[key] = value
            }
        }
        
        return result
    }
    
    // MARK: - Union/Intersection
    
    /// Returns dictionary containing only keys present in both.
    ///
    /// - Parameter other: Dictionary to intersect with.
    /// - Returns: Dictionary with common keys (values from self).
    func intersection(with other: [Key: Value]) -> [Key: Value] {
        return filter { other.keys.contains($0.key) }
    }
    
    /// Returns dictionary containing only keys unique to self.
    ///
    /// - Parameter other: Dictionary to subtract.
    /// - Returns: Dictionary with keys not in other.
    func subtracting(_ other: [Key: Value]) -> [Key: Value] {
        return filter { !other.keys.contains($0.key) }
    }
    
    /// Returns symmetric difference (keys in either but not both).
    ///
    /// - Parameter other: Other dictionary.
    /// - Returns: Dictionary with symmetric difference.
    func symmetricDifference(with other: [Key: Value]) -> [Key: Value] {
        var result = subtracting(other)
        result.merge(other.subtracting(self)) { _, new in new }
        return result
    }
}

// MARK: - Operators

public extension Dictionary {
    
    /// Merges two dictionaries using + operator.
    ///
    /// ```swift
    /// let merged = dict1 + dict2
    /// ```
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        return lhs.merged(with: rhs)
    }
    
    /// Merges dictionary in place using += operator.
    ///
    /// ```swift
    /// dict1 += dict2
    /// ```
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(with: rhs)
    }
}
