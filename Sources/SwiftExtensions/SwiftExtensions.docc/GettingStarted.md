# Getting started

Add the package, import the module and replace three common pieces of code that can trap or
run without a limit.

## Add the package

In Xcode, choose **File › Add Package Dependencies…**, enter
`https://github.com/muhittincamdali/SwiftExtensions.git` and add the **SwiftExtensions** library to
your app target. In a `Package.swift`:

```swift
.package(url: "https://github.com/muhittincamdali/SwiftExtensions.git", from: "2.0.0")
```

The package needs Swift 6.2 (Xcode 26) or later and runs on iOS 18, macOS 15, tvOS 18,
watchOS 11 and visionOS 2 or later. ``ResourceUsageAdvice/current(traitCollection:)`` needs the
iOS 27 SDK (Xcode 27); everything else builds with both.

## Import the module

```swift
import SwiftExtensions
```

Nothing is added to your types until you call it: the package only adds methods, initializers and
a few small types.

## Convert numbers without trapping

`Int(_:)` stops the app when a `Double` is NaN, infinite or too large, and such values come from
places you do not control: a division by zero, a JSON field, a sensor. Use
``Swift/BinaryInteger/init(rounding:_:)`` to get `nil` instead:

```swift
let ratio = completed / total            // NaN when total is 0
let percent = Int(rounding: ratio * 100) ?? 0
```

Or hold the value at the edge of the type with
``Swift/FixedWidthInteger/init(clamping:rounding:)``:

```swift
let alpha = UInt8(clamping: opacity * 255) ?? 0   // 0...255, nil only for NaN
```

## Give async work a limit

Wrap a call that may hang in ``withTimeout(_:tolerance:clock:operation:)``:

```swift
let profile = try await withTimeout(.seconds(5)) {
    try await api.profile()
}
```

Retry a call that may fail for a moment with ``withRetry(_:clock:isolation:shouldRetry:operation:)``:

```swift
let feed = try await withRetry(RetryPolicy(maxAttempts: 4)) { attempt in
    try await api.feed()
}
```

## Keep downloads and text within size limits

```swift
let (data, _) = try await URLSession.shared.data(for: request, limit: 2_000_000)
let header = displayName.truncated(toUTF8ByteCount: 64, ending: "…")
```

## Next steps

- <doc:BoundingAsyncWork> explains cancellation, ordering and errors of the concurrency helpers.
- <doc:ConvertingWithoutTraps> lists every conversion and the values that return `nil`.
- <doc:SceneLifecycleAndResources> covers the window scene helpers and the iOS 27 preference.
- <doc:ComparisonWithSwifterSwift> explains which library to use for what.
