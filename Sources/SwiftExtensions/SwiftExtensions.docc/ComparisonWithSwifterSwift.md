# SwiftExtensions and SwifterSwift

Which library to use for what, and why this package is small on purpose.

## Overview

[SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) is the large, long-running collection
of Swift extensions: hundreds of conveniences for strings, collections, dates, colors, UIKit,
AppKit and SwiftUI. If you want `"hello".firstCharacterAsString`, `array[safe: 3]` or
`UIColor(hex:)`, use it.

SwiftExtensions does not repeat any of that. It is a short list of extensions that meet three
rules:

1. **SwifterSwift, the standard library and Foundation do not provide it**, or provide it in a
   way that traps or has no limit.
2. **It is correct under Swift 6 strict concurrency**: `Sendable` types, closures whose isolation
   is stated, no `@unchecked Sendable` in the public API.
3. **It has tests for its edge cases**, and its documentation says why it exists.

## What is here, and what you would write without it

| Need                                    | Without this package                              | Here                                                      |
| --------------------------------------- | ------------------------------------------------- | --------------------------------------------------------- |
| Integer from a `Double` that may be NaN | `Int(x)` traps; `Int(exactly:)` refuses fractions | ``Swift/BinaryInteger/init(rounding:_:)``                   |
| Integer held at the edge of its type    | `Int(x)` traps beyond the range                   | ``Swift/FixedWidthInteger/init(clamping:rounding:)``        |
| `Duration` from a `TimeInterval`        | `.seconds(x)` traps for NaN and infinity          | ``Swift/Duration/init(timeInterval:)``                      |
| `TimeInterval` from a `Duration`        | Arithmetic on `components`                        | ``Swift/Duration/timeInterval``                             |
| Text within a byte limit                | `prefix(_:)` counts characters, not bytes         | ``Swift/StringProtocol/truncated(toUTF8ByteCount:ending:)`` |
| A time limit for async work             | A task group written by hand                      | ``withTimeout(_:tolerance:clock:operation:)``               |
| Retries with backoff                    | A loop with `Task.sleep`                          | ``withRetry(_:clock:isolation:shouldRetry:operation:)``     |
| Parallel map with a limit               | One task per element                              | ``Swift/Sequence/concurrentMap(maxConcurrency:_:)``         |
| Async sequence into an array            | `Array(sequence)` with no limit                   | ``_Concurrency/AsyncSequence/collect(limit:isolation:)``    |
| Download with a size limit              | `data(for:)` reads any size                       | ``Foundation/URLSession/data(for:limit:)``                  |
| The window scene on screen              | `UIApplication.shared.windows` (deprecated)       | ``UIKit/UIApplication/activeWindowScene``                   |
| Reduce work on iOS 18 to 27             | Three APIs, one of them iOS 27 only               | ``ResourceUsageAdvice``                                     |

SwifterSwift's UIKit helpers still look up windows through `UIApplication.shared.windows` and
`keyWindow`; with the scene life cycle that iOS 27 requires, use
``UIKit/UIApplication/activeKeyWindow`` instead.

## Using both

The two packages can be imported in the same file. Where SwifterSwift has an extension with a
similar purpose, the names and labels differ: SwifterSwift's `truncated(toLength:trailing:)`
counts characters, this package's ``Swift/StringProtocol/truncated(toUTF8ByteCount:ending:)``
counts bytes.

## Other packages

- [swift-async-algorithms](https://github.com/apple/swift-async-algorithms) adds operators on
  async sequences, such as `debounce`, `merge` and `chunks`. It has no timeout, retry or bounded
  collection.
- [swift-concurrency-extras](https://github.com/pointfreeco/swift-concurrency-extras) helps test
  concurrent code and wrap values for isolation.
- [CollectionConcurrencyKit](https://github.com/JohnSundell/CollectionConcurrencyKit) has
  `concurrentMap`, but starts one task per element and predates `Sendable` checking.
