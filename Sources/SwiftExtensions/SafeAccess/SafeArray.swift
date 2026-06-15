import Foundation

/// SwiftExtensions: @SafeAccess Array Wrapper
/// 
/// A property wrapper that guarantees zero out-of-bounds crashes when accessing arrays,
/// returning an optional instead of triggering a fatalError.
@propertyWrapper
public struct SafeAccess<T: Sendable>: Sendable {
    private var elements: [T]
    
    public init(wrappedValue: [T]) {
        self.elements = wrappedValue
    }
    
    public var wrappedValue: [T] {
        get { elements }
        set { elements = newValue }
    }
    
    public subscript(index: Int) -> T? {
        return elements.indices.contains(index) ? elements[index] : nil
    }
}
