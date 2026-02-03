import Foundation

// MARK: - Collection Safe Access Extensions

public extension Collection {
    
    // MARK: - Safe Subscript
    
    /// Safely accesses element at index.
    ///
    /// - Parameter index: Index to access.
    /// - Returns: Element at index or nil if out of bounds.
    ///
    /// ```swift
    /// let array = [1, 2, 3]
    /// array[safe: 1]    // 2
    /// array[safe: 10]   // nil
    /// ```
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Safely accesses element at position from start.
    ///
    /// - Parameter offset: Offset from start index.
    /// - Returns: Element at offset or nil.
    func element(at offset: Int) -> Element? {
        guard offset >= 0 else { return nil }
        let index = self.index(startIndex, offsetBy: offset, limitedBy: endIndex)
        return index.flatMap { self[safe: $0] }
    }
    
    // MARK: - Safe First/Last
    
    /// Returns first element or nil (same as first but explicit).
    var safeFirst: Element? {
        return first
    }
    
    /// Returns last element or nil (same as last but explicit).
    var safeLast: Element? where Self: BidirectionalCollection {
        return last
    }
    
    /// Returns first N elements safely.
    ///
    /// - Parameter n: Number of elements.
    /// - Returns: Array of first N elements (or fewer if collection is smaller).
    func safePrefix(_ n: Int) -> [Element] {
        return Array(prefix(Swift.max(0, Swift.min(n, count))))
    }
    
    /// Returns last N elements safely.
    ///
    /// - Parameter n: Number of elements.
    /// - Returns: Array of last N elements (or fewer if collection is smaller).
    func safeSuffix(_ n: Int) -> [Element] where Self: BidirectionalCollection {
        return Array(suffix(Swift.max(0, Swift.min(n, count))))
    }
    
    // MARK: - Bounds Checking
    
    /// Checks if index is within bounds.
    ///
    /// - Parameter index: Index to check.
    /// - Returns: `true` if index is valid.
    func isValidIndex(_ index: Index) -> Bool {
        return indices.contains(index)
    }
    
    /// Checks if offset from start is within bounds.
    ///
    /// - Parameter offset: Offset to check.
    /// - Returns: `true` if offset is valid.
    func isValidOffset(_ offset: Int) -> Bool {
        return offset >= 0 && offset < count
    }
    
    /// Clamps offset to valid range.
    ///
    /// - Parameter offset: Offset to clamp.
    /// - Returns: Clamped offset or nil if empty.
    func clampedOffset(_ offset: Int) -> Int? {
        guard !isEmpty else { return nil }
        return Swift.max(0, Swift.min(offset, count - 1))
    }
    
    // MARK: - Safe Iteration
    
    /// Iterates with safe bounds checking.
    ///
    /// - Parameters:
    ///   - range: Range to iterate.
    ///   - body: Closure to execute for each element.
    func safeForEach(in range: Range<Int>, _ body: (Element) -> Void) {
        let start = Swift.max(0, range.lowerBound)
        let end = Swift.min(count, range.upperBound)
        
        guard start < end else { return }
        
        for offset in start..<end {
            if let element = element(at: offset) {
                body(element)
            }
        }
    }
    
    /// Maps elements in range safely.
    ///
    /// - Parameters:
    ///   - range: Range to map.
    ///   - transform: Transformation closure.
    /// - Returns: Transformed elements.
    func safeMap<T>(in range: Range<Int>, _ transform: (Element) -> T) -> [T] {
        let start = Swift.max(0, range.lowerBound)
        let end = Swift.min(count, range.upperBound)
        
        guard start < end else { return [] }
        
        return (start..<end).compactMap { element(at: $0) }.map(transform)
    }
    
    // MARK: - Nil Coalescing
    
    /// Returns element at index or default value.
    ///
    /// - Parameters:
    ///   - index: Index to access.
    ///   - defaultValue: Default value if out of bounds.
    /// - Returns: Element or default.
    func element(at index: Index, or defaultValue: Element) -> Element {
        return self[safe: index] ?? defaultValue
    }
    
    /// Returns element at offset or default value.
    ///
    /// - Parameters:
    ///   - offset: Offset from start.
    ///   - defaultValue: Default value if out of bounds.
    /// - Returns: Element or default.
    func element(at offset: Int, or defaultValue: Element) -> Element {
        return element(at: offset) ?? defaultValue
    }
}

// MARK: - MutableCollection Safe Extensions

public extension MutableCollection {
    
    /// Safely sets element at index.
    ///
    /// - Parameters:
    ///   - index: Index to set.
    ///   - newValue: New value.
    /// - Returns: `true` if set successfully.
    @discardableResult
    mutating func safeSet(_ newValue: Element, at index: Index) -> Bool {
        guard indices.contains(index) else { return false }
        self[index] = newValue
        return true
    }
    
    /// Safely modifies element at index.
    ///
    /// - Parameters:
    ///   - index: Index to modify.
    ///   - modify: Modification closure.
    /// - Returns: `true` if modified successfully.
    @discardableResult
    mutating func safeModify(at index: Index, _ modify: (inout Element) -> Void) -> Bool {
        guard indices.contains(index) else { return false }
        modify(&self[index])
        return true
    }
}

// MARK: - RangeReplaceableCollection Safe Extensions

public extension RangeReplaceableCollection {
    
    /// Safely removes element at index.
    ///
    /// - Parameter index: Index to remove.
    /// - Returns: Removed element or nil.
    @discardableResult
    mutating func safeRemove(at index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return remove(at: index)
    }
    
    /// Safely removes element at offset.
    ///
    /// - Parameter offset: Offset from start.
    /// - Returns: Removed element or nil.
    @discardableResult
    mutating func safeRemove(at offset: Int) -> Element? {
        guard offset >= 0 && offset < count else { return nil }
        let idx = index(startIndex, offsetBy: offset)
        return remove(at: idx)
    }
    
    /// Safely inserts element at index.
    ///
    /// - Parameters:
    ///   - newElement: Element to insert.
    ///   - index: Index to insert at.
    /// - Returns: `true` if inserted successfully.
    @discardableResult
    mutating func safeInsert(_ newElement: Element, at index: Index) -> Bool {
        guard index >= startIndex && index <= endIndex else { return false }
        insert(newElement, at: index)
        return true
    }
    
    /// Safely inserts element at offset.
    ///
    /// - Parameters:
    ///   - newElement: Element to insert.
    ///   - offset: Offset from start.
    /// - Returns: `true` if inserted successfully.
    @discardableResult
    mutating func safeInsert(_ newElement: Element, at offset: Int) -> Bool {
        guard offset >= 0 && offset <= count else { return false }
        let idx = index(startIndex, offsetBy: offset)
        insert(newElement, at: idx)
        return true
    }
    
    /// Safely removes elements in range.
    ///
    /// - Parameter range: Range to remove.
    /// - Returns: Removed elements.
    @discardableResult
    mutating func safeRemove(in range: Range<Int>) -> [Element] {
        let start = Swift.max(0, range.lowerBound)
        let end = Swift.min(count, range.upperBound)
        
        guard start < end else { return [] }
        
        var removed: [Element] = []
        for _ in start..<end {
            if let element = safeRemove(at: start) {
                removed.append(element)
            }
        }
        return removed
    }
}

// MARK: - BidirectionalCollection Safe Extensions

public extension BidirectionalCollection {
    
    /// Safely accesses element at offset from end.
    ///
    /// - Parameter offset: Offset from end (0 = last element).
    /// - Returns: Element at offset or nil.
    func element(fromEnd offset: Int) -> Element? {
        guard offset >= 0 && offset < count else { return nil }
        let idx = index(endIndex, offsetBy: -(offset + 1))
        return self[safe: idx]
    }
}
