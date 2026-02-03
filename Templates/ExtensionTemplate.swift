// ExtensionTemplate.swift
// SwiftExtensions
//
// Template for creating new extensions

import Foundation

// MARK: - Extension Template

/// Template extension demonstrating best practices.
///
/// ## Overview
///
/// Use this template when adding new extensions to the library.
/// Follow the patterns shown here for consistency.
///
/// ## Topics
///
/// ### Properties
/// - ``isEmpty``
/// - ``isNotEmpty``
///
/// ### Methods
/// - ``doSomething()``
/// - ``transform(_:)``
extension YourType {
    
    // MARK: - Computed Properties
    
    /// A brief description of what this property returns.
    ///
    /// Example:
    /// ```swift
    /// let result = instance.someProperty
    /// ```
    @inlinable
    public var someProperty: Bool {
        // Implementation
        return true
    }
    
    // MARK: - Instance Methods
    
    /// Performs an operation on this instance.
    ///
    /// Use this method when you need to...
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = instance.doSomething()
    /// print(result) // Expected output
    /// ```
    ///
    /// - Returns: Description of the return value.
    /// - Complexity: O(n) where n is the length of the input.
    /// - Note: Any important notes about usage.
    /// - Warning: Any warnings about edge cases.
    @inlinable
    public func doSomething() -> Self {
        // Implementation
        return self
    }
    
    /// Transforms this instance using the provided closure.
    ///
    /// - Parameter transform: A closure that takes the current value and returns a transformed value.
    /// - Returns: The transformed value.
    /// - Throws: Any errors thrown by the transform closure.
    @inlinable
    public func transform<T>(_ transform: (Self) throws -> T) rethrows -> T {
        try transform(self)
    }
    
    // MARK: - Mutating Methods (for value types)
    
    /// Modifies this instance in place.
    ///
    /// - Parameter value: The value to use for modification.
    @inlinable
    public mutating func modify(with value: Int) {
        // Implementation
    }
    
    // MARK: - Static Methods
    
    /// Creates a new instance from the provided components.
    ///
    /// - Parameters:
    ///   - component1: Description of first component.
    ///   - component2: Description of second component.
    /// - Returns: A new instance, or nil if creation fails.
    @inlinable
    public static func create(
        component1: String,
        component2: Int
    ) -> Self? {
        // Implementation
        return nil
    }
}

// MARK: - Conditional Extension Template

/// Extension that only applies when certain conditions are met.
extension Array where Element: Comparable {
    
    /// Finds the median element in a sorted array.
    ///
    /// - Returns: The median element, or nil if the array is empty.
    /// - Complexity: O(1) if already sorted, O(n log n) otherwise.
    public var median: Element? {
        guard !isEmpty else { return nil }
        let sorted = self.sorted()
        return sorted[sorted.count / 2]
    }
}

// MARK: - Protocol Extension Template

/// Protocol providing default implementations.
public protocol Defaultable {
    /// The default value for this type.
    static var defaultValue: Self { get }
}

extension Defaultable {
    /// Returns self or the default value if nil.
    ///
    /// - Parameter optional: An optional value of this type.
    /// - Returns: The unwrapped value or the default.
    public static func orDefault(_ optional: Self?) -> Self {
        optional ?? defaultValue
    }
}

// Default implementations for common types
extension String: Defaultable {
    public static var defaultValue: String { "" }
}

extension Int: Defaultable {
    public static var defaultValue: Int { 0 }
}

extension Array: Defaultable {
    public static var defaultValue: [Element] { [] }
}

// MARK: - Operator Extension Template

/// Custom operator for convenience operations.
infix operator ???: NilCoalescingPrecedence

/// Provides a default value for optionals with an autoclosure.
///
/// This is similar to `??` but doesn't evaluate the default unless needed.
///
/// ```swift
/// let value = optionalString ??? expensiveComputation()
/// ```
public func ???<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    optional ?? defaultValue()
}

// MARK: - Test Template

#if DEBUG
import XCTest

final class ExtensionTemplateTests: XCTestCase {
    
    func testSomeProperty() {
        // Given
        let instance = "test"
        
        // When
        let result = instance.isEmpty
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testDoSomething() {
        // Given
        let input = [1, 2, 3]
        
        // When
        let result = input.median
        
        // Then
        XCTAssertEqual(result, 2)
    }
    
    func testEdgeCases() {
        // Empty array
        XCTAssertNil([Int]().median)
        
        // Single element
        XCTAssertEqual([5].median, 5)
    }
    
    func testPerformance() {
        measure {
            let largeArray = Array(0..<10000)
            _ = largeArray.median
        }
    }
}
#endif

// MARK: - Placeholder Type (remove in real usage)

struct YourType {
    // Placeholder
}
