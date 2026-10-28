# ``SwiftExtensions``

A small set of Swift 6 extensions for what the standard library, Foundation and SwifterSwift leave out: time limits, retries and bounded parallel work for Swift concurrency, conversions that return `nil` instead of stopping the app, and helpers for the scene life cycle and reduced-resource preference of iOS 27.

## Overview

Every extension here exists because the obvious code either traps, grows without a limit or
does not compile in the Swift 6 language mode:

```swift
import SwiftExtensions

// Int(_:) stops the app for NaN; this returns nil.
let percent = Int(rounding: done / total * 100) ?? 0

// Duration.seconds(_:) stops the app for NaN and infinity; this returns nil.
let wait = Duration(timeInterval: retryAfter) ?? .seconds(5)

// A request that takes longer than 5 seconds throws TimeoutError and is cancelled.
let profile = try await withTimeout(.seconds(5)) { try await api.profile() }

// At most 4 downloads at a time, results in the order of the IDs.
let images = try await ids.concurrentMap(maxConcurrency: 4) { try await api.image($0) }

// The body is refused as soon as it passes 2 MB.
let (data, _) = try await URLSession.shared.data(for: request, limit: 2_000_000)
```

All public types are `Sendable`, every closure states its isolation, and the package compiles
without warnings in the Swift 6 language mode. It has no dependencies, never writes to the
console and supports iOS 18, macOS 15, tvOS 18, watchOS 11 and visionOS 2 or later.

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:ComparisonWithSwifterSwift>

### Time limits, retries and parallel work

- <doc:BoundingAsyncWork>
- ``withTimeout(_:tolerance:clock:operation:)``
- ``TimeoutError``
- ``withRetry(_:clock:isolation:shouldRetry:operation:)``
- ``RetryPolicy``
- ``CollectLimitExceededError``
- ``ResponseTooLargeError``

### Conversions that do not trap

- <doc:ConvertingWithoutTraps>

### The iOS 27 scene life cycle and resource preference

- <doc:SceneLifecycleAndResources>
- ``ResourceUsageAdvice``
