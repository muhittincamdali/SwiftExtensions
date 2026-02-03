# Contributing to SwiftExtensions

Thank you for contributing! 🎉

## Adding New Extensions

### 1. Choose the Right File

Extensions are organized by type:
- `String+Extensions.swift` - String utilities
- `Array+Extensions.swift` - Collection helpers
- `Date+Extensions.swift` - Date manipulation
- etc.

### 2. Follow the Pattern

```swift
// MARK: - Category Name

extension String {
    /// Brief description of what this does.
    ///
    /// Example:
    /// ```swift
    /// "hello world".capitalizingFirstLetter() // "Hello world"
    /// ```
    ///
    /// - Returns: A new string with first letter capitalized.
    public func capitalizingFirstLetter() -> String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
}
```

### 3. Add Tests

```swift
final class StringExtensionsTests: XCTestCase {
    func testCapitalizingFirstLetter() {
        XCTAssertEqual("hello".capitalizingFirstLetter(), "Hello")
        XCTAssertEqual("".capitalizingFirstLetter(), "")
        XCTAssertEqual("H".capitalizingFirstLetter(), "H")
    }
}
```

### 4. Update Documentation

Add your extension to `Documentation/API.md`.

## Pull Request Checklist

- [ ] Extension is useful and generic
- [ ] Follows existing patterns
- [ ] Has DocC documentation
- [ ] Has unit tests
- [ ] No breaking changes

## Code Style

- Use `public` access level
- Add `@inlinable` for performance-critical code
- Avoid force unwrapping
- Handle edge cases (empty strings, nil values)

Thank you! 🙏
