import Foundation

// MARK: - Dictionary Transform Extensions

public extension Dictionary {
    
    // MARK: - Key Transformation
    
    /// Maps keys using transform function.
    ///
    /// - Parameter transform: Key transformation closure.
    /// - Returns: Dictionary with transformed keys.
    ///
    /// ```swift
    /// ["a": 1, "b": 2].mapKeys { $0.uppercased() }
    /// // ["A": 1, "B": 2]
    /// ```
    func mapKeys<NewKey: Hashable>(_ transform: (Key) -> NewKey) -> [NewKey: Value] {
        return Dictionary<NewKey, Value>(uniqueKeysWithValues: map { (transform($0.key), $0.value) })
    }
    
    /// Maps keys using keypath.
    ///
    /// - Parameter keyPath: KeyPath to new key.
    /// - Returns: Dictionary with transformed keys.
    func mapKeys<NewKey: Hashable>(_ keyPath: KeyPath<Key, NewKey>) -> [NewKey: Value] {
        return mapKeys { $0[keyPath: keyPath] }
    }
    
    /// Compact maps keys, removing nil results.
    ///
    /// - Parameter transform: Optional key transformation.
    /// - Returns: Dictionary with transformed keys.
    func compactMapKeys<NewKey: Hashable>(_ transform: (Key) -> NewKey?) -> [NewKey: Value] {
        return compactMap { key, value in
            guard let newKey = transform(key) else { return nil }
            return (newKey, value)
        }.reduce(into: [:]) { $0[$1.0] = $1.1 }
    }
    
    // MARK: - Value Transformation
    
    /// Maps values using transform function.
    ///
    /// - Parameter transform: Value transformation closure.
    /// - Returns: Dictionary with transformed values.
    ///
    /// ```swift
    /// ["a": 1, "b": 2].mapValues { $0 * 2 }
    /// // ["a": 2, "b": 4]
    /// ```
    func transformValues<NewValue>(_ transform: (Value) -> NewValue) -> [Key: NewValue] {
        return mapValues(transform)
    }
    
    /// Compact maps values, removing nil results.
    ///
    /// - Parameter transform: Optional value transformation.
    /// - Returns: Dictionary with transformed values.
    func compactMapValues<NewValue>(_ transform: (Value) -> NewValue?) -> [Key: NewValue] {
        return compactMapValues(transform)
    }
    
    /// Maps values using keypath.
    ///
    /// - Parameter keyPath: KeyPath to new value.
    /// - Returns: Dictionary with transformed values.
    func mapValues<NewValue>(_ keyPath: KeyPath<Value, NewValue>) -> [Key: NewValue] {
        return mapValues { $0[keyPath: keyPath] }
    }
    
    // MARK: - Full Transformation
    
    /// Transforms both keys and values.
    ///
    /// - Parameter transform: Closure transforming key-value pair.
    /// - Returns: Transformed dictionary.
    func mapKeysAndValues<NewKey: Hashable, NewValue>(
        _ transform: (Key, Value) -> (NewKey, NewValue)
    ) -> [NewKey: NewValue] {
        return Dictionary<NewKey, NewValue>(uniqueKeysWithValues: map { transform($0.key, $0.value) })
    }
    
    /// Compact maps both keys and values.
    func compactMapKeysAndValues<NewKey: Hashable, NewValue>(
        _ transform: (Key, Value) -> (NewKey, NewValue)?
    ) -> [NewKey: NewValue] {
        var result: [NewKey: NewValue] = [:]
        for (key, value) in self {
            if let (newKey, newValue) = transform(key, value) {
                result[newKey] = newValue
            }
        }
        return result
    }
    
    // MARK: - Filtering
    
    /// Filters dictionary by keys.
    ///
    /// - Parameter isIncluded: Predicate for key inclusion.
    /// - Returns: Filtered dictionary.
    func filterKeys(_ isIncluded: (Key) -> Bool) -> [Key: Value] {
        return filter { isIncluded($0.key) }
    }
    
    /// Filters dictionary by values.
    ///
    /// - Parameter isIncluded: Predicate for value inclusion.
    /// - Returns: Filtered dictionary.
    func filterValues(_ isIncluded: (Value) -> Bool) -> [Key: Value] {
        return filter { isIncluded($0.value) }
    }
    
    /// Returns dictionary containing only specified keys.
    ///
    /// - Parameter keys: Keys to include.
    /// - Returns: Filtered dictionary.
    func picking(_ keys: Set<Key>) -> [Key: Value] {
        return filter { keys.contains($0.key) }
    }
    
    /// Returns dictionary containing only specified keys (variadic).
    func picking(_ keys: Key...) -> [Key: Value] {
        return picking(Set(keys))
    }
    
    /// Returns dictionary excluding specified keys.
    ///
    /// - Parameter keys: Keys to exclude.
    /// - Returns: Filtered dictionary.
    func omitting(_ keys: Set<Key>) -> [Key: Value] {
        return filter { !keys.contains($0.key) }
    }
    
    /// Returns dictionary excluding specified keys (variadic).
    func omitting(_ keys: Key...) -> [Key: Value] {
        return omitting(Set(keys))
    }
    
    // MARK: - Inversion
    
    /// Inverts dictionary (swaps keys and values).
    ///
    /// - Returns: Inverted dictionary.
    func inverted() -> [Value: Key] where Value: Hashable {
        return Dictionary<Value, Key>(uniqueKeysWithValues: map { ($0.value, $0.key) })
    }
    
    /// Groups values by their value, producing dictionary of arrays.
    func grouped() -> [Value: [Key]] where Value: Hashable {
        var result: [Value: [Key]] = [:]
        for (key, value) in self {
            result[value, default: []].append(key)
        }
        return result
    }
    
    // MARK: - Flattening
    
    /// Flattens nested dictionary with separator.
    ///
    /// - Parameter separator: Key separator (default: ".").
    /// - Returns: Flattened dictionary.
    ///
    /// ```swift
    /// ["a": ["b": 1, "c": 2]].flattened()
    /// // ["a.b": 1, "a.c": 2]
    /// ```
    func flattened(separator: String = ".") -> [String: Any] where Key == String, Value == Any {
        var result: [String: Any] = [:]
        
        func flatten(_ dict: [String: Any], prefix: String) {
            for (key, value) in dict {
                let newKey = prefix.isEmpty ? key : "\(prefix)\(separator)\(key)"
                
                if let nested = value as? [String: Any] {
                    flatten(nested, prefix: newKey)
                } else {
                    result[newKey] = value
                }
            }
        }
        
        flatten(self, prefix: "")
        return result
    }
    
    /// Unflattens dictionary by separator.
    ///
    /// - Parameter separator: Key separator.
    /// - Returns: Nested dictionary.
    func unflattened(separator: String = ".") -> [String: Any] where Key == String, Value == Any {
        var result: [String: Any] = [:]
        
        for (key, value) in self {
            let keys = key.split(separator: Character(separator)).map(String.init)
            var current = result
            
            for (index, k) in keys.enumerated() {
                if index == keys.count - 1 {
                    current[k] = value
                } else {
                    if current[k] == nil {
                        current[k] = [String: Any]()
                    }
                    if var nested = current[k] as? [String: Any] {
                        current = nested
                    }
                }
            }
            
            // Rebuild from leaves
            var temp = result
            var currentRef: [String: Any]? = temp
            for k in keys.dropLast() {
                if var nested = currentRef?[k] as? [String: Any] {
                    currentRef = nested
                }
            }
            if let lastKey = keys.last {
                currentRef?[lastKey] = value
            }
        }
        
        return result
    }
    
    // MARK: - Default Value Transform
    
    /// Returns value for key or inserts default.
    ///
    /// - Parameters:
    ///   - key: Key to look up.
    ///   - defaultValue: Default value if key doesn't exist.
    /// - Returns: Existing or default value.
    mutating func getOrSet(_ key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        if let existing = self[key] {
            return existing
        }
        let value = defaultValue()
        self[key] = value
        return value
    }
}
