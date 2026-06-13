import Foundation

/// Main entry point for the SwiftExtensions toolkit.
public enum SwiftExtensions {
    public static let version = "2.0.0"
}

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension String {
    /// Returns true if the string is not empty and contains more than whitespace.
    var isPresent: Bool {
        !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
