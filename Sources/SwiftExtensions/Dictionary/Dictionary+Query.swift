import Foundation

// MARK: - Dictionary Query Extensions

public extension Dictionary {
    
    // MARK: - Key Queries
    
    /// Returns array of all keys.
    var keyArray: [Key] {
        return Array(keys)
    }
    
    /// Returns array of all values.
    var valueArray: [Value] {
        return Array(values)
    }
    
    /// Returns sorted keys array.
    func sortedKeys() -> [Key] where Key: Comparable {
        return keys.sorted()
    }
    
    /// Returns keys sorted by values.
    func keysSortedByValue() -> [Key] where Value: Comparable {
        return keys.sorted { self[$0]! < self[$1]! }
    }
    
    /// Checks if dictionary contains key.
    ///
    /// - Parameter key: Key to check.
    /// - Returns: `true` if key exists.
    func hasKey(_ key: Key) -> Bool {
        return self[key] != nil
    }
    
    /// Checks if dictionary contains all specified keys.
    func hasAllKeys(_ keys: [Key]) -> Bool {
        return keys.allSatisfy { hasKey($0) }
    }
    
    /// Checks if dictionary contains any of specified keys.
    func hasAnyKey(_ keys: [Key]) -> Bool {
        return keys.contains { hasKey($0) }
    }
    
    // MARK: - Value Queries
    
    /// Returns first key for given value.
    func key(forValue value: Value) -> Key? where Value: Equatable {
        return first { $0.value == value }?.key
    }
    
    /// Returns all keys for given value.
    func keys(forValue value: Value) -> [Key] where Value: Equatable {
        return filter { $0.value == value }.map { $0.key }
    }
    
    /// Checks if dictionary contains value.
    func containsValue(_ value: Value) -> Bool where Value: Equatable {
        return values.contains(value)
    }
    
    /// Returns count of occurrences of value.
    func count(of value: Value) -> Int where Value: Equatable {
        return values.filter { $0 == value }.count
    }
    
    // MARK: - Random Access
    
    /// Returns random key-value pair.
    var randomElement: (key: Key, value: Value)? {
        guard !isEmpty else { return nil }
        let index = Int.random(in: 0..<count)
        let key = Array(keys)[index]
        return (key, self[key]!)
    }
    
    /// Returns random key.
    var randomKey: Key? {
        return randomElement?.key
    }
    
    /// Returns random value.
    var randomValue: Value? {
        return randomElement?.value
    }
    
    // MARK: - Finding
    
    /// Finds first key-value pair matching predicate.
    ///
    /// - Parameter predicate: Matching condition.
    /// - Returns: First matching pair or nil.
    func find(_ predicate: (Key, Value) -> Bool) -> (key: Key, value: Value)? {
        return first { predicate($0.key, $0.value) }
    }
    
    /// Finds all key-value pairs matching predicate.
    func findAll(_ predicate: (Key, Value) -> Bool) -> [(key: Key, value: Value)] {
        return filter { predicate($0.key, $0.value) }.map { ($0.key, $0.value) }
    }
    
    // MARK: - Aggregation
    
    /// Returns minimum value and its key.
    func minByValue() -> (key: Key, value: Value)? where Value: Comparable {
        return min(by: { $0.value < $1.value })
    }
    
    /// Returns maximum value and its key.
    func maxByValue() -> (key: Key, value: Value)? where Value: Comparable {
        return max(by: { $0.value < $1.value })
    }
    
    /// Reduces values with initial result.
    func reduceValues<T>(_ initialResult: T, _ nextPartialResult: (T, Value) -> T) -> T {
        return values.reduce(initialResult, nextPartialResult)
    }
}

// MARK: - Numeric Value Extensions

public extension Dictionary where Value: Numeric {
    
    /// Returns sum of all values.
    var sum: Value {
        return values.reduce(0, +)
    }
    
    /// Returns sum for specific keys.
    func sum(forKeys keys: [Key]) -> Value {
        return keys.compactMap { self[$0] }.reduce(0, +)
    }
}

public extension Dictionary where Value == Int {
    
    /// Returns average of all values.
    var average: Double {
        guard !isEmpty else { return 0 }
        return Double(sum) / Double(count)
    }
}

public extension Dictionary where Value == Double {
    
    /// Returns average of all values.
    var average: Double {
        guard !isEmpty else { return 0 }
        return sum / Double(count)
    }
}

// MARK: - Path-based Access

public extension Dictionary where Key == String {
    
    /// Returns value at dot-separated key path.
    ///
    /// - Parameter keyPath: Dot-separated path (e.g., "user.profile.name").
    /// - Returns: Value at path or nil.
    func value(at keyPath: String) -> Value? {
        let keys = keyPath.split(separator: ".").map(String.init)
        guard let firstKey = keys.first else { return nil }
        
        if keys.count == 1 {
            return self[firstKey]
        }
        
        guard let nestedDict = self[firstKey] as? [String: Value] else { return nil }
        let remainingPath = keys.dropFirst().joined(separator: ".")
        return nestedDict.value(at: remainingPath)
    }
    
    /// Sets value at dot-separated key path.
    ///
    /// - Parameters:
    ///   - value: Value to set.
    ///   - keyPath: Dot-separated path.
    mutating func setValue(_ value: Value, at keyPath: String) where Value == Any {
        let keys = keyPath.split(separator: ".").map(String.init)
        guard !keys.isEmpty else { return }
        
        if keys.count == 1 {
            self[keys[0]] = value
            return
        }
        
        var current = self
        var stack: [(String, [String: Any])] = []
        
        for (index, key) in keys.dropLast().enumerated() {
            if var nested = current[key] as? [String: Any] {
                stack.append((key, current))
                current = nested
            } else {
                current[key] = [String: Any]()
                stack.append((key, current))
                current = current[key] as! [String: Any]
            }
        }
        
        if let lastKey = keys.last {
            current[lastKey] = value
        }
        
        // Rebuild the dictionary
        var result = current as! [String: Value]
        for (key, dict) in stack.reversed() {
            var d = dict
            d[key] = result as? Value
            result = d as! [String: Value]
        }
        
        self = result
    }
}

// MARK: - JSON Query Helpers

public extension Dictionary where Key == String, Value == Any {
    
    /// Returns string at key path.
    func string(at keyPath: String) -> String? {
        return value(at: keyPath) as? String
    }
    
    /// Returns int at key path.
    func int(at keyPath: String) -> Int? {
        return value(at: keyPath) as? Int
    }
    
    /// Returns double at key path.
    func double(at keyPath: String) -> Double? {
        return value(at: keyPath) as? Double
    }
    
    /// Returns bool at key path.
    func bool(at keyPath: String) -> Bool? {
        return value(at: keyPath) as? Bool
    }
    
    /// Returns array at key path.
    func array(at keyPath: String) -> [Any]? {
        return value(at: keyPath) as? [Any]
    }
    
    /// Returns dictionary at key path.
    func dictionary(at keyPath: String) -> [String: Any]? {
        return value(at: keyPath) as? [String: Any]
    }
}
