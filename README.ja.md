<!-- i18n-source: README.md@9cc89ccba8326d3257d4c5e7d318393687d889da status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="CI ステータス"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="最新バージョン: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="対応プラットフォーム: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="言語バージョン: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="ライセンス: MIT"></picture></a>
</p>

<p align="center">
<a href="#クイックスタート"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ja-light.svg" alt="はじめる"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ja-light.svg" alt="ドキュメント"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ja-light.svg" alt="サンプル"></picture></a>
</p>

> このドキュメントは英語版 README の翻訳です。内容が異なる場合は英語版が最新です。

<!-- brand:end -->

SwiftExtensions は、標準ライブラリ、Foundation、[SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) が提供していない extension を集めた小さな Swift パッケージです。Swift concurrency 向けのタイムアウト、リトライ、同時実行数を制限した並列処理、Swift 標準のイニシャライザではアプリが停止してしまう場面で `nil` を返す変換、ダウンロードやテキストのサイズ制限、そしてシーンのライフサイクルと iOS 27 のリソース使用量を抑える設定のためのヘルパーを含みます。iOS 18+、macOS 15+、tvOS 18+、watchOS 11+、visionOS 2+ で動作し、依存関係はありません。

**SwifterSwift との違い：** SwifterSwift は、文字列、コレクション、色、UIKit に関する数百の extension を備えた、大規模な便利機能のコレクションです。このパッケージはその逆で、SwifterSwift がカバーしていない 10 の限られた領域の extension を提供します。どれも Swift 6 の strict concurrency で `Sendable` として正しく、境界ケースがテストされており、存在する理由とともに文書化されています。便利機能には SwifterSwift を、以下のケースにはこのパッケージを使ってください。両方を一緒にインポートすることもできます。

## 主な特長

- **クラッシュしない変換** — `Int(rounding:)`、`UInt8(clamping:)`、`Duration(timeInterval:)` は NaN、無限大、範囲外の値に対して `nil` を返します。`Int(_:)` や `Duration.seconds(_:)` ではこれらの値でアプリが停止します。
- **タイムアウトとリトライ** — `withTimeout` は時間がかかりすぎる処理をキャンセルします。`withRetry` はジッター付きの指数バックオフで待機し、キャンセルは決してリトライしません。また `RetryPolicy` は不正な値を補正するため、リモート設定によってループやクラッシュが起きることはありません。
- **同時実行数を制限した並列処理** — `concurrentMap(maxConcurrency:)` は入力の順序を保ち、同時に実行する変換を最大 N 個に抑え、typed throws を使います。エラーを投げない変換に `try` は不要です。
- **サイズ制限** — `collect(limit:)` と `URLSession.data(for:limit:)` は、メモリを使い切る代わりに上限で読み込みを止めます。`truncated(toUTF8ByteCount:)` は、絵文字を途中で切ることなくテキストをバイト数の予算内に収めます。
- **iOS 27** — `UIApplication.activeWindowScene` と `activeKeyWindow` は、iOS 27 で必須となるシーンのライフサイクルに向けて、非推奨の `windows` と `keyWindow` に代わるものです。`ResourceUsageAdvice` は、iOS 27 のリソース使用量を抑える設定を、低電力モードおよび iOS 18 以降のサーマルステートと組み合わせます。
- **Swift 6 strict concurrency** — すべての public な型は `Sendable` で、すべてのクロージャが分離を明示し、パッケージは Swift 6 言語モードで警告なしにビルドできます。
- **テスト済み** — macOS で README のサンプルを含む 89 個の Swift Testing テスト、iOS シミュレータで同じテストに UIKit のテストを加えたもの、そしてサンプルアプリを操作する 7 個の UI テストがあります。

## クイックスタート

**1. パッケージを追加する**

Xcode で **File › Add Package Dependencies…** を選び、右上の検索欄にリポジトリの URL を貼り付けます。

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

**Dependency Rule** は `2.0.0` からの **Up to Next Major Version** のままにして、**Add Package** をクリックします。次のウィンドウで **SwiftExtensions** の横にあるアプリのターゲットを選び、もう一度 **Add Package** をクリックします。

**2. モジュールをインポートする**

```swift
import SwiftExtensions
```

この行を、extension を使うすべての Swift ファイルの先頭に追加します。

**3. 使ってみる**

新しい Xcode アプリ（**File › New › Project… › App**）で、`ContentView.swift` の内容をすべて次のものに置き換えます。

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

**Run**（⌘R）を押します。1 行目には `-1` が表示されます。`Int(rounding:)` は NaN に対して `nil` を返しましたが、`Int(0.0 / 0.0)` ではアプリが停止していたからです。2 行目には `Grüß…` が表示されます。省略記号を含めて UTF-8 で 9 バイトです。ボタンは 3 秒かかるタスクを開始し、**Stopped after 1 second** と表示します。

## インストール

### Swift Package Manager

リポジトリの URL は `https://github.com/muhittincamdali/SwiftExtensions.git`, これを Xcode の **File › Add Package Dependencies…** に入力するか、`Package.swift` の `dependencies` に追加します。

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

### 動作要件

| | 最小バージョン |
| --- | --- |
| Swift | 6.2（Xcode 26 以降） |
| プラットフォーム | iOS 18、macOS 15、tvOS 18、watchOS 11、visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS 27 SDK（Xcode 27） |

バージョン 2.0.0 は、2026 年 2 月の 1.0.0 の API を置き換えるものです。1.0.0 は SwifterSwift の内容を多く繰り返した幅広い便利機能の集まりで、2026 年 6 月にそのソースはプレースホルダーのコードに差し替えられました。2.0.0 は、Swift 6 言語モード向けにビルドとテストを行った、新しくより小さなパッケージです。変更点は [CHANGELOG.md](CHANGELOG.md) にまとめています。

## 使い方

以下のサンプルは、テストでコンパイルされ実行されています（[`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)）。

### クラッシュしない変換

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

| 呼び出し | `nil` を返す場合 |
| --- | --- |
| `Int(rounding: x, rule)` | NaN、±無限大、丸めた値が型の範囲外 |
| `UInt8(clamping: x)` | NaN のみ。それ以外の値は `min` または `max` に収められます |
| `Duration(timeInterval: x)` | NaN、±無限大、絶対値が 2⁶³ 秒以上 |

`Duration.timeInterval` で元に戻すことができ、`Date.advanced(by: .seconds(30))` は `Duration` を受け取ります。

### タイムアウト、リトライ、並列処理

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

- `withTimeout` は、制限時間を過ぎると `TimeoutError` を投げ、処理をキャンセルします。キャンセルは協調的です。キャンセルを一度も確認しない処理がある場合、その処理が戻るまでエラーは遅れます。
- `withRetry` は `initialDelay × multiplier^(n − 1)` だけ待機します。最大は `maxDelay` で、その最大 `jitter` の割合だけ短くなります。呼び出し元の actor 上で実行され、`CancellationError` は決してリトライしません。
- `concurrentMap` は結果を `ids` の順序で返します。最初のエラーが、実行中の変換をキャンセルして投げられます。`concurrentCompactMap` と `concurrentForEach` も同じように動作します。

### サイズ制限

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

- `data(for:limit:)` は、上限を超える `Content-Length` をボディを読む前に拒否し、それ以外のボディは `limit + 1` バイト目で読み込みを止め、転送をキャンセルして `ResponseTooLargeError` を投げます。
- `collect(limit:)` と `collectData(limit:)` は、任意の `AsyncSequence` に対して同じことを行います。
- `truncated(toUTF8ByteCount:ending:)` は文字を丸ごと保ちます。25 バイトの家族の絵文字は、残されるか取り除かれるかのどちらかで、途中で切られることはありません。

### ウィンドウシーン

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

`UIApplication.shared` を渡して呼び出します。`activeWindowScene` は、フォアグラウンドでアクティブなシーンを優先し、次に非アクティブなシーン、最後にバックグラウンドのシーンを選びます。Apple の [TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle) では、iOS 27 SDK でビルドするアプリが使う必要があるシーンのライフサイクルについて解説されています。

### リソース使用量の抑制

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

`shouldReduceWork` は、低電力モードがオンのとき、サーマルステートが `serious` または `critical` のとき、または iOS 27 でシステムがリソース使用量の抑制を求めているときに `true` になります。iOS 27 の値は `@Environment(\.systemPrefersReducedResourceUsage)` またはトレイトコレクションから渡してください。[記事](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)では両方の方法を紹介しています。

## SwiftExtensions と SwifterSwift

| 目的 | このパッケージを使わない場合 | SwiftExtensions |
| --- | --- | --- |
| NaN の可能性がある `Double` から整数を得る | `Int(x)` はクラッシュする | `Int(rounding:)`、`Int(clamping:)` |
| `TimeInterval` から `Duration` を得る | `.seconds(x)` は NaN でクラッシュする | `Duration(timeInterval:)` |
| バイト数の上限内に収めたテキスト | SwifterSwift の `truncated(toLength:)` は文字数で数える | `truncated(toUTF8ByteCount:)` |
| 非同期処理のタイムアウト | 手書きの task group | `withTimeout` |
| バックオフ付きのリトライ | `Task.sleep` を使ったループ | `withRetry`、`RetryPolicy` |
| 同時実行数を制限した並列 map | 要素ごとに 1 つの task | `concurrentMap(maxConcurrency:)` |
| サイズ制限付きの非同期シーケンスやダウンロード | `Array(sequence)` や `data(for:)` はどんなサイズでも読み込む | `collect(limit:)`、`data(for:limit:)` |
| 画面上のウィンドウ | `UIApplication.shared.windows` は非推奨。SwifterSwift は今も使っている | `activeWindowScene`、`activeKeyWindow` |
| iOS 18 から 27 で処理を減らす | 3 つの API があり、うち 1 つは iOS 27 のみ | `ResourceUsageAdvice` |

[SwiftExtensions と SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift) では、このパッケージと swift-async-algorithms、swift-concurrency-extras、CollectionConcurrencyKit との比較も行っています。

## サンプルアプリ

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) は、iOS と macOS 向けの SwiftUI アプリで、extension のグループごとに 1 つの画面があります。クラッシュする値の変換、バイト数の上限で切り詰めるテキストフィールド、`withTimeout`、`withRetry`、`concurrentMap` を実行するボタン、そしてリソースのアドバイスとウィンドウシーンの状態のライブ表示です。`ExtensionsDemo.xcodeproj` を開いて **Run** を押してください。UI テストは、各画面の表示内容を iOS シミュレータで確認します。

<p align="center">
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/conversions-dark.png"><img src="docs/images/conversions-light.png" width="200" alt="ExtensionsDemo の Conversions 画面"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/truncation-dark.png"><img src="docs/images/truncation-light.png" width="200" alt="ExtensionsDemo の UTF-8 truncation 画面"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/async-dark.png"><img src="docs/images/async-light.png" width="200" alt="ExtensionsDemo の Async limits 画面と計測結果"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/system-dark.png"><img src="docs/images/system-light.png" width="200" alt="ExtensionsDemo の Scenes and resources 画面"></picture>
</p>

スクリーンショットは `scripts/capture-screens.sh` が iPhone シミュレータ上のアプリから撮影したものです。

## ドキュメント

[ドキュメント](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)ではすべての型を取り上げ、5 つの記事を用意しています。

- [はじめに](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions と SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [非同期処理に上限を設ける](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [クラッシュさせずに変換する](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [シーンのライフサイクルとリソース使用量の抑制](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## コントリビューション

すべての extension には、標準ライブラリ、Foundation、SwifterSwift ではカバーされていないという理由、境界ケースのテスト、そしてドキュメントが必要です。提案の方法は [CONTRIBUTING.md](CONTRIBUTING.md) で説明しています。セキュリティ上の問題は、[SECURITY.md](SECURITY.md) に記載の方法で報告してください。

## ライセンス

SwiftExtensions は MIT ライセンスで公開しています。詳細は [LICENSE](LICENSE) を参照してください。
