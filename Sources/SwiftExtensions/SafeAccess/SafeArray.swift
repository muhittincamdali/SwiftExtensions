import Foundation

/// SwiftExtensions: @SafeAccess Collection wrapper
@propertyWrapper
public struct SafeAccess<T: Sendable>: Sendable {
    private var elements: [T]
    public init(wrappedValue: [T]) { self.elements = wrappedValue }
    public var wrappedValue: [T] {
        get { elements }
        set { elements = newValue }
    }
    public subscript(index: Int) -> T? {
        return elements.indices.contains(index) ? elements[index] : nil
    }
}
