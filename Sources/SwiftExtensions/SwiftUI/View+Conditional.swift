import SwiftUI

extension View {

    /// Applies a modifier conditionally.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .if(isActive) { view in
    ///         view.foregroundColor(.blue)
    ///     }
    /// ```
    ///
    /// - Parameters:
    ///   - condition: Boolean that determines whether the transform is applied.
    ///   - transform: Closure that modifies the view.
    /// - Returns: Either the modified or original view.
    @ViewBuilder
    public func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Applies a modifier when an optional value is non-nil.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .ifLet(optionalColor) { view, color in
    ///         view.foregroundColor(color)
    ///     }
    /// ```
    ///
    /// - Parameters:
    ///   - value: Optional value to unwrap.
    ///   - transform: Closure receiving the view and unwrapped value.
    /// - Returns: Either the modified or original view.
    @ViewBuilder
    public func ifLet<T, Content: View>(
        _ value: T?,
        transform: (Self, T) -> Content
    ) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}
