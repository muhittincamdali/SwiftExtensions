<!-- i18n-source: README.md@9cc89ccba8326d3257d4c5e7d318393687d889da status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="CI 상태"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="최신 버전: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="지원 플랫폼: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="언어 버전: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="라이선스: MIT"></picture></a>
</p>

<p align="center">
<a href="#빠른-시작"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ko-light.svg" alt="시작하기"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ko-light.svg" alt="문서"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ko-light.svg" alt="예제"></picture></a>
</p>

> 이 문서는 영어 README의 번역본입니다. 내용이 다를 경우 영어 버전이 최신입니다.

<!-- brand:end -->

SwiftExtensions는 표준 라이브러리, Foundation, [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)가 제공하지 않는 extension으로 이루어진 작은 Swift 패키지입니다. Swift concurrency를 위한 시간 제한, 재시도, 동시 실행 수를 제한한 병렬 작업, Swift 자체 initializer가 앱을 멈추게 하는 상황에서 `nil`을 반환하는 변환, 다운로드와 텍스트의 크기 제한, 그리고 scene 생명 주기와 iOS 27의 리소스 사용 절감 설정을 위한 헬퍼를 담고 있습니다. iOS 18+, macOS 15+, tvOS 18+, watchOS 11+, visionOS 2+에서 동작하며 의존성이 없습니다.

**SwifterSwift와의 차이:** SwifterSwift는 편의 기능을 폭넓게 모은 대규모 컬렉션입니다(문자열, 컬렉션, 색상, UIKit을 위한 수백 개의 extension). 이 패키지는 그 반대입니다. SwifterSwift가 다루지 않는 열 개의 좁은 영역에 extension을 제공하며, 각각 Swift 6 strict concurrency에서 `Sendable`로서 올바르고, 경계 사례를 테스트했고, 존재하는 이유와 함께 문서화되어 있습니다. 편의 기능에는 SwifterSwift를, 아래와 같은 경우에는 이 패키지를 사용하세요. 둘을 함께 import할 수도 있습니다.

## 주요 기능

- **앱을 멈추지 않는 변환** — `Int(rounding:)`, `UInt8(clamping:)`, `Duration(timeInterval:)`는 NaN, 무한대, 범위를 벗어난 값에 대해 `nil`을 반환합니다. `Int(_:)`와 `Duration.seconds(_:)`는 이런 값에서 앱을 멈춥니다.
- **시간 제한과 재시도** — `withTimeout`은 너무 오래 걸리는 작업을 취소합니다. `withRetry`는 지터를 더한 지수 백오프로 대기하고, 취소는 절대 재시도하지 않으며, `RetryPolicy`가 잘못된 값을 보정하므로 원격 설정으로 인해 무한 반복하거나 멈추는 일이 없습니다.
- **제한된 병렬 작업** — `concurrentMap(maxConcurrency:)`는 입력 순서를 유지하고, 한 번에 최대 N개의 변환만 실행하며, typed throws를 사용합니다. 오류를 던지지 않는 변환에는 `try`가 필요 없습니다.
- **크기 제한** — `collect(limit:)`와 `URLSession.data(for:limit:)`는 메모리를 가득 채우는 대신 제한에서 읽기를 멈춥니다. `truncated(toUTF8ByteCount:)`는 이모지를 반으로 자르지 않으면서 텍스트를 바이트 예산 안에 유지합니다.
- **iOS 27** — `UIApplication.activeWindowScene`과 `activeKeyWindow`는 iOS 27에서 필수인 scene 생명 주기에 맞춰 더 이상 권장되지 않는 `windows`와 `keyWindow`를 대체합니다. `ResourceUsageAdvice`는 iOS 27의 리소스 사용 절감 설정을 저전력 모드, 그리고 iOS 18부터 제공되는 열 상태와 결합합니다.
- **Swift 6 strict concurrency** — 모든 public 타입이 `Sendable`이고, 모든 클로저가 isolation을 명시하며, 패키지는 Swift 6 언어 모드에서 경고 없이 빌드됩니다.
- **테스트 완료** — macOS에서 README 예제를 포함한 89개의 Swift Testing 테스트, iOS 시뮬레이터에서 같은 테스트와 UIKit 테스트, 그리고 예제 앱을 조작하는 7개의 UI 테스트가 있습니다.

## 빠른 시작

**1. 패키지 추가**

Xcode에서 **File › Add Package Dependencies…**를 선택하고, 오른쪽 위의 검색란에 저장소 URL을 붙여넣으세요.

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

**Dependency Rule**은 `2.0.0`부터 **Up to Next Major Version**으로 그대로 두고 **Add Package**를 클릭하세요. 다음 창에서 **SwiftExtensions** 옆에 앱 타깃을 선택하고 **Add Package**를 다시 클릭하세요.

**2. 모듈 가져오기**

```swift
import SwiftExtensions
```

extension을 사용하는 모든 Swift 파일의 맨 위에 이 줄을 넣으세요.

**3. 사용하기**

새 Xcode 앱(**File › New › Project… › App**)에서 `ContentView.swift`의 내용을 모두 다음으로 바꾸세요.

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

**Run**(⌘R)을 누르세요. 첫 번째 줄에는 `-1`이 표시됩니다. `Int(rounding:)`은 NaN에 `nil`을 반환했지만 `Int(0.0 / 0.0)`은 앱을 멈추게 했을 것이기 때문입니다. 두 번째 줄에는 `Grüß…`가 표시됩니다. 말줄임표를 포함해 UTF-8로 9바이트입니다. 버튼은 3초짜리 작업을 시작하고 **Stopped after 1 second**를 표시합니다.

## 설치

### Swift Package Manager

저장소 URL은 `https://github.com/muhittincamdali/SwiftExtensions.git`, 이 주소를 Xcode의 **File › Add Package Dependencies…**에 입력하거나 `Package.swift`의 `dependencies`에 추가하세요.

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

### 요구 사항

| | 최소 버전 |
| --- | --- |
| Swift | 6.2(Xcode 26 이상) |
| 플랫폼 | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS 27 SDK(Xcode 27) |

2.0.0 버전은 2026년 2월의 1.0.0 API를 대체합니다. 1.0.0은 대부분 SwifterSwift와 겹치는 폭넓은 편의 기능 모음이었고, 2026년 6월에 해당 소스는 플레이스홀더 코드로 교체되었습니다. 2.0.0은 Swift 6 언어 모드를 위해 빌드하고 테스트한, 더 작은 새 패키지입니다. 변경 사항은 [CHANGELOG.md](CHANGELOG.md)에 정리되어 있습니다.

## 사용법

아래 예제는 테스트에서 컴파일되고 실행됩니다([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### 앱을 멈추지 않는 변환

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

| 호출 | `nil`을 반환하는 경우 |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±무한대, 반올림한 값이 타입의 범위를 벗어남 |
| `UInt8(clamping: x)` | NaN뿐입니다. 다른 값은 `min` 또는 `max`로 고정됩니다 |
| `Duration(timeInterval: x)` | NaN, ±무한대, 크기가 2⁶³초 이상 |

`Duration.timeInterval`로 다시 변환할 수 있고, `Date.advanced(by: .seconds(30))`는 `Duration`을 받습니다.

### 시간 제한, 재시도, 병렬 작업

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

- `withTimeout`은 제한 시간이 지나면 `TimeoutError`를 던지고 작업을 취소합니다. 취소는 협력적입니다. 취소 여부를 한 번도 확인하지 않는 작업은 반환될 때까지 오류가 늦어집니다.
- `withRetry`는 `initialDelay × multiplier^(n − 1)`만큼 대기하며, 최대 `maxDelay`까지이고 그 값에서 최대 `jitter` 비율만큼 줄어듭니다. 호출한 쪽의 actor에서 실행되며 `CancellationError`는 절대 재시도하지 않습니다.
- `concurrentMap`은 결과를 `ids`의 순서대로 반환합니다. 첫 번째 오류는 실행 중인 변환을 취소하고 던져집니다. `concurrentCompactMap`과 `concurrentForEach`도 같은 방식으로 동작합니다.

### 크기 제한

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

- `data(for:limit:)`는 제한을 넘는 `Content-Length`를 본문을 읽기 전에 거부하고, 그 외의 본문은 `limit + 1`번째 바이트에서 읽기를 멈추며, 전송을 취소하고 `ResponseTooLargeError`를 던집니다.
- `collect(limit:)`와 `collectData(limit:)`는 모든 `AsyncSequence`에 대해 같은 일을 합니다.
- `truncated(toUTF8ByteCount:ending:)`는 문자를 온전하게 유지합니다. 25바이트짜리 가족 이모지는 통째로 남거나 빠지며, 중간에서 잘리지 않습니다.

### 윈도 scene

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

`UIApplication.shared`로 호출하세요. `activeWindowScene`은 포그라운드에서 활성 상태인 scene을 가장 먼저 선택하고, 그다음 비활성 scene, 마지막으로 백그라운드 scene을 선택합니다. Apple의 [TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)은 iOS 27 SDK로 빌드한 앱이 사용해야 하는 scene 생명 주기를 설명합니다.

### 리소스 사용 절감

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

`shouldReduceWork`는 저전력 모드가 켜져 있거나, 열 상태가 `serious` 또는 `critical`이거나, iOS 27에서 시스템이 리소스 사용 절감을 선호할 때 `true`가 됩니다. iOS 27 값은 `@Environment(\.systemPrefersReducedResourceUsage)`나 trait collection에서 전달하세요. [문서](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)에서 두 방법을 모두 보여 줍니다.

## SwiftExtensions와 SwifterSwift

| 필요한 것 | 이 패키지 없이 | SwiftExtensions |
| --- | --- | --- |
| NaN일 수 있는 `Double`에서 정수 얻기 | `Int(x)`는 앱을 멈춤 | `Int(rounding:)`, `Int(clamping:)` |
| `TimeInterval`에서 `Duration` 얻기 | `.seconds(x)`는 NaN에서 앱을 멈춤 | `Duration(timeInterval:)` |
| 바이트 제한 안의 텍스트 | SwifterSwift의 `truncated(toLength:)`는 문자 수를 셈 | `truncated(toUTF8ByteCount:)` |
| 비동기 작업의 시간 제한 | 직접 작성한 task group | `withTimeout` |
| 백오프를 적용한 재시도 | `Task.sleep`을 쓰는 반복문 | `withRetry`, `RetryPolicy` |
| 동시 실행 수를 제한한 병렬 map | 요소마다 task 하나 | `concurrentMap(maxConcurrency:)` |
| 크기 제한이 있는 비동기 시퀀스 또는 다운로드 | `Array(sequence)`, `data(for:)`는 어떤 크기든 읽음 | `collect(limit:)`, `data(for:limit:)` |
| 화면에 표시된 윈도 | `UIApplication.shared.windows`는 더 이상 권장되지 않지만 SwifterSwift는 아직 사용함 | `activeWindowScene`, `activeKeyWindow` |
| iOS 18~27에서 작업량 줄이기 | API 세 개, 그중 하나는 iOS 27 전용 | `ResourceUsageAdvice` |

[SwiftExtensions와 SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)에서는 이 패키지를 swift-async-algorithms, swift-concurrency-extras, CollectionConcurrencyKit과도 비교합니다.

## 예제 앱

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo)는 iOS와 macOS용 SwiftUI 앱으로, extension 그룹마다 화면이 하나씩 있습니다. 앱을 멈추게 하는 값의 변환, 바이트 제한에 맞춰 잘리는 텍스트 필드, `withTimeout`, `withRetry`, `concurrentMap`을 실행하는 버튼, 그리고 실시간 리소스 권고와 윈도 scene 상태입니다. `ExtensionsDemo.xcodeproj`를 열고 **Run**을 누르세요. UI 테스트는 각 화면이 무엇을 표시하는지 iOS 시뮬레이터에서 확인합니다.

<p align="center">
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/conversions-dark.png"><img src="docs/images/conversions-light.png" width="200" alt="ExtensionsDemo의 Conversions 화면"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/truncation-dark.png"><img src="docs/images/truncation-light.png" width="200" alt="ExtensionsDemo의 UTF-8 truncation 화면"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/async-dark.png"><img src="docs/images/async-light.png" width="200" alt="측정 결과가 표시된 ExtensionsDemo의 Async limits 화면"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/system-dark.png"><img src="docs/images/system-light.png" width="200" alt="ExtensionsDemo의 Scenes and resources 화면"></picture>
</p>

스크린샷은 `scripts/capture-screens.sh`가 iPhone 시뮬레이터에서 앱을 촬영한 것입니다.

## 문서

[문서](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)는 모든 타입을 다루며 다섯 편의 글이 있습니다.

- [시작하기](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions와 SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [비동기 작업에 한계 두기](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [앱을 멈추지 않고 변환하기](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [scene 생명 주기와 리소스 사용 절감](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## 기여하기

모든 extension에는 표준 라이브러리, Foundation, SwifterSwift가 다루지 않는다는 이유와 경계 사례에 대한 테스트, 그리고 문서가 필요합니다. 제안하는 방법은 [CONTRIBUTING.md](CONTRIBUTING.md)에 설명되어 있습니다. 보안 문제는 [SECURITY.md](SECURITY.md)에 설명된 방식으로 제보해 주세요.

## 라이선스

SwiftExtensions는 MIT 라이선스로 배포됩니다. 자세한 내용은 [LICENSE](LICENSE)를 참고하세요.
