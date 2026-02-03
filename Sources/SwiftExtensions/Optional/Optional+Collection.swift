import Foundation

// MARK: - Optional Collection Extensions

public extension Optional where Wrapped: Collection {
    
    // MARK: - Empty Handling
    
    /// Returns wrapped collection or empty instance.
    ///
    /// ```swift
    /// let items: [Int]? = nil
    /// items.orEmpty    // []
    /// ```
    var orEmpty: Wrapped where Wrapped: ExpressibleByArrayLiteral {
        return self ?? []
    }
    
    /// Returns nil if collection is empty.
    var nilIfEmpty: Wrapped? {
        guard let collection = self, !collection.isEmpty else { return nil }
        return collection
    }
    
    /// Returns first element or nil.
    var firstElement: Wrapped.Element? {
        return self?.first
    }
    
    // MARK: - Safe Access
    
    /// Safely accesses element at index.
    ///
    /// - Parameter index: Index to access.
    /// - Returns: Element at index or nil.
    func element(at index: Wrapped.Index) -> Wrapped.Element? {
        guard let collection = self,
              index >= collection.startIndex,
              index < collection.endIndex else { return nil }
        return collection[index]
    }
    
    /// Returns true if collection contains element.
    func contains(_ element: Wrapped.Element) -> Bool where Wrapped.Element: Equatable {
        return self?.contains(element) ?? false
    }
    
    /// Returns true if collection contains any element satisfying predicate.
    func contains(where predicate: (Wrapped.Element) -> Bool) -> Bool {
        return self?.contains(where: predicate) ?? false
    }
}

// MARK: - Optional Array Extensions

public extension Optional where Wrapped: RangeReplaceableCollection {
    
    /// Returns wrapped array or empty array.
    var orEmptyArray: Wrapped {
        return self ?? Wrapped()
    }
    
    /// Appends element to collection, creating new one if nil.
    ///
    /// - Parameter element: Element to append.
    /// - Returns: Collection with element appended.
    func appending(_ element: Wrapped.Element) -> Wrapped {
        var collection = self ?? Wrapped()
        collection.append(element)
        return collection
    }
    
    /// Appends contents of sequence to collection.
    ///
    /// - Parameter elements: Elements to append.
    /// - Returns: Collection with elements appended.
    func appending<S: Sequence>(contentsOf elements: S) -> Wrapped where S.Element == Wrapped.Element {
        var collection = self ?? Wrapped()
        collection.append(contentsOf: elements)
        return collection
    }
}

// MARK: - Optional Dictionary Extensions

public extension Optional where Wrapped == [String: Any] {
    
    /// Returns wrapped dictionary or empty dictionary.
    var orEmptyDictionary: [String: Any] {
        return self ?? [:]
    }
    
    /// Returns value for key or nil.
    ///
    /// - Parameter key: Key to access.
    /// - Returns: Value for key or nil.
    func value(forKey key: String) -> Any? {
        return self?[key]
    }
    
    /// Returns string value for key.
    func string(forKey key: String) -> String? {
        return self?[key] as? String
    }
    
    /// Returns int value for key.
    func int(forKey key: String) -> Int? {
        return self?[key] as? Int
    }
    
    /// Returns bool value for key.
    func bool(forKey key: String) -> Bool? {
        return self?[key] as? Bool
    }
    
    /// Returns double value for key.
    func double(forKey key: String) -> Double? {
        return self?[key] as? Double
    }
    
    /// Returns array value for key.
    func array(forKey key: String) -> [Any]? {
        return self?[key] as? [Any]
    }
    
    /// Returns dictionary value for key.
    func dictionary(forKey key: String) -> [String: Any]? {
        return self?[key] as? [String: Any]
    }
    
    /// Merges with another dictionary.
    ///
    /// - Parameter other: Dictionary to merge.
    /// - Returns: Merged dictionary.
    func merged(with other: [String: Any]) -> [String: Any] {
        var result = self ?? [:]
        result.merge(other) { _, new in new }
        return result
    }
}

// MARK: - Optional Set Extensions

public extension Optional where Wrapped: SetAlgebra {
    
    /// Returns wrapped set or empty set.
    var orEmptySet: Wrapped where Wrapped: ExpressibleByArrayLiteral {
        return self ?? []
    }
    
    /// Checks if set contains element.
    func contains(_ element: Wrapped.Element) -> Bool {
        return self?.contains(element) ?? false
    }
    
    /// Returns union with another set.
    func union(_ other: Wrapped) -> Wrapped {
        guard let set = self else { return other }
        return set.union(other)
    }
    
    /// Returns intersection with another set.
    func intersection(_ other: Wrapped) -> Wrapped? {
        return self?.intersection(other)
    }
}

// MARK: - Sequence Operations

public extension Optional where Wrapped: Sequence {
    
    /// Maps over elements if not nil.
    ///
    /// - Parameter transform: Transformation closure.
    /// - Returns: Transformed array or nil.
    func mapElements<T>(_ transform: (Wrapped.Element) -> T) -> [T]? {
        return self?.map(transform)
    }
    
    /// Filters elements if not nil.
    ///
    /// - Parameter isIncluded: Filter predicate.
    /// - Returns: Filtered array or nil.
    func filterElements(_ isIncluded: (Wrapped.Element) -> Bool) -> [Wrapped.Element]? {
        return self?.filter(isIncluded)
    }
    
    /// Compact maps over elements if not nil.
    ///
    /// - Parameter transform: Optional transformation closure.
    /// - Returns: Compact mapped array or nil.
    func compactMapElements<T>(_ transform: (Wrapped.Element) -> T?) -> [T]? {
        return self?.compactMap(transform)
    }
    
    /// Reduces elements if not nil.
    ///
    /// - Parameters:
    ///   - initialResult: Initial value.
    ///   - nextPartialResult: Reduction closure.
    /// - Returns: Reduced value or nil.
    func reduceElements<T>(_ initialResult: T, _ nextPartialResult: (T, Wrapped.Element) -> T) -> T? {
        return self?.reduce(initialResult, nextPartialResult)
    }
    
    /// Iterates over elements if not nil.
    ///
    /// - Parameter body: Iteration closure.
    func forEachElement(_ body: (Wrapped.Element) -> Void) {
        self?.forEach(body)
    }
    
    /// Returns first element matching predicate.
    func firstElement(where predicate: (Wrapped.Element) -> Bool) -> Wrapped.Element? {
        return self?.first(where: predicate)
    }
}

// MARK: - Array Specific

public extension Optional where Wrapped == [String] {
    
    /// Returns joined string or nil.
    ///
    /// - Parameter separator: Join separator.
    /// - Returns: Joined string or nil.
    func joined(separator: String = "") -> String? {
        return self?.joined(separator: separator)
    }
    
    /// Returns joined string or empty.
    func joinedOrEmpty(separator: String = "") -> String {
        return self?.joined(separator: separator) ?? ""
    }
}

// MARK: - Numeric Array Optional

public extension Optional where Wrapped == [Int] {
    
    /// Returns sum or zero.
    var sumOrZero: Int {
        return self?.reduce(0, +) ?? 0
    }
    
    /// Returns average or zero.
    var averageOrZero: Double {
        guard let array = self, !array.isEmpty else { return 0 }
        return Double(array.reduce(0, +)) / Double(array.count)
    }
}

public extension Optional where Wrapped == [Double] {
    
    /// Returns sum or zero.
    var sumOrZero: Double {
        return self?.reduce(0, +) ?? 0
    }
    
    /// Returns average or zero.
    var averageOrZero: Double {
        guard let array = self, !array.isEmpty else { return 0 }
        return array.reduce(0, +) / Double(array.count)
    }
}
