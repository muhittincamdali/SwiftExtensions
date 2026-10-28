<!-- i18n-source: README.md@c00d9955298fc27d6c0cca3e349200338c272d46 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="CI-Status"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="Aktuelle Version: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="Unterstützte Plattformen: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="Sprachversion: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="Lizenz: MIT"></picture></a>
</p>

<p align="center">
<a href="#schnellstart"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-de-light.svg" alt="Loslegen"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-de-light.svg" alt="Dokumentation"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-de-light.svg" alt="Beispiele"></picture></a>
</p>

> Dies ist eine Übersetzung der englischen README. Bei Abweichungen gilt die englische Fassung.

<!-- brand:end -->

SwiftExtensions ist ein kleines Swift-Paket mit Extensions, die die Standardbibliothek, Foundation und [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) nicht bieten: Zeitlimits, Wiederholungsversuche und begrenzte parallele Arbeit für Swift concurrency, Konvertierungen, die `nil` zurückgeben, wo die Initializer von Swift selbst die App anhalten, Größenlimits für Downloads und Text sowie Helfer für den Szenen-Lebenszyklus und die Einstellung für reduzierten Ressourcenverbrauch von iOS 27. Es läuft auf iOS 18+, macOS 15+, tvOS 18+, watchOS 11+ und visionOS 2+ und hat keine Abhängigkeiten.

**Unterschied zu SwifterSwift:** SwifterSwift ist eine große Sammlung von Komfortfunktionen (Hunderte von Extensions für Strings, Collections, Farben und UIKit). Dieses Paket ist das Gegenteil: Extensions in zehn eng umrissenen Bereichen, die SwifterSwift nicht abdeckt. Jede ist unter der strikten Concurrency von Swift 6 in Bezug auf `Sendable` korrekt, an ihren Grenzfällen getestet und mit dem Grund dokumentiert, warum es sie gibt. Nutze SwifterSwift für Komfortfunktionen und dieses Paket für die unten beschriebenen Fälle; beide lassen sich zusammen importieren.

## Highlights

- **Konvertierungen, die die App nicht anhalten** — `Int(rounding:)`, `UInt8(clamping:)` und `Duration(timeInterval:)` geben bei NaN, Unendlich und Werten außerhalb des Bereichs `nil` zurück, während `Int(_:)` und `Duration.seconds(_:)` die App anhalten.
- **Zeitlimits und Wiederholungsversuche** — `withTimeout` bricht Arbeit ab, die zu lange läuft; `withRetry` wartet mit exponentiellem Backoff und Jitter, wiederholt eine Abbruchanforderung nie, und seine `RetryPolicy` korrigiert ungültige Werte, damit eine Remote-Konfiguration keine Endlosschleife und keinen Absturz auslösen kann.
- **Parallele Arbeit mit Limit** — `concurrentMap(maxConcurrency:)` behält die Reihenfolge der Eingabe bei, führt höchstens N Transformationen gleichzeitig aus und nutzt typed throws: Für eine Transformation, die keinen Fehler werfen kann, ist kein `try` nötig.
- **Größenlimits** — `collect(limit:)` und `URLSession.data(for:limit:)` hören am Limit auf zu lesen, statt den Speicher zu füllen; `truncated(toUTF8ByteCount:)` hält Text innerhalb eines Byte-Budgets, ohne ein Emoji in der Mitte zu zerschneiden.
- **iOS 27** — `UIApplication.activeWindowScene` und `activeKeyWindow` ersetzen die veralteten `windows` und `keyWindow` für den Szenen-Lebenszyklus, den iOS 27 verlangt, und `ResourceUsageAdvice` verbindet die Einstellung für reduzierten Ressourcenverbrauch von iOS 27 mit dem Stromsparmodus und dem thermischen Zustand ab iOS 18.
- **Strikte Concurrency von Swift 6** — jeder öffentliche Typ ist `Sendable`, jede Closure gibt ihre Isolation an, und das Paket baut im Sprachmodus von Swift 6 ohne Warnungen.
- **Getestet** — 89 Swift-Testing-Tests auf macOS, einschließlich der README-Beispiele, dieselben Tests plus die UIKit-Tests auf einem iOS-Simulator und 7 UI-Tests, die die Beispiel-App bedienen.

## Schnellstart

**1. Paket hinzufügen**

Wähle in Xcode **File › Add Package Dependencies…** und füge die Repository-URL oben rechts in das Suchfeld ein:

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

Lass **Dependency Rule** ab `2.0.0` auf **Up to Next Major Version** stehen und klicke auf **Add Package**. Wähle im nächsten Fenster neben **SwiftExtensions** dein App-Target aus und klicke erneut auf **Add Package**.

**2. Modul importieren**

```swift
import SwiftExtensions
```

Setze diese Zeile an den Anfang jeder Swift-Datei, die die Extensions verwendet.

**3. Verwenden**

Ersetze in einer neuen Xcode-App (**File › New › Project… › App**) den gesamten Inhalt von `ContentView.swift` durch:

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

Drücke **Run** (⌘R). Die erste Zeile zeigt `-1`, weil `Int(rounding:)` für NaN `nil` zurückgegeben hat, wo `Int(0.0 / 0.0)` die App angehalten hätte. Die zweite Zeile zeigt `Grüß…`: 9 Bytes UTF-8 mit der Ellipse. Der Button startet eine Aufgabe von 3 Sekunden und zeigt **Stopped after 1 second**.

## Installation

### Swift Package Manager

Wähle in Xcode **File › Add Package Dependencies…** und gib diese URL ein: `https://github.com/muhittincamdali/SwiftExtensions.git`, oder füge es in deiner `Package.swift` zu den `dependencies` hinzu:

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

### Voraussetzungen

| | Mindestversion |
| --- | --- |
| Swift | 6.2 (Xcode 26 oder neuer) |
| Plattformen | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS-27-SDK (Xcode 27) |

Version 2.0.0 ersetzt die API von 1.0.0 aus dem Februar 2026, einer breiten Sammlung von Komfortfunktionen, die größtenteils SwifterSwift wiederholte; im Juni 2026 wurden diese Quellen durch Platzhaltercode ersetzt. 2.0.0 ist ein neues, kleineres Paket, das für den Sprachmodus von Swift 6 gebaut und getestet wurde. [CHANGELOG.md](CHANGELOG.md) listet die Änderungen auf.

## Verwendung

Die folgenden Beispiele werden von den Tests kompiliert und ausgeführt ([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### Konvertierungen, die die App nicht anhalten

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

| Aufruf | Gibt `nil` zurück bei |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±Unendlich, einem gerundeten Wert außerhalb des Typs |
| `UInt8(clamping: x)` | Nur NaN; andere Werte werden auf `min` oder `max` begrenzt |
| `Duration(timeInterval: x)` | NaN, ±Unendlich, einem Betrag von 2⁶³ Sekunden oder mehr |

`Duration.timeInterval` rechnet zurück, und `Date.advanced(by: .seconds(30))` nimmt eine `Duration` entgegen.

### Zeitlimits, Wiederholungsversuche und parallele Arbeit

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

- `withTimeout` wirft nach Ablauf des Limits `TimeoutError` und bricht die Operation ab. Der Abbruch ist kooperativ: Eine Operation, die ihn nie prüft, verzögert den Fehler, bis sie zurückkehrt.
- `withRetry` wartet `initialDelay × multiplier^(n − 1)`, höchstens `maxDelay`, abzüglich bis zu `jitter` davon. Es läuft auf dem Actor des Aufrufers und wiederholt `CancellationError` nie.
- `concurrentMap` gibt die Ergebnisse in der Reihenfolge von `ids` zurück. Der erste Fehler bricht die laufenden Transformationen ab und wird geworfen; `concurrentCompactMap` und `concurrentForEach` funktionieren genauso.

### Größenlimits

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

- `data(for:limit:)` weist einen `Content-Length` über dem Limit zurück, bevor es den Body liest, hört bei jedem anderen Body bei Byte `limit + 1` auf, bricht die Übertragung ab und wirft `ResponseTooLargeError`.
- `collect(limit:)` und `collectData(limit:)` tun dasselbe für jede `AsyncSequence`.
- `truncated(toUTF8ByteCount:ending:)` behält ganze Zeichen bei: Ein Familien-Emoji mit 25 Bytes bleibt entweder erhalten oder fällt weg, es wird nie zerschnitten.

### Fensterszenen

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

Rufe es mit `UIApplication.shared` auf. `activeWindowScene` bevorzugt eine Szene im Vordergrund und aktiv, dann eine inaktive, dann eine im Hintergrund. Apples
[TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
erklärt den Szenen-Lebenszyklus, den Apps verwenden müssen, die mit dem iOS-27-SDK gebaut werden.

### Reduzierter Ressourcenverbrauch

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

`shouldReduceWork` ist `true`, wenn der Stromsparmodus eingeschaltet ist, der thermische Zustand `serious` oder `critical` ist oder, unter iOS 27, das System reduzierten Ressourcenverbrauch bevorzugt. Übergib den Wert von iOS 27 aus `@Environment(\.systemPrefersReducedResourceUsage)` oder aus einer Trait Collection; der [Artikel](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources) zeigt beides.

## SwiftExtensions und SwifterSwift

| Bedarf | Ohne dieses Paket | SwiftExtensions |
| --- | --- | --- |
| Ganzzahl aus einem `Double`, der NaN sein kann | `Int(x)` hält die App an | `Int(rounding:)`, `Int(clamping:)` |
| `Duration` aus einem `TimeInterval` | `.seconds(x)` hält bei NaN die App an | `Duration(timeInterval:)` |
| Text innerhalb eines Byte-Limits | `truncated(toLength:)` von SwifterSwift zählt Zeichen | `truncated(toUTF8ByteCount:)` |
| Ein Zeitlimit für asynchrone Arbeit | Eine von Hand geschriebene Task Group | `withTimeout` |
| Wiederholungsversuche mit Backoff | Eine Schleife mit `Task.sleep` | `withRetry`, `RetryPolicy` |
| Paralleles Map mit Limit | Ein Task pro Element | `concurrentMap(maxConcurrency:)` |
| Asynchrone Sequenz oder Download mit Größenlimit | `Array(sequence)` und `data(for:)` lesen jede Größe | `collect(limit:)`, `data(for:limit:)` |
| Das Fenster auf dem Bildschirm | `UIApplication.shared.windows`, veraltet; SwifterSwift nutzt es noch | `activeWindowScene`, `activeKeyWindow` |
| Arbeit von iOS 18 bis 27 reduzieren | Drei APIs, eine davon nur für iOS 27 | `ResourceUsageAdvice` |

[SwiftExtensions und SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
vergleicht das Paket außerdem mit swift-async-algorithms, swift-concurrency-extras und CollectionConcurrencyKit.

## Beispiel-App

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) ist eine SwiftUI-App für iOS und macOS mit je einem Bildschirm pro Gruppe von Extensions: Konvertierungen von Werten, die die App anhalten, ein Textfeld, das auf ein Byte-Limit gekürzt wird, Buttons, die `withTimeout`, `withRetry` und `concurrentMap` ausführen, sowie die Live-Anzeige der Ressourcenempfehlung und des Zustands der Fensterszene. Öffne `ExtensionsDemo.xcodeproj` und drücke **Run**. Die UI-Tests prüfen auf einem iOS-Simulator, was jeder Bildschirm zeigt.

<p align="center">
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/conversions-dark.png"><img src="docs/images/conversions-light.png" width="200" alt="Der Bildschirm Conversions von ExtensionsDemo"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/truncation-dark.png"><img src="docs/images/truncation-light.png" width="200" alt="Der Bildschirm UTF-8 truncation von ExtensionsDemo"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/async-dark.png"><img src="docs/images/async-light.png" width="200" alt="Der Bildschirm Async limits von ExtensionsDemo mit gemessenen Ergebnissen"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/system-dark.png"><img src="docs/images/system-light.png" width="200" alt="Der Bildschirm Scenes and resources von ExtensionsDemo"></picture>
</p>

Die Bildschirmfotos stammen aus der App auf einem iPhone-Simulator, aufgenommen von `scripts/capture-screens.sh`.

## Dokumentation

Die [Dokumentation](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)
behandelt jeden Typ und enthält fünf Artikel:

- [Erste Schritte](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions und SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [Asynchrone Arbeit begrenzen](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [Konvertieren ohne Abstürze](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [Der Szenen-Lebenszyklus und reduzierter Ressourcenverbrauch](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## Mitwirken

Jede Extension braucht einen Grund, warum die Standardbibliothek, Foundation und SwifterSwift sie nicht abdecken, Tests für ihre Grenzfälle und Dokumentation; [CONTRIBUTING.md](CONTRIBUTING.md) erklärt, wie du eine vorschlägst. Melde Sicherheitsprobleme wie in [SECURITY.md](SECURITY.md) beschrieben.

## Lizenz

SwiftExtensions ist unter der MIT-Lizenz veröffentlicht. Siehe [LICENSE](LICENSE).
