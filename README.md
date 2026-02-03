# SwiftExtensions

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015+%20|%20macOS%2013+-blue.svg)](https://developer.apple.com)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A comprehensive collection of **500+ useful Swift extensions** that supercharge your daily iOS & macOS development. Stop rewriting the same utility code across projects — just import and go.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Extensions](#extensions)
  - [String](#string-extensions)
  - [Array](#array-extensions)
  - [Date](#date-extensions)
  - [Number](#number-extensions)
  - [Data](#data-extensions)
  - [Optional](#optional-extensions)
  - [Dictionary](#dictionary-extensions)
  - [UIKit](#uikit-extensions)
  - [SwiftUI](#swiftui-extensions)
- [Usage Examples](#usage-examples)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- 🔤 **String** — Validation, formatting, hashing
- 📦 **Array** — Safe subscript, chunking, grouping, uniquing
- 📅 **Date** — Relative formatting, comparison helpers, ISO support
- 🔢 **Number** — Clamping, ordinals, currency formatting
- 💾 **Data** — Hex encoding, pretty JSON, Base64 utilities
- ❓ **Optional** — Safe unwrapping, default values, nil checks
- 📖 **Dictionary** — Deep merge, typed access, transformations
- 🎨 **UIKit** — Hex colors, view helpers, animations
- 🖼️ **SwiftUI** — Conditional modifiers, hex Color init

---

## Requirements

| Platform | Minimum Version |
|----------|----------------|
| iOS      | 15.0+          |
| macOS    | 13.0+          |
| Swift    | 5.9+           |
| Xcode    | 15.0+          |

---

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftExtensions.git", from: "1.0.0")
]
```

Or in Xcode:

1. Go to **File → Add Package Dependencies**
2. Enter `https://github.com/muhittincamdali/SwiftExtensions.git`
3. Select **Up to Next Major Version** → `1.0.0`
4. Click **Add Package**

Then import where needed:

```swift
import SwiftExtensions
```

---

## Extensions

### String Extensions

#### Validation

```swift
"hello@example.com".isValidEmail       // true
"https://apple.com".isValidURL         // true
"+1234567890".isValidPhone             // true
"192.168.1.1".isValidIPv4              // true
"abc123".isAlphanumeric                // true
"   ".isBlank                          // true
"hello".containsOnlyLetters            // true
"12345".containsOnlyDigits             // true
```

#### Formatting

```swift
"hello world".camelCased               // "helloWorld"
"helloWorld".snakeCased                // "hello_world"
"hello world".titleCased               // "Hello World"
"hello world".slugified                // "hello-world"
"A long string...".truncated(to: 10)   // "A long str..."
"  spaces  ".trimmed                   // "spaces"
"hello".reversed()                     // "olleh"
"abc".padded(toLength: 6, with: "0")   // "000abc"
```

#### Hashing

```swift
"hello".md5          // "5d41402abc4b2a76b9719d911017c592"
"hello".sha256       // "2cf24dba5fb0a30e26e83b2ac5b9e29e..."
```

---

### Array Extensions

#### Safe Access

```swift
let arr = [1, 2, 3]
arr[safe: 5]         // nil (no crash!)
arr[safe: 1]         // Optional(2)
```

#### Grouping & Transformation

```swift
[1, 2, 3, 4, 5].chunked(into: 2)          // [[1,2], [3,4], [5]]
[1, 2, 2, 3, 3].unique()                   // [1, 2, 3]
["a", "b", "a", "c", "a"].frequencies()    // ["a": 3, "b": 1, "c": 1]
[3, 1, 4, 1, 5].sortedAscending()          // [1, 1, 3, 4, 5]
```

---

### Date Extensions

#### Formatting

```swift
Date().iso8601String                        // "2026-01-15T10:30:00Z"
Date().formatted(as: "dd MMM yyyy")         // "15 Jan 2026"
Date().relativeString                       // "2 hours ago"
Date().shortDateString                      // "Jan 15, 2026"
Date().timeString                           // "10:30 AM"
```

#### Comparison

```swift
Date().isToday                              // true
Date().isWeekend                            // false
date1.isSameDay(as: date2)                  // true/false
date1.daysBetween(date2)                    // 42
Date().startOfDay                           // 2026-01-15 00:00:00
Date().endOfDay                             // 2026-01-15 23:59:59
```

---

### Number Extensions

#### Int

```swift
5.clamp(low: 1, high: 10)                  // 5
15.clamp(low: 1, high: 10)                 // 10
1.ordinal                                   // "1st"
22.ordinal                                  // "22nd"
1000000.abbreviated                         // "1M"
42.isEven                                   // true
```

#### Double

```swift
3.14159.rounded(toPlaces: 2)               // 3.14
1234.56.currencyString(code: "USD")        // "$1,234.56"
0.756.percentageString                      // "75.6%"
```

---

### Data Extensions

```swift
data.hexString                              // "48656c6c6f"
data.base64URLSafe                          // URL-safe base64
data.prettyJSONString                       // formatted JSON
Data(hexString: "48656c6c6f")              // from hex
```

---

### Optional Extensions

```swift
let name: String? = nil
name.or("Unknown")                          // "Unknown"
name.isNil                                  // true
name.isNotNil                               // false

// Unwrap or throw
try name.unwrap(orThrow: MyError.missing)
```

---

### Dictionary Extensions

```swift
let dict1 = ["a": 1, "b": 2]
let dict2 = ["b": 3, "c": 4]

dict1.deepMerged(with: dict2)              // ["a": 1, "b": 3, "c": 4]
dict1.compactMapValues { $0 > 1 ? $0 : nil }
dict1.mapKeys { $0.uppercased() }          // ["A": 1, "B": 2]
dict1.toJSONString()                        // JSON representation
```

---

### UIKit Extensions

#### UIColor

```swift
UIColor(hex: "#FF5733")                    // color from hex
UIColor(hex: 0xFF5733)                     // color from Int
color.lighter(by: 0.2)                     // 20% lighter
color.darker(by: 0.2)                      // 20% darker
color.hexString                            // "#FF5733"
```

#### UIView

```swift
view.roundCorners(radius: 12)
view.addShadow(color: .black, opacity: 0.3, radius: 8)
view.addBorder(color: .gray, width: 1)
view.fadeIn(duration: 0.3)
view.fadeOut(duration: 0.3)
view.pinToSuperview(padding: 16)
```

---

### SwiftUI Extensions

#### Conditional Modifiers

```swift
Text("Hello")
    .if(isActive) { view in
        view.foregroundColor(.blue)
    }

Text("World")
    .ifLet(optionalColor) { view, color in
        view.foregroundColor(color)
    }
```

#### Color from Hex

```swift
Color(hex: "#FF5733")
Color(hex: 0xFF5733)
Color(hex: "#FF5733", opacity: 0.8)
```

---

## Usage Examples

### Real-World Form Validation

```swift
import SwiftExtensions

func validateSignUp(email: String, phone: String, name: String) -> [String] {
    var errors: [String] = []

    if !email.isValidEmail {
        errors.append("Invalid email address")
    }
    if !phone.isValidPhone {
        errors.append("Invalid phone number")
    }
    if name.isBlank {
        errors.append("Name cannot be empty")
    }

    return errors
}
```

### Safe Collection Processing

```swift
import SwiftExtensions

let users = ["Alice", "Bob", "Charlie", "Alice", "Bob"]
let uniqueUsers = users.unique()               // ["Alice", "Bob", "Charlie"]
let frequency = users.frequencies()             // ["Alice": 2, "Bob": 2, "Charlie": 1]
let pages = users.chunked(into: 2)             // [["Alice", "Bob"], ["Charlie", "Alice"], ["Bob"]]
```

### Date Handling in Chat Apps

```swift
import SwiftExtensions

func messageTimestamp(_ date: Date) -> String {
    if date.isToday {
        return date.timeString
    } else if date.daysBetween(Date()) < 7 {
        return date.relativeString
    } else {
        return date.formatted(as: "MMM d, yyyy")
    }
}
```

---

## Architecture

```
Sources/SwiftExtensions/
├── String/
│   ├── String+Validation.swift
│   ├── String+Formatting.swift
│   └── String+Crypto.swift
├── Array/
│   ├── Array+Safe.swift
│   └── Array+Grouping.swift
├── Date/
│   ├── Date+Formatting.swift
│   └── Date+Comparison.swift
├── Number/
│   ├── Int+Extensions.swift
│   └── Double+Extensions.swift
├── Data/
│   └── Data+Extensions.swift
├── Optional/
│   └── Optional+Extensions.swift
├── Dictionary/
│   └── Dictionary+Extensions.swift
├── UIKit/
│   ├── UIColor+Extensions.swift
│   └── UIView+Extensions.swift
└── SwiftUI/
    ├── View+Conditional.swift
    └── Color+Hex.swift
```

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/awesome-extension`)
3. Commit your changes (`git commit -m 'feat: add awesome extension'`)
4. Push to the branch (`git push origin feature/awesome-extension`)
5. Open a Pull Request

Please follow the existing code style and add tests for new extensions.

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

Made with ❤️ for the Swift community
