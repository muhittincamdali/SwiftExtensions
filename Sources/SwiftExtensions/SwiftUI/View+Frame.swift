#if canImport(SwiftUI)
import SwiftUI

// MARK: - View Frame Extensions

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    // MARK: - Size Modifiers
    
    /// Sets frame to square with given size.
    ///
    /// ```swift
    /// Image(systemName: "star")
    ///     .frame(square: 44)
    /// ```
    func frame(square size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
    
    /// Sets maximum frame size.
    func frame(maxSquare size: CGFloat) -> some View {
        frame(maxWidth: size, maxHeight: size)
    }
    
    /// Sets minimum frame size.
    func frame(minSquare size: CGFloat) -> some View {
        frame(minWidth: size, minHeight: size)
    }
    
    /// Sets frame with size struct.
    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
    
    /// Sets frame to fill available width.
    func fillWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    /// Sets frame to fill available height.
    func fillHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Sets frame to fill all available space.
    func fillSpace(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    // MARK: - Aspect Ratio
    
    /// Sets aspect ratio to square (1:1).
    func aspectRatioSquare(contentMode: ContentMode = .fit) -> some View {
        aspectRatio(1, contentMode: contentMode)
    }
    
    /// Sets aspect ratio to 16:9.
    func aspectRatio16x9(contentMode: ContentMode = .fit) -> some View {
        aspectRatio(16/9, contentMode: contentMode)
    }
    
    /// Sets aspect ratio to 4:3.
    func aspectRatio4x3(contentMode: ContentMode = .fit) -> some View {
        aspectRatio(4/3, contentMode: contentMode)
    }
    
    /// Sets aspect ratio to golden ratio.
    func aspectRatioGolden(contentMode: ContentMode = .fit) -> some View {
        aspectRatio(1.618, contentMode: contentMode)
    }
    
    // MARK: - Alignment Helpers
    
    /// Aligns view to leading edge.
    func alignLeading() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Aligns view to trailing edge.
    func alignTrailing() -> some View {
        frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    /// Aligns view to top.
    func alignTop() -> some View {
        frame(maxHeight: .infinity, alignment: .top)
    }
    
    /// Aligns view to bottom.
    func alignBottom() -> some View {
        frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    /// Aligns view to center.
    func alignCenter() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    /// Aligns view to top leading corner.
    func alignTopLeading() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    /// Aligns view to top trailing corner.
    func alignTopTrailing() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
    
    /// Aligns view to bottom leading corner.
    func alignBottomLeading() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }
    
    /// Aligns view to bottom trailing corner.
    func alignBottomTrailing() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    // MARK: - Fixed Size
    
    /// Sets horizontal fixed size only.
    func fixedHorizontal() -> some View {
        fixedSize(horizontal: true, vertical: false)
    }
    
    /// Sets vertical fixed size only.
    func fixedVertical() -> some View {
        fixedSize(horizontal: false, vertical: true)
    }
    
    // MARK: - Geometry Reader Helpers
    
    /// Reads view size and passes to closure.
    func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    /// Reads view frame in coordinate space.
    func readFrame(
        in coordinateSpace: CoordinateSpace = .global,
        _ onChange: @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: geometry.frame(in: coordinateSpace))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }
}

// MARK: - Preference Keys

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - Spacing Helpers

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// Adds horizontal spacer before view.
    func spacerBefore() -> some View {
        HStack {
            Spacer()
            self
        }
    }
    
    /// Adds horizontal spacer after view.
    func spacerAfter() -> some View {
        HStack {
            self
            Spacer()
        }
    }
    
    /// Adds horizontal spacers around view.
    func centeredHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    /// Adds vertical spacer above view.
    func spacerAbove() -> some View {
        VStack {
            Spacer()
            self
        }
    }
    
    /// Adds vertical spacer below view.
    func spacerBelow() -> some View {
        VStack {
            self
            Spacer()
        }
    }
    
    /// Adds vertical spacers around view.
    func centeredVertically() -> some View {
        VStack {
            Spacer()
            self
            Spacer()
        }
    }
}
#endif
