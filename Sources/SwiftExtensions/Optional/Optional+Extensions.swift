import Foundation

// MARK: - Optional Extensions

public extension Optional {
    
    // MARK: - Nil Checking
    
    /// Checks if optional is nil.
    ///
    /// ```swift
    /// let value: String? = nil
    /// value.isNil    // true
    /// ```
    var isNil: Bool {
        return self == nil
    }
    
    /// Checks if optional is not nil.
    var isNotNil: Bool {
        return self != nil
    }
    
    /// Checks if optional has a value.
    var hasValue: Bool {
        return self != nil
    }
    
    // MARK: - Default Value
    
    /// Returns wrapped value or default.
    ///
    /// - Parameter defaultValue: Default value if nil.
    /// - Returns: Wrapped value or default.
    ///
    /// ```swift
    /// let name: String? = nil
    /// name.or("Unknown")    // "Unknown"
    /// ```
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    /// Returns wrapped value or default from closure.
    ///
    /// - Parameter defaultProvider: Closure providing default value.
    /// - Returns: Wrapped value or result of closure.
    func or(_ defaultProvider: () -> Wrapped) -> Wrapped {
        return self ?? defaultProvider()
    }
    
    /// Returns wrapped value or default from auto-closure (lazy evaluation).
    ///
    /// - Parameter defaultValue: Auto-closure providing default value.
    /// - Returns: Wrapped value or default.
    func orLazy(_ defaultValue: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? defaultValue()
    }
    
    // MARK: - Unwrapping
    
    /// Force unwraps with custom error message.
    ///
    /// - Parameter message: Error message if nil.
    /// - Returns: Unwrapped value.
    func unwrap(orFail message: String) -> Wrapped {
        guard let value = self else {
            fatalError(message)
        }
        return value
    }
    
    /// Returns wrapped value or throws error.
    ///
    /// - Parameter error: Error to throw if nil.
    /// - Returns: Unwrapped value.
    /// - Throws: Provided error if nil.
    func unwrap<E: Error>(orThrow error: E) throws -> Wrapped {
        guard let value = self else {
            throw error
        }
        return value
    }
    
    /// Returns wrapped value or throws OptionalError.unwrapFailed.
    ///
    /// - Returns: Unwrapped value.
    /// - Throws: OptionalError if nil.
    func unwrapOrThrow() throws -> Wrapped {
        guard let value = self else {
            throw OptionalError.unwrapFailed
        }
        return value
    }
    
    // MARK: - Transformation
    
    /// Applies closure to wrapped value if present.
    ///
    /// - Parameter transform: Transformation closure.
    /// - Returns: Transformed value or nil.
    ///
    /// ```swift
    /// let number: Int? = 5
    /// number.apply { $0 * 2 }    // 10
    /// ```
    func apply<T>(_ transform: (Wrapped) -> T) -> T? {
        return map(transform)
    }
    
    /// Applies closure to wrapped value, returning nil if transform returns nil.
    ///
    /// - Parameter transform: Optional transformation closure.
    /// - Returns: Transformed value or nil.
    func flatApply<T>(_ transform: (Wrapped) -> T?) -> T? {
        return flatMap(transform)
    }
    
    /// Runs closure with unwrapped value if present.
    ///
    /// - Parameter action: Action to perform.
    func run(_ action: (Wrapped) -> Void) {
        if let value = self {
            action(value)
        }
    }
    
    /// Runs closure with unwrapped value or alternative if nil.
    ///
    /// - Parameters:
    ///   - action: Action when value present.
    ///   - alternative: Action when nil.
    func run(_ action: (Wrapped) -> Void, else alternative: () -> Void) {
        if let value = self {
            action(value)
        } else {
            alternative()
        }
    }
    
    // MARK: - Conditional Operations
    
    /// Returns value only if it satisfies condition.
    ///
    /// - Parameter condition: Condition to check.
    /// - Returns: Value if condition passes, nil otherwise.
    ///
    /// ```swift
    /// let age: Int? = 17
    /// age.filter { $0 >= 18 }    // nil
    /// ```
    func filter(_ condition: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self, condition(value) else { return nil }
        return value
    }
    
    /// Returns value only if all conditions pass.
    ///
    /// - Parameter conditions: Array of conditions.
    /// - Returns: Value if all conditions pass.
    func filter(_ conditions: [(Wrapped) -> Bool]) -> Wrapped? {
        guard let value = self, conditions.allSatisfy({ $0(value) }) else { return nil }
        return value
    }
    
    /// Replaces value if it's nil.
    ///
    /// - Parameter replacement: New value.
    /// - Returns: New optional with replacement.
    func replacing(nilWith replacement: Wrapped) -> Wrapped {
        return self ?? replacement
    }
    
    // MARK: - Comparison
    
    /// Compares with another optional using custom comparator.
    ///
    /// - Parameters:
    ///   - other: Other optional to compare.
    ///   - compare: Comparison closure.
    /// - Returns: Comparison result.
    func compare<T>(with other: T?, using compare: (Wrapped, T) -> Bool) -> Bool {
        switch (self, other) {
        case let (lhs?, rhs?): return compare(lhs, rhs)
        default: return false
        }
    }
    
    // MARK: - Result Conversion
    
    /// Converts optional to Result.
    ///
    /// - Parameter error: Error if nil.
    /// - Returns: Result with success or failure.
    func toResult<E: Error>(_ error: E) -> Result<Wrapped, E> {
        if let value = self {
            return .success(value)
        } else {
            return .failure(error)
        }
    }
}

// MARK: - Optional Error

/// Errors for optional operations
public enum OptionalError: Error, LocalizedError {
    case unwrapFailed
    case valueExpected
    
    public var errorDescription: String? {
        switch self {
        case .unwrapFailed:
            return "Failed to unwrap optional value"
        case .valueExpected:
            return "Expected value but found nil"
        }
    }
}

// MARK: - Equatable Optional

public extension Optional where Wrapped: Equatable {
    
    /// Checks if wrapped value equals another value.
    ///
    /// - Parameter other: Value to compare.
    /// - Returns: `true` if equal.
    func equals(_ other: Wrapped) -> Bool {
        return self == other
    }
    
    /// Returns value only if it doesn't equal specified value.
    ///
    /// - Parameter value: Value to exclude.
    /// - Returns: Self if not equal to value.
    func excluding(_ value: Wrapped) -> Wrapped? {
        guard let wrapped = self, wrapped != value else { return nil }
        return wrapped
    }
}

// MARK: - Comparable Optional

public extension Optional where Wrapped: Comparable {
    
    /// Returns value if greater than specified value.
    func filterGreaterThan(_ value: Wrapped) -> Wrapped? {
        return filter { $0 > value }
    }
    
    /// Returns value if less than specified value.
    func filterLessThan(_ value: Wrapped) -> Wrapped? {
        return filter { $0 < value }
    }
    
    /// Returns value if within range.
    func filter(in range: ClosedRange<Wrapped>) -> Wrapped? {
        return filter { range.contains($0) }
    }
}

// MARK: - String Optional

public extension Optional where Wrapped == String {
    
    /// Returns value or empty string.
    var orEmpty: String {
        return self ?? ""
    }
    
    /// Checks if nil or empty.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
    /// Checks if nil or contains only whitespace.
    var isNilOrBlank: Bool {
        return self?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }
    
    /// Returns nil if empty.
    var nilIfEmpty: String? {
        guard let value = self, !value.isEmpty else { return nil }
        return value
    }
    
    /// Returns nil if blank (whitespace only).
    var nilIfBlank: String? {
        guard let value = self, !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        return value
    }
}

// MARK: - Bool Optional

public extension Optional where Wrapped == Bool {
    
    /// Returns value or false.
    var orFalse: Bool {
        return self ?? false
    }
    
    /// Returns value or true.
    var orTrue: Bool {
        return self ?? true
    }
    
    /// Returns true only if explicitly true.
    var isTrue: Bool {
        return self == true
    }
    
    /// Returns true only if explicitly false.
    var isFalse: Bool {
        return self == false
    }
}

// MARK: - Numeric Optional

public extension Optional where Wrapped: Numeric {
    
    /// Returns value or zero.
    var orZero: Wrapped {
        return self ?? 0
    }
}

// MARK: - Collection Optional

public extension Optional where Wrapped: Collection {
    
    /// Checks if nil or empty.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
    /// Returns count or zero if nil.
    var countOrZero: Int {
        return self?.count ?? 0
    }
}
