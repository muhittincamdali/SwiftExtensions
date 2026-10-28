<!-- i18n-source: README.md@c00d9955298fc27d6c0cca3e349200338c272d46 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="CI 状态"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="最新版本: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="支持的平台: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="语言版本: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="许可证: MIT"></picture></a>
</p>

<p align="center">
<a href="#快速开始"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-zh-CN-light.svg" alt="开始使用"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-zh-CN-light.svg" alt="文档"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-zh-CN-light.svg" alt="示例"></picture></a>
</p>

> 本文是英文 README 的译文。如两者内容不一致，以英文版为准。

<!-- brand:end -->

SwiftExtensions 是一个小型 Swift 软件包，提供标准库、Foundation 和 [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) 所没有的 extension：面向 Swift concurrency 的超时、重试和有并发上限的并行任务，在 Swift 自带的初始化方法会让应用崩溃时返回 `nil` 的类型转换，下载内容和文本的大小限制，以及用于场景生命周期和 iOS 27 降低资源占用偏好的辅助工具。它支持 iOS 18+、macOS 15+、tvOS 18+、watchOS 11+ 和 visionOS 2+，没有任何依赖。

**与 SwifterSwift 的区别：** SwifterSwift 是一个庞大的便利方法集合（为字符串、集合、颜色和 UIKit 提供数百个 extension）。本软件包则相反：它在十个狭窄的领域提供 extension，这些领域 SwifterSwift 均未涉及；每个 extension 在 Swift 6 严格并发下都符合 `Sendable` 要求，针对边界情况做过测试，并附有说明其存在理由的文档。便利方法请用 SwifterSwift，下面这些场景请用本软件包；两者可以同时导入。

## 亮点

- **不会崩溃的类型转换** — `Int(rounding:)`、`UInt8(clamping:)` 和 `Duration(timeInterval:)` 在遇到 NaN、无穷大和超出范围的值时返回 `nil`，而 `Int(_:)` 和 `Duration.seconds(_:)` 在这些情况下会让应用崩溃。
- **超时与重试** — `withTimeout` 会取消运行过久的任务；`withRetry` 以带抖动的指数退避重试，从不重试已取消的任务，其 `RetryPolicy` 还会修正无效值，因此远程配置无法让它陷入死循环或崩溃。
- **有上限的并行任务** — `concurrentMap(maxConcurrency:)` 保持输入顺序，同时最多运行 N 个转换，并使用 typed throws：对不会抛出错误的转换无需 `try`。
- **大小限制** — `collect(limit:)` 和 `URLSession.data(for:limit:)` 在达到上限时停止读取，而不是占满内存；`truncated(toUTF8ByteCount:)` 让文本保持在字节预算之内，且不会把一个 emoji 从中间截断。
- **iOS 27** — `UIApplication.activeWindowScene` 和 `activeKeyWindow` 取代已弃用的 `windows` 和 `keyWindow`，适配 iOS 27 要求的场景生命周期；`ResourceUsageAdvice` 将 iOS 27 的降低资源占用偏好与低电量模式以及自 iOS 18 起提供的热状态结合起来。
- **Swift 6 严格并发** — 每个公开类型都是 `Sendable`，每个闭包都声明其隔离方式，软件包在 Swift 6 语言模式下编译无警告。
- **经过测试** — 在 macOS 上有 89 个 Swift Testing 测试（包括 README 中的示例），在 iOS 模拟器上运行同样的测试外加 UIKit 测试，另有 7 个驱动示例应用的 UI 测试。

## 快速开始

**1. 添加软件包**

在 Xcode 中选择 **File › Add Package Dependencies…**，然后把仓库地址粘贴到右上角的搜索框：

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

将 **Dependency Rule** 保持为从 `2.0.0` 起的 **Up to Next Major Version**，然后点击 **Add Package**。在下一个窗口中，在 **SwiftExtensions** 旁选择你的应用 target，再次点击 **Add Package**。

**2. 导入模块**

```swift
import SwiftExtensions
```

把这一行放在每个使用这些 extension 的 Swift 文件的顶部。

**3. 开始使用**

在新建的 Xcode 应用中（**File › New › Project… › App**），把 `ContentView.swift` 的全部内容替换为：

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

按 **Run**（⌘R）。第一行显示 `-1`，因为 `Int(rounding:)` 对 NaN 返回了 `nil`，而 `Int(0.0 / 0.0)` 会让应用崩溃。第二行显示 `Grüß…`：加上省略号共 9 个 UTF-8 字节。点击按钮会启动一个 3 秒的任务，并显示 **Stopped after 1 second**。

## 安装

### Swift Package Manager

仓库地址是 `https://github.com/muhittincamdali/SwiftExtensions.git`, 你可以在 Xcode 的 **File › Add Package Dependencies…** 中输入它，也可以把它添加到 `Package.swift` 的 `dependencies` 中：

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

### 系统要求

| | 最低版本 |
| --- | --- |
| Swift | 6.2（Xcode 26 或更高版本） |
| 平台 | iOS 18、macOS 15、tvOS 18、watchOS 11、visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS 27 SDK（Xcode 27） |

2.0.0 版本取代了 2026 年 2 月发布的 1.0.0 API，后者是一大批便利方法，大多重复了 SwifterSwift；2026 年 6 月，这些源码被占位代码替换。2.0.0 是一个全新的、更小的软件包，为 Swift 6 语言模式构建并经过测试。变更内容见 [CHANGELOG.md](CHANGELOG.md)。

## 使用方法

下面的示例都由测试编译并运行（[`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)）。

### 不会崩溃的类型转换

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

| 调用 | 在以下情况返回 `nil` |
| --- | --- |
| `Int(rounding: x, rule)` | NaN、±无穷大，或舍入后的值超出该类型范围 |
| `UInt8(clamping: x)` | 仅 NaN；其他值会被限制在 `min` 或 `max` |
| `Duration(timeInterval: x)` | NaN、±无穷大，或绝对值达到 2⁶³ 秒及以上 |

`Duration.timeInterval` 可以转换回来，`Date.advanced(by: .seconds(30))` 接受一个 `Duration`。

### 超时、重试与并行任务

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

- `withTimeout` 在超过时限后抛出 `TimeoutError` 并取消该操作。取消是协作式的：如果操作从不检查取消状态，错误会延迟到它返回时才抛出。
- `withRetry` 等待 `initialDelay × multiplier^(n − 1)`，最长为 `maxDelay`，并最多减去其中 `jitter` 的比例。它在调用方的 actor 上运行，从不重试 `CancellationError`。
- `concurrentMap` 按 `ids` 的顺序返回结果。第一个错误会取消正在运行的转换并被抛出；`concurrentCompactMap` 和 `concurrentForEach` 的行为相同。

### 大小限制

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

- `data(for:limit:)` 在读取响应体之前就拒绝超过上限的 `Content-Length`，对其他响应体则在第 `limit + 1` 个字节处停止，取消传输并抛出 `ResponseTooLargeError`。
- `collect(limit:)` 和 `collectData(limit:)` 对任意 `AsyncSequence` 做同样的事。
- `truncated(toUTF8ByteCount:ending:)` 保留完整的字符：一个 25 字节的家庭 emoji 要么整个保留，要么整个舍弃，绝不会被截断。

### 窗口场景

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

请用 `UIApplication.shared` 调用它。`activeWindowScene` 优先选择处于前台且活跃的场景，其次是非活跃的，最后是在后台的。Apple 的 [TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle) 说明了使用 iOS 27 SDK 构建的应用必须采用的场景生命周期。

### 降低资源占用

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

当低电量模式开启、热状态为 `serious` 或 `critical`，或者在 iOS 27 上系统偏好降低资源占用时，`shouldReduceWork` 为 `true`。iOS 27 的值请通过 `@Environment(\.systemPrefersReducedResourceUsage)` 或 trait collection 传入；这篇[文章](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)展示了两种方式。

## SwiftExtensions 与 SwifterSwift

| 需求 | 没有本软件包时 | SwiftExtensions |
| --- | --- | --- |
| 从可能为 NaN 的 `Double` 得到整数 | `Int(x)` 会崩溃 | `Int(rounding:)`、`Int(clamping:)` |
| 由 `TimeInterval` 得到 `Duration` | `.seconds(x)` 遇到 NaN 会崩溃 | `Duration(timeInterval:)` |
| 限制字节数的文本 | SwifterSwift 的 `truncated(toLength:)` 按字符计数 | `truncated(toUTF8ByteCount:)` |
| 为异步任务设置时限 | 手写 task group | `withTimeout` |
| 带退避的重试 | 使用 `Task.sleep` 的循环 | `withRetry`、`RetryPolicy` |
| 有并发上限的并行 map | 每个元素一个 task | `concurrentMap(maxConcurrency:)` |
| 有大小限制的异步序列或下载 | `Array(sequence)`、`data(for:)` 会读取任意大小 | `collect(limit:)`、`data(for:limit:)` |
| 屏幕上的窗口 | `UIApplication.shared.windows` 已弃用，SwifterSwift 仍在使用 | `activeWindowScene`、`activeKeyWindow` |
| 在 iOS 18 到 27 上减少工作量 | 三个 API，其中一个仅限 iOS 27 | `ResourceUsageAdvice` |

[SwiftExtensions 与 SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift) 还将本软件包与 swift-async-algorithms、swift-concurrency-extras 和 CollectionConcurrencyKit 做了对比。

## 示例应用

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) 是一个面向 iOS 和 macOS 的 SwiftUI 应用，每组 extension 对应一个界面：会导致崩溃的值的转换、按字节上限截断的文本框、运行 `withTimeout`、`withRetry` 和 `concurrentMap` 的按钮，以及实时的资源建议和窗口场景状态。打开 `ExtensionsDemo.xcodeproj` 并按 **Run**。它的 UI 测试会在 iOS 模拟器上检查每个界面显示的内容。

<p align="center">
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/conversions-dark.png"><img src="docs/images/conversions-light.png" width="200" alt="ExtensionsDemo 的 Conversions 界面"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/truncation-dark.png"><img src="docs/images/truncation-light.png" width="200" alt="ExtensionsDemo 的 UTF-8 truncation 界面"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/async-dark.png"><img src="docs/images/async-light.png" width="200" alt="ExtensionsDemo 的 Async limits 界面及实测结果"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/system-dark.png"><img src="docs/images/system-light.png" width="200" alt="ExtensionsDemo 的 Scenes and resources 界面"></picture>
</p>

这些截图由 `scripts/capture-screens.sh` 在 iPhone 模拟器上从应用中截取。

## 文档

[文档](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)涵盖每个类型，并包含五篇文章：

- [入门](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions 与 SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [为异步任务设置边界](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [不崩溃的类型转换](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [场景生命周期与降低资源占用](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## 参与贡献

每个 extension 都需要有标准库、Foundation 和 SwifterSwift 未覆盖的理由、针对边界情况的测试以及文档；如何提出新的 extension，请见 [CONTRIBUTING.md](CONTRIBUTING.md)。安全问题请按 [SECURITY.md](SECURITY.md) 中的说明报告。

## 许可证

SwiftExtensions 基于 MIT 许可证发布。详见 [LICENSE](LICENSE)。
