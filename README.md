<p align="center">
  <img src="https://img.shields.io/badge/Swift-6.0-FA7343?style=for-the-badge&logo=swift&logoColor=white" alt="Swift 6.0"/>
  <img src="https://img.shields.io/badge/Platform-iOS%20|%20macOS%20|%20visionOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" alt="Platform"/>
  <img src="https://img.shields.io/badge/Standard-Unified%20Core-5856D6?style=for-the-badge" alt="Standard"/>
</p>

---

## 🚀 Killer Feature: @SafeAccess Property Wrapper
Index out of bounds crashes are a thing of the past. Use `@SafeAccess var items: [String]` to automatically handle out-of-bounds queries gracefully.
> **🛡️ PART OF THE 2026 UNIFIED CORE**
> This repository is a verified component of 'The Endless March' initiative. Purified for Swift 6, zero-dependency, and engineered for maximum hardware saturation.
> 
> *Flagship Engines:* [SwiftNetwork](https://github.com/muhittincamdali/SwiftNetwork) | [SwiftAI](https://github.com/muhittincamdali/SwiftAI) | [LiquidGlassKit](https://github.com/muhittincamdali/LiquidGlassKit)

---

<div align="center">

```
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║   ███████╗██╗    ██╗██╗███████╗████████╗                             ║
║   ██╔════╝██║    ██║██║██╔════╝╚══██╔══╝                             ║
║   ███████╗██║ █╗ ██║██║█████╗     ██║                                ║
║   ╚════██║██║███╗██║██║██╔══╝     ██║                                ║
║   ███████║╚███╔███╔╝██║██║        ██║                                ║
║   ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝        ╚═╝                                ║
║                                                                       ║
║   ███████╗██╗  ██╗████████╗███████╗███╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗███████╗
║   ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║██╔════╝
║   █████╗   ╚███╔╝    ██║   █████╗  ██╔██╗ ██║███████╗██║██║   ██║██╔██╗ ██║███████╗
║   ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║╚██╗██║╚════██║██║██║   ██║██║╚██╗██║╚════██║
║   ███████╗██╔╝ ██╗   ██║   ███████╗██║ ╚████║███████║██║╚██████╔╝██║ ╚████║███████║
║   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
```

**Comprehensive collection of Swift extensions for everyday use**

[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138?style=flat&logo=swift&logoColor=white)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20visionOS-blue?style=flat)](https://developer.apple.com)
[![SPM](https://img.shields.io/badge/SPM-Compatible-green?style=flat&logo=swift)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat)](LICENSE)
[![CI](https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg)](https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml)
[![codecov](https://img.shields.io/badge/coverage-95%25-brightgreen?style=flat)](https://github.com/muhittincamdali/SwiftExtensions)
[![GitHub stars](https://img.shields.io/github/stars/muhittincamdali/SwiftExtensions?style=flat)](https://github.com/muhittincamdali/SwiftExtensions/stargazers)
[![GitHub contributors](https://img.shields.io/github/contributors/muhittincamdali/SwiftExtensions?style=flat)](https://github.com/muhittincamdali/SwiftExtensions/graphs/contributors)

[Features](#features) • [Installation](#installation) • [Quick Start](#quick-start) • [Documentation](#documentation) • [Contributing](#contributing)

</div>

---

## Features

- 📝 **String Extensions** — Validation, formatting, transformations
- 📅 **Date Extensions** — Parsing, formatting, calculations
- 🔢 **Numeric Extensions** — Formatting, rounding, clamping
- 📦 **Collection Extensions** — Safe access, grouping, chunking
- 🎨 **UI Extensions** — Colors, layouts, animations (iOS/macOS)
- 🔗 **Optional Extensions** — Unwrapping helpers, default values
- 📊 **Data Extensions** — Encoding, hashing, compression
- ⚡ **Performance Focused** — Zero runtime overhead

## Installation

### Swift Package Manager

Add SwiftExtensions to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftExtensions.git", from: "1.0.0")
]
```

Or add it directly in Xcode: **File → Add Package Dependencies** and enter:
```
https://github.com/muhittincamdali/SwiftExtensions.git
```

### CocoaPods

```ruby
pod 'SwiftExtensions', '~> 1.0'
```

### Manual Installation

Download and drag the `Sources/SwiftExtensions` folder into your Xcode project.

## Quick Start

### String Extensions

```swift
import SwiftExtensions

// Validation
"user@example.com".isValidEmail        // true
"https://github.com".isValidURL        // true
"+1234567890".isValidPhone             // true

// Transformations
"hello world".capitalizingFirstLetter  // "Hello world"
"CamelCase".snakeCased                 // "camel_case"
"hello".reversed                       // "olleh"

// Utilities
"  spacious  ".trimmed                 // "spacious"
"Hello, World!".removing("!")          // "Hello, World"
"abc123".digitsOnly                    // "123"
```

### Date Extensions

```swift
// Formatting
Date().formatted(.relative)            // "2 hours ago"
Date().formatted(.iso8601)             // "2024-01-15T10:30:00Z"
Date().formatted("MMMM dd, yyyy")      // "January 15, 2024"

// Calculations
Date().adding(days: 7)                 // 7 days from now
Date().startOfDay                      // Today at 00:00:00
Date().endOfMonth                      // Last day of month

// Comparisons
date1.isSameDay(as: date2)
date.isToday
date.isWeekend
```

### Collection Extensions

```swift
// Safe access
let array = [1, 2, 3]
array[safe: 10]                        // nil (no crash!)

// Grouping
let people = [Person(age: 20), Person(age: 30), Person(age: 20)]
people.grouped(by: \.age)              // [20: [...], 30: [...]]

// Chunking
[1, 2, 3, 4, 5].chunked(into: 2)       // [[1, 2], [3, 4], [5]]

// Unique elements
[1, 2, 2, 3, 3, 3].unique              // [1, 2, 3]
```

### Optional Extensions

```swift
// Unwrapping
let name: String? = nil
name.or("Anonymous")                   // "Anonymous"
name.isNilOrEmpty                      // true

// Conditional execution
optionalValue.ifLet { value in
    print("Has value: \(value)")
}

// Throwing unwrap
try optionalValue.orThrow(MyError.notFound)
```

### Numeric Extensions

```swift
// Formatting
1234567.89.formatted(.currency("USD"))  // "$1,234,567.89"
0.456.formatted(.percent)               // "45.6%"
1_500_000.abbreviated                   // "1.5M"

// Clamping
value.clamped(to: 0...100)

// Rounding
3.14159.rounded(to: 2)                  // 3.14
```

### UI Extensions (iOS/macOS)

```swift
// Colors
UIColor(hex: "#FF5733")
UIColor.random

// Views
view.addShadow(radius: 10, opacity: 0.3)
view.roundCorners(.allCorners, radius: 12)
view.shake()  // Animation

// Auto Layout
view.pin(to: superview)
view.centerInSuperview()
view.constrainSize(width: 100, height: 50)
```

## Requirements

| Platform | Minimum Version |
|----------|----------------|
| iOS      | 15.0+          |
| macOS    | 12.0+          |
| tvOS     | 15.0+          |
| watchOS  | 8.0+           |
| visionOS | 1.0+           |
| Swift    | 5.9+           |

## Documentation

### Available Extensions

| Type | Extensions |
|------|------------|
| `String` | Validation, formatting, transformations, subscripting |
| `Date` | Formatting, calculations, comparisons, components |
| `Array` | Safe access, grouping, chunking, filtering |
| `Dictionary` | Merging, mapping, filtering |
| `Optional` | Unwrapping, default values, conditional execution |
| `Int/Double` | Formatting, clamping, rounding |
| `Data` | Base64, hex, hashing |
| `UIView/NSView` | Layout, styling, animations |
| `UIColor/NSColor` | Hex init, manipulation, random |

### Advanced Usage

<details>
<summary><b>Custom String Validation</b></summary>

```swift
extension String {
    var isValidCustomFormat: Bool {
        let regex = "^[A-Z]{2}\\d{4}$"
        return self.matches(regex)
    }
}

"AB1234".isValidCustomFormat  // true
```

</details>

<details>
<summary><b>Date Ranges</b></summary>

```swift
let range = Date()...Date().adding(days: 7)

for day in range.days {
    print(day.formatted())
}

// Check if date is in range
someDate.isWithin(range)
```

</details>

<details>
<summary><b>Collection Transformations</b></summary>

```swift
// Async map
let results = await items.asyncMap { item in
    await processItem(item)
}

// Compact map with key path
let names = people.compactMap(\.nickname)

// Filter with key path
let adults = people.filter(\.isAdult)
```

</details>

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) before submitting a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Built with 🧩 by [Muhittin Camdali](https://github.com/muhittincamdali)**

</div>

---

## 📈 Star History

<a href="https://star-history.com/#muhittincamdali/SwiftExtensions&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/SwiftExtensions&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/SwiftExtensions&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=muhittincamdali/SwiftExtensions&type=Date" />
 </picture>
</a>
