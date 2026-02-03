#if canImport(SwiftUI)
import SwiftUI

// MARK: - View Debug Extensions

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    // MARK: - Debug Border
    
    /// Adds debug border to view.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .debugBorder()    // Red border in DEBUG builds
    /// ```
    func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
        #if DEBUG
        return border(color, width: width)
        #else
        return self
        #endif
    }
    
    /// Adds debug border with random color.
    func debugBorderRandom(width: CGFloat = 1) -> some View {
        #if DEBUG
        return border(Color.random, width: width)
        #else
        return self
        #endif
    }
    
    // MARK: - Debug Background
    
    /// Adds debug background to view.
    func debugBackground(_ color: Color = .red.opacity(0.2)) -> some View {
        #if DEBUG
        return background(color)
        #else
        return self
        #endif
    }
    
    /// Adds debug background with random color.
    func debugBackgroundRandom(opacity: Double = 0.2) -> some View {
        #if DEBUG
        return background(Color.random.opacity(opacity))
        #else
        return self
        #endif
    }
    
    // MARK: - Debug Print
    
    /// Prints message when view is created/modified.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .debugPrint("Text view created")
    /// ```
    func debugPrint(_ message: String) -> some View {
        #if DEBUG
        print("[Debug] \(message)")
        #endif
        return self
    }
    
    /// Prints value when view is created/modified.
    func debugPrint<T>(_ label: String, _ value: T) -> some View {
        #if DEBUG
        print("[Debug] \(label): \(value)")
        #endif
        return self
    }
    
    /// Logs view body evaluation.
    func debugBodyEvaluation(_ identifier: String = "View") -> some View {
        debugPrint("\(identifier) body evaluated at \(Date())")
    }
    
    // MARK: - Debug Overlay
    
    /// Adds debug overlay with view info.
    func debugOverlay(showFrame: Bool = true, showType: Bool = true) -> some View {
        #if DEBUG
        return overlay(
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 2) {
                    if showType {
                        Text(String(describing: type(of: self)))
                            .font(.system(size: 8, design: .monospaced))
                    }
                    if showFrame {
                        Text("W: \(Int(geometry.size.width)) H: \(Int(geometry.size.height))")
                            .font(.system(size: 8, design: .monospaced))
                    }
                }
                .foregroundColor(.white)
                .padding(2)
                .background(Color.black.opacity(0.7))
                .cornerRadius(4)
            },
            alignment: .topLeading
        )
        #else
        return self
        #endif
    }
    
    // MARK: - Performance Tracking
    
    /// Tracks view render time.
    func debugRenderTime(_ label: String = "View") -> some View {
        #if DEBUG
        let start = Date()
        return background(
            Color.clear.onAppear {
                let elapsed = Date().timeIntervalSince(start) * 1000
                print("[Debug] \(label) render time: \(String(format: "%.2f", elapsed))ms")
            }
        )
        #else
        return self
        #endif
    }
    
    /// Tracks view appear/disappear.
    func debugLifecycle(_ label: String = "View") -> some View {
        #if DEBUG
        return onAppear {
            print("[Debug] \(label) appeared")
        }
        .onDisappear {
            print("[Debug] \(label) disappeared")
        }
        #else
        return self
        #endif
    }
    
    // MARK: - Debug Modifiers
    
    /// Applies modifier only in DEBUG builds.
    @ViewBuilder
    func debugModifier<Content: View>(@ViewBuilder _ modifier: (Self) -> Content) -> some View {
        #if DEBUG
        modifier(self)
        #else
        self
        #endif
    }
    
    /// Highlights view changes with flash animation.
    func debugChangeHighlight<V: Equatable>(_ value: V, color: Color = .yellow) -> some View {
        #if DEBUG
        return modifier(ChangeHighlightModifier(value: value, color: color))
        #else
        return self
        #endif
    }
}

// MARK: - Change Highlight Modifier

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct ChangeHighlightModifier<V: Equatable>: ViewModifier {
    let value: V
    let color: Color
    
    @State private var isHighlighted = false
    
    func body(content: Content) -> some View {
        content
            .overlay(
                color.opacity(isHighlighted ? 0.3 : 0)
                    .allowsHitTesting(false)
            )
            .onChange(of: value) { _ in
                withAnimation(.easeIn(duration: 0.1)) {
                    isHighlighted = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isHighlighted = false
                    }
                }
            }
    }
}

// MARK: - Random Color Helper

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

// MARK: - Debug View Wrapper

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DebugView<Content: View>: View {
    let content: Content
    let label: String
    
    public init(_ label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
        #if DEBUG
        print("[Debug] \(label) initialized")
        #endif
    }
    
    public var body: some View {
        #if DEBUG
        content
            .debugBorder()
            .debugOverlay()
            .debugLifecycle(label)
        #else
        content
        #endif
    }
}
#endif
