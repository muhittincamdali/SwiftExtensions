import Foundation

// MARK: - Array Safe Access Extensions

public extension Array {
    
    // MARK: - Safe Subscript
    
    /// Safely accesses element at index, returning nil if out of bounds.
    ///
    /// - Parameter index: Index to access.
    /// - Returns: Element at index or nil.
    ///
    /// ```swift
    /// let array = [1, 2, 3]
    /// array[safe: 1]    // 2
    /// array[safe: 10]   // nil
    /// ```
    subscript(safe index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    /// Safely accesses element at index with default value.
    ///
    /// - Parameters:
    ///   - index: Index to access.
    ///   - default: Default value if out of bounds.
    /// - Returns: Element at index or default.
    ///
    /// ```swift
    /// let array = [1, 2, 3]
    /// array[safe: 10, default: 0]    // 0
    /// ```
    subscript(safe index: Int, default defaultValue: Element) -> Element {
        return self[safe: index] ?? defaultValue
    }
    
    /// Safely accesses elements in range.
    ///
    /// - Parameter range: Range to access.
    /// - Returns: Array slice or empty array if out of bounds.
    subscript(safe range: Range<Int>) -> ArraySlice<Element> {
        let start = Swift.max(0, range.lowerBound)
        let end = Swift.min(count, range.upperBound)
        
        guard start < end else { return [] }
        return self[start..<end]
    }
    
    /// Safely accesses elements in closed range.
    ///
    /// - Parameter range: Closed range to access.
    /// - Returns: Array slice or empty array if out of bounds.
    subscript(safe range: ClosedRange<Int>) -> ArraySlice<Element> {
        return self[safe: range.lowerBound..<(range.upperBound + 1)]
    }
    
    // MARK: - Safe Removal
    
    /// Safely removes element at index.
    ///
    /// - Parameter index: Index to remove.
    /// - Returns: Removed element or nil if out of bounds.
    @discardableResult
    mutating func safeRemove(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return remove(at: index)
    }
    
    /// Safely removes elements at indices.
    ///
    /// - Parameter indices: Indices to remove.
    /// - Returns: Removed elements.
    @discardableResult
    mutating func safeRemove(at indices: [Int]) -> [Element] {
        let validIndices = indices
            .filter { $0 >= 0 && $0 < count }
            .sorted(by: >)
        
        return validIndices.compactMap { safeRemove(at: $0) }
    }
    
    /// Safely removes last element.
    ///
    /// - Returns: Removed element or nil if empty.
    @discardableResult
    mutating func safeRemoveLast() -> Element? {
        return isEmpty ? nil : removeLast()
    }
    
    /// Safely removes first element.
    ///
    /// - Returns: Removed element or nil if empty.
    @discardableResult
    mutating func safeRemoveFirst() -> Element? {
        return isEmpty ? nil : removeFirst()
    }
    
    // MARK: - Safe Insertion
    
    /// Safely inserts element at index.
    ///
    /// - Parameters:
    ///   - newElement: Element to insert.
    ///   - index: Index to insert at.
    /// - Returns: `true` if insertion succeeded.
    @discardableResult
    mutating func safeInsert(_ newElement: Element, at index: Int) -> Bool {
        guard index >= 0 && index <= count else { return false }
        insert(newElement, at: index)
        return true
    }
    
    /// Safely inserts elements at index.
    ///
    /// - Parameters:
    ///   - newElements: Elements to insert.
    ///   - index: Index to insert at.
    /// - Returns: `true` if insertion succeeded.
    @discardableResult
    mutating func safeInsert<C: Collection>(contentsOf newElements: C, at index: Int) -> Bool where C.Element == Element {
        guard index >= 0 && index <= count else { return false }
        insert(contentsOf: newElements, at: index)
        return true
    }
    
    // MARK: - Safe Replacement
    
    /// Safely replaces element at index.
    ///
    /// - Parameters:
    ///   - index: Index to replace.
    ///   - newElement: New element.
    /// - Returns: Old element or nil if out of bounds.
    @discardableResult
    mutating func safeReplace(at index: Int, with newElement: Element) -> Element? {
        guard index >= 0 && index < count else { return nil }
        let old = self[index]
        self[index] = newElement
        return old
    }
    
    /// Safely swaps elements at indices.
    ///
    /// - Parameters:
    ///   - i: First index.
    ///   - j: Second index.
    /// - Returns: `true` if swap succeeded.
    @discardableResult
    mutating func safeSwap(_ i: Int, _ j: Int) -> Bool {
        guard i >= 0 && i < count && j >= 0 && j < count && i != j else { return false }
        swapAt(i, j)
        return true
    }
    
    // MARK: - Safe Access Helpers
    
    /// Returns element at index or throws error.
    ///
    /// - Parameter index: Index to access.
    /// - Returns: Element at index.
    /// - Throws: ArrayAccessError if out of bounds.
    func element(at index: Int) throws -> Element {
        guard let element = self[safe: index] else {
            throw ArrayAccessError.indexOutOfBounds(index: index, count: count)
        }
        return element
    }
    
    /// Returns first element or throws error.
    ///
    /// - Returns: First element.
    /// - Throws: ArrayAccessError if empty.
    func firstOrThrow() throws -> Element {
        guard let first = first else {
            throw ArrayAccessError.emptyArray
        }
        return first
    }
    
    /// Returns last element or throws error.
    ///
    /// - Returns: Last element.
    /// - Throws: ArrayAccessError if empty.
    func lastOrThrow() throws -> Element {
        guard let last = last else {
            throw ArrayAccessError.emptyArray
        }
        return last
    }
    
    // MARK: - Bounds Checking
    
    /// Checks if index is valid.
    ///
    /// - Parameter index: Index to check.
    /// - Returns: `true` if index is within bounds.
    func isValidIndex(_ index: Int) -> Bool {
        return index >= 0 && index < count
    }
    
    /// Checks if all indices are valid.
    ///
    /// - Parameter indices: Indices to check.
    /// - Returns: `true` if all indices are within bounds.
    func areValidIndices(_ indices: [Int]) -> Bool {
        return indices.allSatisfy { isValidIndex($0) }
    }
    
    /// Clamps index to valid bounds.
    ///
    /// - Parameter index: Index to clamp.
    /// - Returns: Clamped index or nil if array is empty.
    func clampedIndex(_ index: Int) -> Int? {
        guard !isEmpty else { return nil }
        return Swift.min(Swift.max(0, index), count - 1)
    }
    
    // MARK: - Circular Access
    
    /// Accesses element at index with wrapping (circular).
    ///
    /// - Parameter index: Index (can be negative or > count).
    /// - Returns: Element at wrapped index or nil if empty.
    ///
    /// ```swift
    /// let array = [1, 2, 3]
    /// array[circular: -1]    // 3
    /// array[circular: 3]     // 1
    /// ```
    subscript(circular index: Int) -> Element? {
        guard !isEmpty else { return nil }
        let normalizedIndex = ((index % count) + count) % count
        return self[normalizedIndex]
    }
    
    /// Returns element at circular index with default.
    ///
    /// - Parameters:
    ///   - index: Index (can be negative).
    ///   - default: Default value if empty.
    /// - Returns: Element at wrapped index or default.
    subscript(circular index: Int, default defaultValue: Element) -> Element {
        return self[circular: index] ?? defaultValue
    }
}

// MARK: - Array Access Error

/// Errors for array access operations
public enum ArrayAccessError: Error, LocalizedError {
    case indexOutOfBounds(index: Int, count: Int)
    case emptyArray
    
    public var errorDescription: String? {
        switch self {
        case .indexOutOfBounds(let index, let count):
            return "Index \(index) is out of bounds for array with \(count) elements"
        case .emptyArray:
            return "Cannot access element in empty array"
        }
    }
}

// MARK: - Optional Element Array Extensions

public extension Array where Element: OptionalProtocol {
    
    /// Returns array with nil values removed.
    var compacted: [Element.Wrapped] {
        return compactMap { $0.optional }
    }
}

/// Protocol for optional type handling
public protocol OptionalProtocol {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    public var optional: Wrapped? { return self }
}
