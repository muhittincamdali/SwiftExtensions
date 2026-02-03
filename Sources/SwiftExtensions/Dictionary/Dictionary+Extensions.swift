import Foundation

extension Dictionary {

    /// Merges this dictionary with another, preferring values from the other dictionary.
    ///
    /// ```swift
    /// ["a": 1, "b": 2].deepMerged(with: ["b": 3, "c": 4])
    /// // ["a": 1, "b": 3, "c": 4]
    /// ```
    ///
    /// - Parameter other: The dictionary to merge in.
    /// - Returns: A new merged dictionary.
    public func deepMerged(with other: [Key: Value]) -> [Key: Value] {
        merging(other) { _, new in new }
    }

    /// Transforms all keys using the given closure.
    ///
    /// ```swift
    /// ["a": 1].mapKeys { $0.uppercased() } // ["A": 1]
    /// ```
    ///
    /// - Parameter transform: A closure that maps each key.
    /// - Returns: A new dictionary with transformed keys.
    public func mapKeys<T: Hashable>(_ transform: (Key) -> T) -> [T: Value] {
        reduce(into: [:]) { result, pair in
            result[transform(pair.key)] = pair.value
        }
    }

    /// Returns a JSON string representation of the dictionary.
    ///
    /// Requires keys and values to be JSON-compatible types.
    ///
    /// - Parameter prettyPrinted: Whether to format the output. Defaults to `false`.
    /// - Returns: A JSON string, or `nil` if serialization fails.
    public func toJSONString(prettyPrinted: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options: JSONSerialization.WritingOptions = prettyPrinted ? .prettyPrinted : []
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: options) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    /// Returns a new dictionary containing only key-value pairs matching the predicate.
    ///
    /// - Parameter isIncluded: Closure that determines whether to include a pair.
    /// - Returns: Filtered dictionary.
    public func filterValues(_ isIncluded: (Value) -> Bool) -> [Key: Value] {
        filter { isIncluded($0.value) }
    }

    /// Returns `true` if the dictionary contains the specified key.
    public func hasKey(_ key: Key) -> Bool {
        self[key] != nil
    }
}
