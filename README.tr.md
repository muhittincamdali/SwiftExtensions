<!-- i18n-source: README.md@efa531e5a15c1c169094fd2912cff4214a3c7e45 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="CI durumu"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="Son sürüm: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="Desteklenen platformlar: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="Dil sürümü: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="Lisans: MIT"></picture></a>
</p>

<p align="center">
<a href="#hızlı-başlangıç"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-tr-light.svg" alt="Başlayın"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-tr-light.svg" alt="Dokümantasyon"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-tr-light.svg" alt="Örnekler"></picture></a>
</p>

> Bu belge İngilizce README'nin çevirisidir. İkisi arasında fark varsa güncel olan İngilizce sürümdür.

<!-- brand:end -->

SwiftExtensions, standart kütüphanenin, Foundation'ın ve [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)'in sunmadığı extension'lardan oluşan küçük bir Swift paketidir: Swift concurrency için zaman sınırları, yeniden denemeler ve sınırlı paralel iş, Swift'in kendi initializer'larının uygulamayı durdurduğu yerde `nil` döndüren dönüşümler, indirmeler ve metinler için boyut sınırları ve iOS 27'deki sahne yaşam döngüsü ile azaltılmış kaynak kullanımı tercihi için yardımcılar. iOS 18+, macOS 15+, tvOS 18+, watchOS 11+ ve visionOS 2+ üzerinde çalışır ve hiçbir bağımlılığı yoktur.

**SwifterSwift'ten farkı:** SwifterSwift, kolay kullanım sağlayan geniş bir koleksiyondur (string'ler, koleksiyonlar, renkler ve UIKit için yüzlerce extension). Bu paket ise tam tersidir: SwifterSwift'in hiçbirini kapsamadığı on dar alanda extension'lar sunar. Her biri Swift 6 strict concurrency altında `Sendable` açısından doğrudur, uç durumlarında test edilmiştir ve neden var olduğuyla birlikte belgelenmiştir. Kolay kullanım işlevleri için SwifterSwift'i, aşağıdaki durumlar için bu paketi kullanın; ikisi birlikte içe aktarılabilir.

## Öne çıkanlar

- **Uygulamayı durdurmayan dönüşümler** — `Int(rounding:)`, `UInt8(clamping:)` ve `Duration(timeInterval:)`, NaN, sonsuz ve aralık dışı değerler için `nil` döndürür; `Int(_:)` ve `Duration.seconds(_:)` ise bu durumlarda uygulamayı durdurur.
- **Zaman sınırları ve yeniden denemeler** — `withTimeout` çok uzun süren işi iptal eder; `withRetry` jitter ile üstel olarak geri çekilir, iptali asla yeniden denemez ve `RetryPolicy` geçersiz değerleri düzeltir, böylece uzaktan yapılandırma onu döngüye sokamaz veya uygulamayı durduramaz.
- **Sınırlı paralel iş** — `concurrentMap(maxConcurrency:)` girdinin sırasını korur, aynı anda en fazla N dönüşüm çalıştırır ve typed throws kullanır: hata fırlatamayan bir dönüşüm için `try` gerekmez.
- **Boyut sınırları** — `collect(limit:)` ve `URLSession.data(for:limit:)` belleği doldurmak yerine sınırda okumayı bırakır; `truncated(toUTF8ByteCount:)` metni bir emojiyi ortadan kesmeden bayt bütçesi içinde tutar.
- **iOS 27** — `UIApplication.activeWindowScene` ve `activeKeyWindow`, iOS 27'nin zorunlu kıldığı sahne yaşam döngüsü için kullanımdan kalkmış `windows` ve `keyWindow`'un yerini alır; `ResourceUsageAdvice` ise iOS 27'deki azaltılmış kaynak kullanımı tercihini Düşük Güç Modu ve iOS 18'den itibaren termal durumla birleştirir.
- **Swift 6 strict concurrency** — her public tür `Sendable`'dır, her closure izolasyonunu belirtir ve paket Swift 6 dil modunda uyarısız derlenir.
- **Test edilmiş** — macOS'ta README örnekleri dahil 85 Swift Testing testi, bir iOS simülatöründe aynı testler ile UIKit testleri ve örnek uygulamayı süren 7 UI testi.

## Hızlı başlangıç

**1. Paketi ekleyin**

Xcode'da **File › Add Package Dependencies…** menüsünü seçin ve depo adresini sağ üstteki arama alanına yapıştırın:

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

**Dependency Rule** seçeneğini `2.0.0` sürümünden itibaren **Up to Next Major Version** olarak bırakın ve **Add Package**'a tıklayın. Açılan pencerede **SwiftExtensions** yanından uygulama hedefinizi seçin ve yeniden **Add Package**'a tıklayın.

**2. Modülü içe aktarın**

```swift
import SwiftExtensions
```

Bu satırı, extension'ları kullanan her Swift dosyasının en üstüne ekleyin.

**3. Kullanın**

Yeni bir Xcode uygulamasında (**File › New › Project… › App**) `ContentView.swift` dosyasının tüm içeriğini şununla değiştirin:

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

**Run**'a (⌘R) basın. İlk satır `-1` gösterir, çünkü `Int(rounding:)` NaN için `nil` döndürdü; `Int(0.0 / 0.0)` ise uygulamayı durdurmuş olurdu. İkinci satır `Grüß…` gösterir: üç noktayla birlikte 9 bayt UTF-8. Düğme 3 saniyelik bir görev başlatır ve **Stopped after 1 second** yazısını gösterir.

## Kurulum

### Swift Package Manager

Xcode'da **File › Add Package Dependencies…** menüsünü seçin ve şu adresi girin: `https://github.com/muhittincamdali/SwiftExtensions.git`, ya da `Package.swift` dosyanızdaki `dependencies` listesine ekleyin:

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

### Gereksinimler

| | En düşük sürüm |
| --- | --- |
| Swift | 6.2 (Xcode 26 veya üstü) |
| Platformlar | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS 27 SDK (Xcode 27) |

2.0.0 sürümü, Şubat 2026'daki 1.0.0 API'sinin yerini alır; o API, çoğunlukla SwifterSwift'i tekrar eden geniş bir kolaylık kümesiydi ve Haziran 2026'da bu kaynaklar yer tutucu kodla değiştirilmişti. 2.0.0, Swift 6 dil modu için derlenmiş ve test edilmiş yeni, daha küçük bir pakettir. Değişiklikler [CHANGELOG.md](CHANGELOG.md) dosyasında listelenir.

## Kullanım

Aşağıdaki örnekler testler tarafından derlenir ve çalıştırılır ([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### Uygulamayı durdurmayan dönüşümler

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

| Çağrı | Şunlar için `nil` döndürür |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±sonsuz, türün dışında kalan yuvarlanmış değer |
| `UInt8(clamping: x)` | Yalnızca NaN; diğer değerler `min` veya `max` değerinde tutulur |
| `Duration(timeInterval: x)` | NaN, ±sonsuz, büyüklüğü 2⁶³ saniye veya daha fazla olan değer |

`Duration.timeInterval` ters yönde dönüştürür ve `Date.advanced(by: .seconds(30))` bir `Duration` alır.

### Zaman sınırları, yeniden denemeler ve paralel iş

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

- `withTimeout`, sınırdan sonra `TimeoutError` fırlatır ve işlemi iptal eder. İptal işbirliğine dayanır: iptali hiç denetlemeyen bir işlem geri dönene kadar hata da gecikir.
- `withRetry`, `initialDelay × multiplier^(n − 1)` kadar bekler; bu süre en fazla `maxDelay` olur ve en çok `jitter` oranında kısaltılır. Çağıranın actor'ünde çalışır ve `CancellationError`'ı asla yeniden denemez.
- `concurrentMap`, sonuçları `ids` sırasıyla döndürür. İlk hata çalışan dönüşümleri iptal eder ve fırlatılır; `concurrentCompactMap` ve `concurrentForEach` da aynı şekilde çalışır.

### Boyut sınırları

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

- `data(for:limit:)`, sınırı aşan bir `Content-Length` değerini gövdeyi okumadan önce reddeder, diğer her gövdeyi `limit + 1` numaralı baytta keser, aktarımı iptal eder ve `ResponseTooLargeError` fırlatır.
- `collect(limit:)` ve `collectData(limit:)` aynısını herhangi bir `AsyncSequence` için yapar.
- `truncated(toUTF8ByteCount:ending:)` bütün karakterleri korur: 25 baytlık bir aile emojisi ya tamamen tutulur ya da dışarıda bırakılır, asla ortadan kesilmez.

### Pencere sahneleri

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

`UIApplication.shared` ile çağırın. `activeWindowScene` önce ön plandaki ve etkin sahneyi, sonra etkin olmayanı, sonra arka plandakini tercih eder. Apple'ın
[TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
belgesi, iOS 27 SDK'sıyla derlenen uygulamaların kullanması gereken sahne yaşam döngüsünü açıklar.

### Azaltılmış kaynak kullanımı

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

`shouldReduceWork`, Düşük Güç Modu açıkken, termal durum `serious` veya `critical` olduğunda ya da iOS 27'de sistem azaltılmış kaynak kullanımını tercih ettiğinde `true` olur. iOS 27 değerini `@Environment(\.systemPrefersReducedResourceUsage)` ya da bir trait collection üzerinden iletin; [makale](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources) ikisini de gösterir.

## SwiftExtensions ve SwifterSwift

| İhtiyaç | Bu paket olmadan | SwiftExtensions |
| --- | --- | --- |
| NaN olabilecek bir `Double`'dan tamsayı | `Int(x)` uygulamayı durdurur | `Int(rounding:)`, `Int(clamping:)` |
| Bir `TimeInterval`'dan `Duration` | `.seconds(x)` NaN için durdurur | `Duration(timeInterval:)` |
| Bayt sınırı içinde metin | SwifterSwift'in `truncated(toLength:)` işlevi karakter sayar | `truncated(toUTF8ByteCount:)` |
| Async iş için zaman sınırı | Elle yazılmış bir task group | `withTimeout` |
| Geri çekilmeli yeniden denemeler | `Task.sleep` içeren bir döngü | `withRetry`, `RetryPolicy` |
| Sınırlı paralel map | Eleman başına bir task | `concurrentMap(maxConcurrency:)` |
| Boyut sınırlı async sequence veya indirme | `Array(sequence)`, `data(for:)` her boyutu okur | `collect(limit:)`, `data(for:limit:)` |
| Ekrandaki pencere | `UIApplication.shared.windows` kullanımdan kalkmıştır; SwifterSwift hâlâ kullanır | `activeWindowScene`, `activeKeyWindow` |
| iOS 18'den 27'ye işi azaltma | Üç API, biri yalnızca iOS 27'de | `ResourceUsageAdvice` |

[SwiftExtensions ve SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
makalesi paketi ayrıca swift-async-algorithms, swift-concurrency-extras ve CollectionConcurrencyKit ile karşılaştırır.

## Örnek uygulama

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo), her extension grubu için bir ekran içeren, iOS ve macOS için bir SwiftUI uygulamasıdır: uygulamayı durduran değerlerin dönüşümleri, bayt sınırına göre kısaltılan bir metin alanı, `withTimeout`, `withRetry` ve `concurrentMap` çalıştıran düğmeler ile canlı kaynak önerisi ve pencere sahnesi durumu. `ExtensionsDemo.xcodeproj` dosyasını açın ve **Run**'a basın. UI testleri, her ekranın ne gösterdiğini bir iOS simülatöründe denetler.

## Dokümantasyon

[Dokümantasyon](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)
her türü kapsar ve beş makale içerir:

- [Başlarken](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions ve SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [Async işi sınırlamak](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [Uygulamayı durdurmadan dönüştürmek](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [Sahne yaşam döngüsü ve azaltılmış kaynak kullanımı](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## Katkıda bulunma

Her extension'ın standart kütüphanenin, Foundation'ın ve SwifterSwift'in karşılamadığı bir gerekçesi, uç durumlar için testleri ve dokümantasyonu olmalıdır; nasıl öneri yapılacağı [CONTRIBUTING.md](CONTRIBUTING.md) dosyasında anlatılır. Güvenlik açıklarını [SECURITY.md](SECURITY.md) dosyasında anlatıldığı gibi bildirin.

## Lisans

SwiftExtensions, MIT lisansıyla yayımlanmıştır. Ayrıntılar için [LICENSE](LICENSE) dosyasına bakın.
