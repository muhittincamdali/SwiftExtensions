import Foundation

extension Array {

    /// Safely accesses the element at the given index.
    ///
    /// Returns `nil` instead of crashing when the index is out of bounds.
    ///
    /// ```swift
    /// let arr = [1, 2, 3]
    /// arr[safe: 1]  // Optional(2)
    /// arr[safe: 10] // nil
    /// ```
    ///
    /// - Parameter index: The position of the element to access.
    /// - Returns: The element at the specified index, or `nil` if out of bounds.
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// Safely accesses the element at the given index with a default fallback.
    ///
    /// - Parameters:
    ///   - index: The position of the element to access.
    ///   - defaultValue: Value returned when the index is out of bounds.
    /// - Returns: The element at the index or the default value.
    public subscript(safe index: Index, default defaultValue: Element) -> Element {
        indices.contains(index) ? self[index] : defaultValue
    }

    /// Returns the element at the given index, or `nil` if out of bounds.
    ///
    /// Functional alternative to the safe subscript.
    public func element(at index: Index) -> Element? {
        self[safe: index]
    }

    /// Returns the second element of the array, or `nil` if unavailable.
    public var second: Element? {
        self[safe: 1]
    }

    /// Returns the third element of the array, or `nil` if unavailable.
    public var third: Element? {
        self[safe: 2]
    }
}
