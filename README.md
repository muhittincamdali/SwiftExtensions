<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="Latest version: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="Supported platforms: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="Language version: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="License: MIT"></picture></a>
</p>

<p align="center">
<a href="#quick-start"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-en-light.svg" alt="Get started"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-en-light.svg" alt="Documentation"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-en-light.svg" alt="Examples"></picture></a>
</p>

<!-- brand:end -->

SwiftExtensions is a small Swift package of extensions that the standard library, Foundation and
[SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) do not provide: time limits, retries
and bounded parallel work for Swift concurrency, conversions that return `nil` where Swift's own
initializers stop the app, size limits for downloads and text, and helpers for the scene life
cycle and the reduced-resource preference of iOS 27. It runs on iOS 18+, macOS 15+, tvOS 18+,
watchOS 11+ and visionOS 2+ and has no dependencies.

**How it differs from SwifterSwift:** SwifterSwift is a large collection of conveniences (hundreds
of extensions for strings, collections, colors and UIKit). This package is the opposite: extensions in ten
narrow areas, none of which SwifterSwift covers, each one `Sendable`-correct under Swift 6
strict concurrency, tested at its edge cases and documented with the reason it exists. Use
SwifterSwift for conveniences and this package for the cases below; the two can be imported
together.

## Highlights

- **Conversions that do not trap** — `Int(rounding:)`, `UInt8(clamping:)` and
  `Duration(timeInterval:)` return `nil` for NaN, infinity and out-of-range values, where
  `Int(_:)` and `Duration.seconds(_:)` stop the app.
- **Time limits and retries** — `withTimeout` cancels work that runs too long; `withRetry` backs
  off exponentially with jitter, never retries cancellation, and its `RetryPolicy` corrects
  invalid values so remote configuration cannot make it loop or trap.
- **Parallel work with a limit** — `concurrentMap(maxConcurrency:)` keeps the order of the input,
  runs at most N transforms at a time and uses typed throws: no `try` for a transform that
  cannot throw.
- **Size limits** — `collect(limit:)` and `URLSession.data(for:limit:)` stop reading at the limit
  instead of filling the memory; `truncated(toUTF8ByteCount:)` keeps text within a byte budget
  without cutting an emoji in half.
- **iOS 27** — `UIApplication.activeWindowScene` and `activeKeyWindow` replace the deprecated
  `windows` and `keyWindow` for the scene life cycle that iOS 27 requires, and
  `ResourceUsageAdvice` combines the iOS 27 reduced-resource preference with Low Power Mode and
  the thermal state from iOS 18 on.
- **Swift 6 strict concurrency** — every public type is `Sendable`, every closure states its
  isolation, and the package builds without warnings in the Swift 6 language mode.
- **Tested** — 85 Swift Testing tests on macOS, including the README samples, the same tests plus
  the UIKit ones on an iOS simulator, and 7 UI tests that drive the example app.

## Quick start

**1. Add the package**

In Xcode, choose **File › Add Package Dependencies…** and paste the repository URL into the
search field at the top right:

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

Leave **Dependency Rule** at **Up to Next Major Version** from `2.0.0` and click **Add Package**.
In the next window, choose your app target next to **SwiftExtensions** and click **Add Package**
again.

**2. Import the module**

```swift
import SwiftExtensions
```

Put this line at the top of each Swift file that uses the extensions.

**3. Use it**

In a new Xcode app (**File › New › Project… › App**), replace everything in `ContentView.swift`
with:

```swift
import SwiftExtensions
import SwiftUI

struct ContentView: View {
    @State private var status = "Not started"

    var body: some View {
        VStack(spacing: 16) {
            Text("Int(rounding: 0.0 / 0.0) is \(Int(rounding: 0.0 / 0.0) ?? -1)")
            Text("Grüße 👋🏽".truncated(toUTF8ByteCount: 9, ending: "…"))
            Button("Wait 3 s with a 1 s limit") {
                Task { status = await waitWithLimit() }
            }
            Text(status)
        }
    }
}

func waitWithLimit() async -> String {
    do {
        try await withTimeout(.seconds(1)) {
            try await Task.sleep(for: .seconds(3))
        }
        return "Finished"
    } catch is TimeoutError {
        return "Stopped after 1 second"
    } catch {
        return "Cancelled"
    }
}
```

Press **Run** (⌘R). The first line shows `-1`, because `Int(rounding:)` returned `nil` for NaN
where `Int(0.0 / 0.0)` would have stopped the app. The second line shows `Grüß…`: 9 bytes of
UTF-8 with the ellipsis. The button starts a 3-second task and shows **Stopped after 1 second**.

## Installation

### Swift Package Manager

In Xcode, choose **File › Add Package Dependencies…** and enter
`https://github.com/muhittincamdali/SwiftExtensions.git`, or add it to the `dependencies` in your
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftExtensions.git", from: "2.0.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "SwiftExtensions", package: "SwiftExtensions")
    ])
]
```

### Requirements

| | Minimum |
| --- | --- |
| Swift | 6.2 (Xcode 26 or later) |
| Platforms | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS 27 SDK (Xcode 27) |

Version 2.0.0 replaces the 1.0.0 API from February 2026, a broad set of conveniences that mostly
repeated SwifterSwift; in June 2026 those sources were replaced with placeholder code. 2.0.0 is a
new, smaller package built and tested for the Swift 6 language mode. [CHANGELOG.md](CHANGELOG.md)
lists the changes.

## Usage

The samples below are compiled and run by the tests
([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### Conversions that do not trap

```swift
func progressLabel(done: Double, total: Double) -> String {
    // done / total is NaN when both are 0 and infinity when only total is 0.
    guard let percent = Int(rounding: done / total * 100) else { return "–" }
    return "\(percent) %"
}

func retryDelay(fromHeader value: String?) -> Duration {
    // "Retry-After: 1e400" parses as infinity; Duration.seconds(_:) would stop the app.
    guard let seconds = value.flatMap(Double.init), seconds >= 0 else { return .seconds(5) }
    return Duration(timeInterval: seconds) ?? .seconds(5)
}
```

| Call | Returns `nil` for |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±infinity, a rounded value outside the type |
| `UInt8(clamping: x)` | NaN only; other values are held at `min` or `max` |
| `Duration(timeInterval: x)` | NaN, ±infinity, a magnitude of 2⁶³ seconds or more |

`Duration.timeInterval` converts back, and `Date.advanced(by: .seconds(30))` takes a `Duration`.

### Time limits, retries and parallel work

```swift
protocol PhotoLibrary: Sendable {
    func thumbnail(for id: Int) async throws -> Data
}

func thumbnails(for ids: [Int], from library: some PhotoLibrary) async throws -> [Data] {
    try await withTimeout(.seconds(10)) {
        try await ids.concurrentMap(maxConcurrency: 4) { id in
            try await withRetry(RetryPolicy(maxAttempts: 3)) { _ in
                try await library.thumbnail(for: id)
            }
        }
    }
}
```

- `withTimeout` throws `TimeoutError` after the limit and cancels the operation. Cancellation is
  cooperative: an operation that never checks for it delays the error until it returns.
- `withRetry` waits `initialDelay × multiplier^(n − 1)`, at most `maxDelay`, minus up to
  `jitter` of it. It runs on the caller's actor and never retries `CancellationError`.
- `concurrentMap` returns the results in the order of `ids`. The first error cancels the
  running transforms and is thrown; `concurrentCompactMap` and `concurrentForEach` work the same
  way.

### Size limits

```swift
func downloadAvatar(from url: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url, limit: 512 * 1024)
    return data
}

func pushTitle(for name: String) -> String {
    // The notification server stores titles in a 64-byte column, measured in UTF-8.
    "New message from \(name)".truncated(toUTF8ByteCount: 64, ending: "…")
}
```

- `data(for:limit:)` refuses a `Content-Length` above the limit before reading the body, stops
  any other body at byte `limit + 1`, cancels the transfer and throws `ResponseTooLargeError`.
- `collect(limit:)` and `collectData(limit:)` do the same for any `AsyncSequence`.
- `truncated(toUTF8ByteCount:ending:)` keeps whole characters: a 25-byte family emoji is kept or
  left out, never cut.

### Window scenes

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

Call it with `UIApplication.shared`. `activeWindowScene` prefers a scene in the foreground and
active, then inactive, then in the background. Apple's
[TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
explains the scene life cycle that apps built with the iOS 27 SDK must use.

### Reduced resource usage

```swift
struct GalleryView: View {
    @State private var advice = ResourceUsageAdvice.current()

    var body: some View {
        Text(advice.shouldReduceWork ? "Prefetching paused" : "Prefetching on")
            .task {
                for await next in ResourceUsageAdvice.updates() {
                    advice = next
                }
            }
    }
}
```

`shouldReduceWork` is `true` when Low Power Mode is on, the thermal state is `serious` or
`critical`, or, on iOS 27, the system prefers reduced resource usage. Pass the iOS 27 value from
`@Environment(\.systemPrefersReducedResourceUsage)` or a trait collection; the
[article](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)
shows both.

## SwiftExtensions and SwifterSwift

| Need | Without this package | SwiftExtensions |
| --- | --- | --- |
| Integer from a `Double` that may be NaN | `Int(x)` traps | `Int(rounding:)`, `Int(clamping:)` |
| `Duration` from a `TimeInterval` | `.seconds(x)` traps for NaN | `Duration(timeInterval:)` |
| Text within a byte limit | SwifterSwift's `truncated(toLength:)` counts characters | `truncated(toUTF8ByteCount:)` |
| A time limit for async work | A task group written by hand | `withTimeout` |
| Retries with backoff | A loop with `Task.sleep` | `withRetry`, `RetryPolicy` |
| Parallel map with a limit | One task per element | `concurrentMap(maxConcurrency:)` |
| Async sequence or download with a size limit | `Array(sequence)`, `data(for:)` read any size | `collect(limit:)`, `data(for:limit:)` |
| The window on screen | `UIApplication.shared.windows`, deprecated; SwifterSwift still uses it | `activeWindowScene`, `activeKeyWindow` |
| Reduce work on iOS 18 to 27 | Three APIs, one of them iOS 27 only | `ResourceUsageAdvice` |

[SwiftExtensions and SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
also compares the package with swift-async-algorithms, swift-concurrency-extras and
CollectionConcurrencyKit.

## Example app

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) is a SwiftUI app for iOS and macOS with one
screen per group of extensions: conversions of values that trap, a text field truncated to a byte
limit, buttons that run `withTimeout`, `withRetry` and `concurrentMap`, and the live resource
advice and window scene state. Open `ExtensionsDemo.xcodeproj` and press **Run**. Its UI tests
check on an iOS simulator what each screen shows.

## Documentation

The [documentation](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)
covers every type and has five articles:

- [Getting started](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions and SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [Bounding async work](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [Converting without traps](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [The scene life cycle and reduced resource usage](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## Contributing

Every extension needs a reason that the standard library, Foundation and SwifterSwift do not
cover, tests for its edge cases and documentation; [CONTRIBUTING.md](CONTRIBUTING.md) explains
how to propose one. Report security issues as described in [SECURITY.md](SECURITY.md).

## License

SwiftExtensions is available under the MIT license. See [LICENSE](LICENSE).
