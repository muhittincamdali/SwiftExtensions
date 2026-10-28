# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Version 2.0.0, not yet released, is a new package with a new API. The 1.0.0 extensions mostly
repeated what SwifterSwift already provides, and in June 2026 they were replaced with placeholder
code. 2.0.0 keeps only extensions that the standard library, Foundation and SwifterSwift do not
provide, each `Sendable`-correct in the Swift 6 language mode and tested at its edge cases.

### Added

- `BinaryInteger.init?(rounding:_:)` and `FixedWidthInteger.init?(clamping:rounding:)`:
  integers from floating-point values that return `nil` for NaN instead of trapping; the first
  also for infinity and values outside the type, the second holds those at `min` or `max`.
- `Duration.timeInterval`, `Duration.init?(timeInterval:)` and `Date.advanced(by:)` for a
  `Duration`. The initializer returns `nil` where `Duration.seconds(_:)` traps.
- `StringProtocol.truncated(toUTF8ByteCount:ending:)`, which keeps text within a UTF-8 byte limit
  without splitting a character.
- `withTimeout(_:tolerance:clock:operation:)` and `TimeoutError`.
- `withRetry(_:clock:isolation:shouldRetry:operation:)` and `RetryPolicy` with exponential backoff
  and jitter. The policy corrects out-of-range values, and `CancellationError` is never retried.
- `Sequence.concurrentMap(maxConcurrency:_:)`, `concurrentCompactMap` and `concurrentForEach`:
  order-preserving parallel work with a limit and typed throws.
- `AsyncSequence.collect(limit:isolation:)`, `collectData(limit:isolation:)` and
  `CollectLimitExceededError`.
- `URLSession.data(for:limit:)`, `data(from:limit:)` and `ResponseTooLargeError`.
- `UIApplication.activeWindowScene` and `activeKeyWindow` for the scene life cycle.
- `ResourceUsageAdvice`, which combines the iOS 27 `systemPrefersReducedResourceUsage`
  preference with Low Power Mode and the thermal state, with `current`, `updates()` and, with the
  iOS 27 SDK, `current(traitCollection:)`.
- DocC documentation with five articles, and the ExtensionsDemo example app for iOS and macOS
  with UI tests and the script that captures the README screenshots.

### Changed

- **Breaking:** the package needs Swift 6.2 and iOS 18, macOS 15, tvOS 18, watchOS 11 or
  visionOS 2.

### Removed

- **Breaking:** every 1.0.0 extension (string validation and formatting, array, date,
  dictionary, number and optional helpers, `Color(hex:)`, `UIColor` and `UIView` helpers). Most
  of them have an equivalent in [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift).
- The placeholder types from June 2026: `SwiftExtensionsCircuitBreaker`, `RetryPolicy`,
  `SwiftExtensionsEventBus`, `SwiftExtensionsMetricsCollector`, `SwiftExtensionsErrorHandler`,
  `SafeArray` and the `SwiftExtensions.version` constant.
- The CocoaPods podspec. It was never published (the name belongs to another pod on the trunk);
  use Swift Package Manager.

## [1.0.0] - 2026-02-03

### Added

- Extensions for `String` (validation, formatting, hashing), `Array`, `Data`, `Date`,
  `Dictionary`, `Double`, `Int` and `Optional`.
- SwiftUI `Color(hex:)` and conditional view modifiers; UIKit `UIColor` and `UIView` helpers.

[Unreleased]: https://github.com/muhittincamdali/SwiftExtensions/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/muhittincamdali/SwiftExtensions/releases/tag/v1.0.0
