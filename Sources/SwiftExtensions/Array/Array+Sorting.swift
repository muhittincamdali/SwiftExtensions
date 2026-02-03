import Foundation

// MARK: - Array Sorting Extensions

public extension Array {
    
    // MARK: - KeyPath Sorting
    
    /// Returns array sorted by keypath.
    ///
    /// - Parameter keyPath: KeyPath to sort by.
    /// - Returns: Sorted array.
    ///
    /// ```swift
    /// struct Person { let name: String; let age: Int }
    /// people.sorted(by: \.age)    // Sorted by age ascending
    /// ```
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    /// Returns array sorted by keypath descending.
    ///
    /// - Parameter keyPath: KeyPath to sort by.
    /// - Returns: Sorted array (descending).
    func sortedDescending<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        return sorted { $0[keyPath: keyPath] > $1[keyPath: keyPath] }
    }
    
    /// Sorts array in place by keypath.
    ///
    /// - Parameter keyPath: KeyPath to sort by.
    mutating func sort<Value: Comparable>(by keyPath: KeyPath<Element, Value>) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    /// Sorts array in place by keypath descending.
    ///
    /// - Parameter keyPath: KeyPath to sort by.
    mutating func sortDescending<Value: Comparable>(by keyPath: KeyPath<Element, Value>) {
        sort { $0[keyPath: keyPath] > $1[keyPath: keyPath] }
    }
    
    // MARK: - Multiple Criteria Sorting
    
    /// Sorts by multiple keypaths (primary, secondary, etc.).
    ///
    /// - Parameter keyPaths: Array of keypath sort descriptors.
    /// - Returns: Sorted array.
    func sorted<Value: Comparable>(by keyPaths: [KeyPath<Element, Value>]) -> [Element] {
        return sorted { lhs, rhs in
            for keyPath in keyPaths {
                let lhsValue = lhs[keyPath: keyPath]
                let rhsValue = rhs[keyPath: keyPath]
                
                if lhsValue != rhsValue {
                    return lhsValue < rhsValue
                }
            }
            return false
        }
    }
    
    /// Sorts using multiple comparators.
    ///
    /// - Parameter comparators: Array of comparator closures.
    /// - Returns: Sorted array.
    func sorted(using comparators: [(Element, Element) -> ComparisonResult]) -> [Element] {
        return sorted { lhs, rhs in
            for comparator in comparators {
                let result = comparator(lhs, rhs)
                if result != .orderedSame {
                    return result == .orderedAscending
                }
            }
            return false
        }
    }
    
    // MARK: - Stable Sorting
    
    /// Returns stably sorted array (preserves relative order of equal elements).
    ///
    /// - Parameter areInIncreasingOrder: Comparison closure.
    /// - Returns: Stably sorted array.
    func stableSorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        return enumerated()
            .sorted { lhs, rhs in
                if areInIncreasingOrder(lhs.element, rhs.element) {
                    return true
                } else if areInIncreasingOrder(rhs.element, lhs.element) {
                    return false
                }
                return lhs.offset < rhs.offset
            }
            .map { $0.element }
    }
    
    /// Returns stably sorted array by keypath.
    ///
    /// - Parameter keyPath: KeyPath to sort by.
    /// - Returns: Stably sorted array.
    func stableSorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        return stableSorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    // MARK: - Partial Sorting
    
    /// Returns first k elements sorted.
    ///
    /// More efficient than sorting entire array when you only need top k.
    ///
    /// - Parameters:
    ///   - k: Number of elements to return.
    ///   - areInIncreasingOrder: Comparison closure.
    /// - Returns: First k sorted elements.
    func topK(_ k: Int, by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        guard k > 0 else { return [] }
        guard k < count else { return sorted(by: areInIncreasingOrder) }
        
        var heap = Array(prefix(k))
        heap.sort(by: { !areInIncreasingOrder($0, $1) }) // Max heap for minimum k elements
        
        for element in dropFirst(k) {
            if areInIncreasingOrder(element, heap[0]) {
                heap[0] = element
                heap.sort(by: { !areInIncreasingOrder($0, $1) })
            }
        }
        
        return heap.sorted(by: areInIncreasingOrder)
    }
    
    /// Returns first k elements sorted by keypath.
    ///
    /// - Parameters:
    ///   - k: Number of elements to return.
    ///   - keyPath: KeyPath to sort by.
    /// - Returns: First k sorted elements.
    func topK<Value: Comparable>(_ k: Int, by keyPath: KeyPath<Element, Value>) -> [Element] {
        return topK(k) { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    /// Returns last k elements sorted (bottom k).
    ///
    /// - Parameters:
    ///   - k: Number of elements to return.
    ///   - areInIncreasingOrder: Comparison closure.
    /// - Returns: Last k sorted elements.
    func bottomK(_ k: Int, by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        return topK(k) { !areInIncreasingOrder($0, $1) }.reversed()
    }
}

// MARK: - Comparable Element Extensions

public extension Array where Element: Comparable {
    
    /// Returns sorted array (ascending).
    var sortedAscending: [Element] {
        return sorted()
    }
    
    /// Returns sorted array (descending).
    var sortedDescending: [Element] {
        return sorted(by: >)
    }
    
    /// Checks if array is sorted (ascending).
    var isSorted: Bool {
        guard count > 1 else { return true }
        return zip(self, dropFirst()).allSatisfy { $0 <= $1 }
    }
    
    /// Checks if array is sorted descending.
    var isSortedDescending: Bool {
        guard count > 1 else { return true }
        return zip(self, dropFirst()).allSatisfy { $0 >= $1 }
    }
    
    /// Checks if array is strictly sorted (no equal adjacent elements).
    var isStrictlySorted: Bool {
        guard count > 1 else { return true }
        return zip(self, dropFirst()).allSatisfy { $0 < $1 }
    }
    
    /// Returns k smallest elements.
    ///
    /// - Parameter k: Number of elements.
    /// - Returns: k smallest elements sorted.
    func smallest(_ k: Int) -> [Element] {
        return topK(k) { $0 < $1 }
    }
    
    /// Returns k largest elements.
    ///
    /// - Parameter k: Number of elements.
    /// - Returns: k largest elements sorted descending.
    func largest(_ k: Int) -> [Element] {
        return topK(k) { $0 > $1 }
    }
}

// MARK: - Index-Based Sorting

public extension Array {
    
    /// Returns indices that would sort the array.
    ///
    /// - Parameter areInIncreasingOrder: Comparison closure.
    /// - Returns: Array of indices.
    func sortedIndices(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Int] {
        return indices.sorted { areInIncreasingOrder(self[$0], self[$1]) }
    }
    
    /// Returns indices that would sort the array by keypath.
    ///
    /// - Parameter keyPath: KeyPath to sort by.
    /// - Returns: Array of indices.
    func sortedIndices<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Int] {
        return sortedIndices { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    /// Reorders array according to indices.
    ///
    /// - Parameter indices: Desired order as indices.
    /// - Returns: Reordered array.
    func reordered(by indices: [Int]) -> [Element] {
        return indices.compactMap { self[safe: $0] }
    }
}

// MARK: - Custom Sort Orders

public extension Array {
    
    /// Sorts with nil values at end.
    ///
    /// - Parameter keyPath: KeyPath to optional value.
    /// - Returns: Sorted array with nils at end.
    func sortedNilsLast<Value: Comparable>(by keyPath: KeyPath<Element, Value?>) -> [Element] {
        return sorted { lhs, rhs in
            switch (lhs[keyPath: keyPath], rhs[keyPath: keyPath]) {
            case (nil, nil): return false
            case (nil, _): return false
            case (_, nil): return true
            case let (l?, r?): return l < r
            }
        }
    }
    
    /// Sorts with nil values at beginning.
    ///
    /// - Parameter keyPath: KeyPath to optional value.
    /// - Returns: Sorted array with nils at beginning.
    func sortedNilsFirst<Value: Comparable>(by keyPath: KeyPath<Element, Value?>) -> [Element] {
        return sorted { lhs, rhs in
            switch (lhs[keyPath: keyPath], rhs[keyPath: keyPath]) {
            case (nil, nil): return false
            case (nil, _): return true
            case (_, nil): return false
            case let (l?, r?): return l < r
            }
        }
    }
}
