# SwiftExtensions

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS-blue.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)

A comprehensive collection of **500+ production-tested Swift extensions** that make iOS/macOS development faster and more expressive. Zero dependencies, pure Swift.

## Features

- 🚀 **500+ Extensions** across 40+ files
- 📦 **Zero Dependencies** - Pure Swift
- 🔒 **Type-Safe** - Leverages Swift's type system
- 📱 **Multi-Platform** - iOS, macOS, tvOS, watchOS
- 📖 **Fully Documented** - DocC compatible
- ✅ **Well Tested** - Comprehensive test suite

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftExtensions.git", from: "1.0.0")
]
```

Or in Xcode: File → Add Package Dependencies → Enter the repository URL.

## Quick Start

```swift
import SwiftExtensions

// String validation
"user@email.com".isValidEmail           // true
"https://github.com".isValidURL         // true
"+1-555-123-4567".isValidPhoneNumber    // true

// String formatting
"hello_world".camelCased                // "helloWorld"
"Hello World".slugified                 // "hello-world"
"Hello".truncated(to: 3)                // "Hel..."

// Safe array access
let items = [1, 2, 3]
items[safe: 10]                         // nil (no crash!)
items[safe: 1]                          // 2

// Date helpers
Date().isToday                          // true
Date().adding(days: 5)                  // 5 days from now
Date().relativeTime                     // "just now"

// Number formatting
1234567.formatted                       // "1,234,567"
42.ordinal                              // "42nd"
0.75.asPercentage                       // "75%"
```

## Extensions Overview

### String Extensions

```swift
// Validation
"test@example.com".isValidEmail         // true
"192.168.1.1".isValidIPv4               // true
"Hello123".isAlphanumeric               // true
"password123".isValidPassword()         // Configure requirements

// Formatting
"hello world".titleCased                // "Hello World"
"helloWorld".snakeCased                 // "hello_world"
"hello world".camelCased                // "helloWorld"
"hello".paddedLeft(to: 10, with: "0")   // "00000hello"

// Crypto
"Hello".md5                             // MD5 hash
"Hello".sha256                          // SHA256 hash
"Hello".base64Encoded                   // "SGVsbG8="
"SGVsbG8=".base64Decoded                // "Hello"

// Search
"Hello World".fuzzyMatches("hw")        // true
"kitten".levenshteinDistance(to: "sitting") // 3
"Hello World World".occurrences(of: "World") // 2

// HTML
"<p>Hello</p>".strippedHTMLTags         // "Hello"
"&lt;div&gt;".htmlDecoded               // "<div>"
"Hello".htmlTag("strong")               // "<strong>Hello</strong>"
```

### Array Extensions

```swift
// Safe Access
array[safe: 100]                        // nil instead of crash
array[circular: -1]                     // Last element
array.safeRemove(at: 10)                // Returns nil if out of bounds

// Grouping
[1,2,3,4,5].chunked(into: 2)            // [[1,2], [3,4], [5]]
words.grouped(by: { $0.first! })        // Group by first letter
[1,2,2,3,1].uniqued                     // [1, 2, 3]

// Sorting
people.sorted(by: \.age)                // Sort by keypath
array.isSorted                          // Check if sorted
array.topK(5, by: <)                    // First 5 smallest

// Math (Numeric arrays)
[1,2,3,4,5].sum                         // 15
[1,2,3,4,5].average                     // 3.0
[1,3,5,7,9].median                      // 5.0
numbers.standardDeviation               // Standard deviation

// Random
array.randomElements(count: 3)          // 3 random elements
array.sample(size: 5)                   // Random sample
array.shuffledArray                     // Shuffled copy
```

### Date Extensions

```swift
// Formatting
date.iso8601                            // "2024-01-15T10:30:00Z"
date.formatted("MMMM d, yyyy")          // "January 15, 2024"
date.relativeTime                       // "2 hours ago"
date.fullDate                           // "Monday, January 15, 2024"

// Comparison
date.isToday                            // true/false
date.isWeekend                          // true/false
date.isSameDay(as: otherDate)           // Compare days
date.isBetween(start, and: end)         // Range check

// Components
date.year                               // 2024
date.month                              // 1
date.day                                // 15
date.startOfDay                         // Midnight
date.endOfMonth                         // Last moment of month

// Manipulation
date.adding(days: 5)                    // Add 5 days
date.subtracting(hours: 2)              // Subtract 2 hours
date.setting(hour: 9, minute: 30)       // Set time
date.rounded(toNearest: 15)             // Round to 15 min
```

### Number Extensions

```swift
// Int
15.clamped(to: 0...10)                  // 10
42.ordinal                              // "42nd"
5.factorial                             // 120
7.isPrime                               // true
12345.digits                            // [1, 2, 3, 4, 5]
255.hex                                 // "ff"
5.times { print("Hello") }              // Print 5 times

// Double
3.14159.rounded(to: 2)                  // 3.14
1234.56.asCurrency()                    // "$1,234.56"
0.75.asPercentage                       // "75%"
45.0.degreesToRadians                   // Convert to radians
0.0.lerp(to: 100, amount: 0.5)          // 50.0 (interpolation)
```

### Optional Extensions

```swift
// Safe unwrapping
optionalString.or("default")            // Value or default
optionalString.orEmpty                  // Value or ""
optionalInt.orZero                      // Value or 0

// Checking
value.isNil                             // true if nil
value.isNotNil                          // true if not nil
optionalString.isNilOrEmpty             // nil or ""
optionalBool.orFalse                    // Value or false

// Transformation
optional.filter { $0 > 5 }              // nil if condition fails
optional.run { print($0) }              // Execute if not nil
```

### Dictionary Extensions

```swift
// Merging
dict1.merged(with: dict2)               // Combine dictionaries
dict1 + dict2                           // Operator syntax
dict.deepMerged(with: other)            // Recursive merge

// Transformation
dict.mapKeys { $0.uppercased() }        // Transform keys
dict.inverted()                         // Swap keys/values
dict.picking("a", "b", "c")             // Keep only these keys
dict.omitting("x", "y")                 // Remove these keys

// Queries
dict.hasKey("name")                     // Check key exists
dict.key(forValue: "John")              // Find key by value
dict.value(at: "user.profile.name")     // Nested access
```

### URL Extensions

```swift
// Query Parameters
url.queryParameters                     // ["key": "value"]
url.queryParameter("id")                // Get single param
url.appendingQueryParameter("page", value: "2")
url.removingQueryParameter("token")

// Components
url.pathSegments                        // ["users", "123"]
url.withScheme("https")                 // Change scheme
url.withHost("api.example.com")         // Change host

// Validation
url.isHTTPS                             // Check scheme
url.isWebURL                            // HTTP or HTTPS
url.hasExtension(in: ["jpg", "png"])    // Check file type
```

### Data Extensions

```swift
// Encoding
data.hexString                          // "48656c6c6f"
data.base64String                       // Base64 encoded
Data(hexString: "48656c6c6f")           // From hex

// JSON
data.jsonDictionary                     // Parse as dictionary
data.prettyPrintedJSON                  // Formatted JSON
data.decoded(as: User.self)             // Decode Codable
data.jsonValue(at: "user.name")         // Path access

// Compression
data.zlibCompressed                     // Compress
data.lzfseCompressed                    // Apple's algorithm
compressed.zlibDecompressed()           // Decompress
```

### UIKit Extensions

```swift
// UIColor
UIColor(hex: "#FF0000")                 // From hex
color.hexString                         // "#FF0000"
color.lighter(by: 0.2)                  // Lighter shade
color.darker(by: 0.2)                   // Darker shade
color.isLight                           // Light or dark

// UIView
view.roundCorners(radius: 10)           // Round corners
view.addShadow(radius: 4, opacity: 0.2) // Add shadow
view.fadeIn()                           // Animate fade in
view.snapshot()                         // Capture as UIImage

// UIImage
image.resized(to: size)                 // Resize
image.squareCropped                     // Crop to square
image.circleCropped                     // Crop to circle
image.tinted(with: .red)                // Apply tint
```

### SwiftUI Extensions

```swift
// Conditional modifiers
Text("Hello")
    .if(condition) { $0.foregroundColor(.red) }
    .ifLet(optionalColor) { view, color in view.foregroundColor(color) }

// Frame helpers
view.frame(square: 44)                  // Square frame
view.fillWidth()                        // Max width
view.alignLeading()                     // Align to leading

// Color
Color(hex: "#FF0000")                   // From hex
Color.random                            // Random color
color.lighter(by: 0.2)                  // Lighter

// Debug
view.debugBorder()                      // Red border in DEBUG
view.debugOverlay()                     // Show frame info
```

### Codable Extensions

```swift
// Encoding
user.jsonData()                         // Encode to Data
user.prettyJSONString()                 // Pretty-printed JSON
user.jsonDictionary()                   // As dictionary

// Decoding
User.from(jsonData: data)               // Decode from Data
User.from(jsonString: string)           // Decode from String
User.from(resource: "user")             // From bundle resource

// Custom strategies
user.jsonDataSnakeCase()                // snake_case keys
User.fromSnakeCase(jsonData: data)      // Decode snake_case
```

## Architecture

```
Sources/SwiftExtensions/
├── String/
│   ├── String+Validation.swift
│   ├── String+Formatting.swift
│   ├── String+Crypto.swift
│   ├── String+Search.swift
│   ├── String+Localization.swift
│   └── String+HTML.swift
├── Array/
│   ├── Array+Safe.swift
│   ├── Array+Grouping.swift
│   ├── Array+Sorting.swift
│   ├── Array+Math.swift
│   └── Array+Random.swift
├── Date/
│   ├── Date+Formatting.swift
│   ├── Date+Comparison.swift
│   ├── Date+Components.swift
│   └── Date+Manipulation.swift
├── Number/
│   ├── Int+Extensions.swift
│   ├── Double+Extensions.swift
│   ├── CGFloat+Extensions.swift
│   └── Decimal+Extensions.swift
├── Data/
│   ├── Data+Encoding.swift
│   ├── Data+Compression.swift
│   └── Data+JSON.swift
├── Optional/
│   ├── Optional+Extensions.swift
│   └── Optional+Collection.swift
├── Dictionary/
│   ├── Dictionary+Merge.swift
│   ├── Dictionary+Transform.swift
│   └── Dictionary+Query.swift
├── Collection/
│   ├── Collection+Safe.swift
│   └── Collection+Parallel.swift
├── URL/
│   ├── URL+Query.swift
│   ├── URL+Components.swift
│   └── URL+Validation.swift
├── UIKit/
│   ├── UIColor+Extensions.swift
│   ├── UIView+Extensions.swift
│   ├── UIImage+Extensions.swift
│   └── UIDevice+Extensions.swift
├── SwiftUI/
│   ├── View+Conditional.swift
│   ├── Color+Hex.swift
│   ├── View+Frame.swift
│   └── View+Debug.swift
├── Foundation/
│   ├── Bundle+Extensions.swift
│   ├── FileManager+Extensions.swift
│   └── NotificationCenter+Extensions.swift
└── Codable/
    ├── Codable+JSON.swift
    ├── Codable+Plist.swift
    └── KeyedDecodingContainer+Extensions.swift
```

## Requirements

- Swift 5.9+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 15.0+

## License

MIT License - see [LICENSE](LICENSE) file.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Author

**Muhittin Camdali** - [@muhittincamdali](https://github.com/muhittincamdali)
