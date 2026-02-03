import Foundation

extension Array {

    /// Splits the array into chunks of the specified size.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].chunked(into: 2) // [[1, 2], [3, 4], [5]]
    /// ```
    ///
    /// - Parameter size: Maximum number of elements per chunk.
    /// - Returns: An array of arrays, each containing at most `size` elements.
    public func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element: Hashable {

    /// Returns the array with duplicate elements removed, preserving order.
    ///
    /// ```swift
    /// [1, 2, 2, 3, 3].unique() // [1, 2, 3]
    /// ```
    public func unique() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }

    /// Returns a dictionary mapping each element to its frequency count.
    ///
    /// ```swift
    /// ["a", "b", "a"].frequencies() // ["a": 2, "b": 1]
    /// ```
    public func frequencies() -> [Element: Int] {
        reduce(into: [:]) { counts, element in
            counts[element, default: 0] += 1
        }
    }

    /// Returns the most frequently occurring element.
    public var mostFrequent: Element? {
        frequencies().max(by: { $0.value < $1.value })?.key
    }
}

extension Array where Element: Comparable {

    /// Returns the array sorted in ascending order.
    public func sortedAscending() -> [Element] {
        sorted(by: <)
    }

    /// Returns the array sorted in descending order.
    public func sortedDescending() -> [Element] {
        sorted(by: >)
    }
}

extension Array where Element: Equatable {

    /// Removes all occurrences of the specified element.
    ///
    /// - Parameter element: The element to remove.
    /// - Returns: A new array without the specified element.
    public func removing(_ element: Element) -> [Element] {
        filter { $0 != element }
    }
}
