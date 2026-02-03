#if canImport(SwiftUI)
import SwiftUI

// MARK: - View Conditional Extensions

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    // MARK: - Conditional Modifiers
    
    /// Applies modifier only if condition is true.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .if(isHighlighted) { view in
    ///         view.foregroundColor(.red)
    ///     }
    /// ```
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies modifier based on condition with else clause.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .if(isActive) { view in
    ///         view.foregroundColor(.green)
    ///     } else: { view in
    ///         view.foregroundColor(.gray)
    ///     }
    /// ```
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        then trueTransform: (Self) -> TrueContent,
        else falseTransform: (Self) -> FalseContent
    ) -> some View {
        if condition {
            trueTransform(self)
        } else {
            falseTransform(self)
        }
    }
    
    /// Applies modifier only if optional has value.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .ifLet(color) { view, unwrapped in
    ///         view.foregroundColor(unwrapped)
    ///     }
    /// ```
    @ViewBuilder
    func ifLet<T, Content: View>(_ optional: T?, transform: (Self, T) -> Content) -> some View {
        if let value = optional {
            transform(self, value)
        } else {
            self
        }
    }
    
    /// Applies modifier only if optional has value with else clause.
    @ViewBuilder
    func ifLet<T, TrueContent: View, FalseContent: View>(
        _ optional: T?,
        then trueTransform: (Self, T) -> TrueContent,
        else falseTransform: (Self) -> FalseContent
    ) -> some View {
        if let value = optional {
            trueTransform(self, value)
        } else {
            falseTransform(self)
        }
    }
    
    // MARK: - Platform Conditional
    
    /// Applies modifier only on iOS.
    @ViewBuilder
    func iOS<Content: View>(_ transform: (Self) -> Content) -> some View {
        #if os(iOS)
        transform(self)
        #else
        self
        #endif
    }
    
    /// Applies modifier only on macOS.
    @ViewBuilder
    func macOS<Content: View>(_ transform: (Self) -> Content) -> some View {
        #if os(macOS)
        transform(self)
        #else
        self
        #endif
    }
    
    /// Applies modifier only on watchOS.
    @ViewBuilder
    func watchOS<Content: View>(_ transform: (Self) -> Content) -> some View {
        #if os(watchOS)
        transform(self)
        #else
        self
        #endif
    }
    
    /// Applies modifier only on tvOS.
    @ViewBuilder
    func tvOS<Content: View>(_ transform: (Self) -> Content) -> some View {
        #if os(tvOS)
        transform(self)
        #else
        self
        #endif
    }
    
    // MARK: - Visibility
    
    /// Hides view if condition is true.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .hidden(if: shouldHide)
    /// ```
    @ViewBuilder
    func hidden(if condition: Bool) -> some View {
        if condition {
            hidden()
        } else {
            self
        }
    }
    
    /// Shows view only if condition is true.
    @ViewBuilder
    func visible(if condition: Bool) -> some View {
        if condition {
            self
        } else {
            EmptyView()
        }
    }
    
    /// Removes view from hierarchy if condition is true.
    @ViewBuilder
    func removed(if condition: Bool) -> some View {
        if !condition {
            self
        }
    }
    
    // MARK: - Opacity Conditional
    
    /// Sets opacity based on condition.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .opacity(enabled: isEnabled)
    /// ```
    func opacity(enabled: Bool, enabledOpacity: Double = 1, disabledOpacity: Double = 0.5) -> some View {
        opacity(enabled ? enabledOpacity : disabledOpacity)
    }
    
    // MARK: - Disabled Conditional
    
    /// Disables interaction if condition is true.
    func disabled(if condition: Bool) -> some View {
        disabled(condition)
    }
    
    /// Enables interaction if condition is true.
    func enabled(if condition: Bool) -> some View {
        disabled(!condition)
    }
    
    // MARK: - Redacted Conditional
    
    /// Applies redaction if condition is true.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    @ViewBuilder
    func redacted(if condition: Bool, reason: RedactionReasons = .placeholder) -> some View {
        if condition {
            redacted(reason: reason)
        } else {
            self
        }
    }
}

// MARK: - Environment Conditional

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// Applies environment value conditionally.
    @ViewBuilder
    func environment<V>(
        _ keyPath: WritableKeyPath<EnvironmentValues, V>,
        _ value: V,
        if condition: Bool
    ) -> some View {
        if condition {
            environment(keyPath, value)
        } else {
            self
        }
    }
}

// MARK: - Animation Conditional

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// Applies animation conditionally.
    @ViewBuilder
    func animation(_ animation: Animation?, if condition: Bool) -> some View {
        if condition {
            self.animation(animation, value: condition)
        } else {
            self
        }
    }
}

// MARK: - Debug Conditional

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// Applies modifier only in DEBUG builds.
    @ViewBuilder
    func debug<Content: View>(_ transform: (Self) -> Content) -> some View {
        #if DEBUG
        transform(self)
        #else
        self
        #endif
    }
    
    /// Applies modifier only in RELEASE builds.
    @ViewBuilder
    func release<Content: View>(_ transform: (Self) -> Content) -> some View {
        #if DEBUG
        self
        #else
        transform(self)
        #endif
    }
}
#endif
