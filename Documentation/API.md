# SwiftExtensions API Documentation

## String Extensions

### Validation

```swift
"test@email.com".isValidEmail      // true
"https://example.com".isValidURL   // true
"+1234567890".isValidPhoneNumber   // true
```

### Manipulation

```swift
"Hello World".truncated(to: 5)     // "Hello..."
"camelCase".snakeCased             // "camel_case"
"snake_case".camelCased            // "snakeCase"
```

### HTML & URL

```swift
"<p>Test</p>".htmlDecoded          // "Test"
"Hello World".urlEncoded           // "Hello%20World"
```

## Array Extensions

### Safe Access

```swift
let arr = [1, 2, 3]
arr[safe: 5]                       // nil (no crash)
arr.second                         // 2
arr.last(3)                        // [1, 2, 3]
```

### Transformation

```swift
[1, 1, 2, 2, 3].unique()           // [1, 2, 3]
[1, 2, 3, 4, 5].chunked(into: 2)   // [[1, 2], [3, 4], [5]]
```

### Grouping

```swift
let people = [Person(age: 25), Person(age: 30), Person(age: 25)]
people.grouped(by: \.age)          // [25: [...], 30: [...]]
```

## Date Extensions

### Comparison

```swift
Date().isToday                     // true
Date().isWeekend                   // depends on day
```

### Manipulation

```swift
Date().startOfDay
Date().endOfDay
Date().adding(5, to: .day)
```

### Formatting

```swift
Date().formatted(as: "yyyy-MM-dd")
Date().timeAgo                     // "5 minutes ago"
```

## Optional Extensions

```swift
let name: String? = nil
name.or("Default")                 // "Default"
name.isNil                         // true
```

## Collection Extensions

```swift
[1, 2, 3].isNotEmpty               // true
[3, 1, 2].sorted(by: \.self)       // [1, 2, 3]
[1, 2, 3, 4].count(where: { $0 > 2 }) // 2
```

## UIKit Extensions

### UIView

```swift
view.addSubviews(label, button, imageView)
view.roundCorners([.topLeft, .topRight], radius: 12)
view.addShadow(color: .black, opacity: 0.3, radius: 8)
```

### UIColor

```swift
UIColor(hex: "#FF5733")
UIColor.random
color.lighter(by: 20)
color.darker(by: 20)
```

## Foundation Extensions

### Bundle

```swift
Bundle.main.appVersion             // "1.2.0"
Bundle.main.buildNumber            // "42"
```

### FileManager

```swift
FileManager.documentsDirectory
FileManager.cachesDirectory
FileManager.default.fileExists(at: url)
```

### UserDefaults

```swift
UserDefaults.standard[key: "myKey"] = value
let value = UserDefaults.standard[key: "myKey"]
```

## Full Extension List

| Category | Extensions Count |
|----------|-----------------|
| String | 50+ |
| Array | 30+ |
| Date | 25+ |
| Optional | 10+ |
| Collection | 20+ |
| UIView | 30+ |
| UIColor | 15+ |
| Foundation | 40+ |
| **Total** | **500+** |
