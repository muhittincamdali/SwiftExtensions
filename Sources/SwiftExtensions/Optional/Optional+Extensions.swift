import Foundation

extension Optional {

    /// Returns the wrapped value or the provided default.
    ///
    /// ```swift
    /// let name: String? = nil
    /// name.or("Unknown") // "Unknown"
    /// ```
    ///
    /// - Parameter defaultValue: Value to return when `nil`.
    /// - Returns: The wrapped value or the default.
    public func or(_ defaultValue: @autoclosure () -> Wrapped) -> Wrapped {
        self ?? defaultValue()
    }

    /// Returns `true` if the optional is `nil`.
    public var isNil: Bool {
        self == nil
    }

    /// Returns `true` if the optional contains a value.
    public var isNotNil: Bool {
        self != nil
    }

    /// Unwraps the optional or throws the provided error.
    ///
    /// ```swift
    /// let value = try optionalInt.unwrap(orThrow: ValidationError.missing)
    /// ```
    ///
    /// - Parameter error: The error to throw when `nil`.
    /// - Returns: The unwrapped value.
    /// - Throws: The provided error if the optional is `nil`.
    public func unwrap(orThrow error: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else { throw error() }
        return value
    }

    /// Runs the closure only when a value exists.
    ///
    /// - Parameter action: Closure receiving the unwrapped value.
    public func ifPresent(_ action: (Wrapped) -> Void) {
        if let value = self { action(value) }
    }

    /// Maps the value if present, otherwise returns the default.
    ///
    /// - Parameters:
    ///   - defaultValue: Fallback value.
    ///   - transform: Transformation to apply.
    /// - Returns: Transformed value or default.
    public func mapOr<T>(_ defaultValue: T, _ transform: (Wrapped) -> T) -> T {
        map(transform) ?? defaultValue
    }
}
