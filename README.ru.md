<!-- i18n-source: README.md@9cc89ccba8326d3257d4c5e7d318393687d889da status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="Статус CI"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="Последняя версия: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="Поддерживаемые платформы: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="Версия языка: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="Лицензия: MIT"></picture></a>
</p>

<p align="center">
<a href="#быстрый-старт"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-ru-light.svg" alt="Начать"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-ru-light.svg" alt="Документация"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-ru-light.svg" alt="Примеры"></picture></a>
</p>

> Это перевод README на английском языке. Если они расходятся, актуальна английская версия.

<!-- brand:end -->

SwiftExtensions — небольшой Swift-пакет с extension, которых нет в стандартной библиотеке, Foundation и [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift): ограничения по времени, повторные попытки и параллельная работа с ограниченным числом задач для Swift concurrency, преобразования, которые возвращают `nil` там, где собственные инициализаторы Swift останавливают приложение, ограничения размера для загрузок и текста, а также помощники для жизненного цикла сцен и настройки сокращённого потребления ресурсов в iOS 27. Пакет работает на iOS 18+, macOS 15+, tvOS 18+, watchOS 11+ и visionOS 2+ и не имеет зависимостей.

**Чем он отличается от SwifterSwift:** SwifterSwift — это большая коллекция удобных функций (сотни extension для строк, коллекций, цветов и UIKit). Этот пакет — наоборот: extension в десяти узких областях, которые SwifterSwift не покрывает. Каждый из них корректен с точки зрения `Sendable` при строгой конкурентности Swift 6, протестирован на граничных случаях и снабжён документацией с объяснением, зачем он нужен. Используйте SwifterSwift для удобных функций, а этот пакет — для случаев, описанных ниже; оба можно импортировать вместе.

## Основные возможности

- **Преобразования, которые не останавливают приложение** — `Int(rounding:)`, `UInt8(clamping:)` и `Duration(timeInterval:)` возвращают `nil` для NaN, бесконечности и значений вне диапазона, тогда как `Int(_:)` и `Duration.seconds(_:)` останавливают приложение.
- **Ограничения по времени и повторные попытки** — `withTimeout` отменяет слишком долгую работу; `withRetry` ждёт с экспоненциальной задержкой и джиттером, никогда не повторяет отменённую операцию, а его `RetryPolicy` исправляет недопустимые значения, поэтому удалённая конфигурация не может заставить его зациклиться или остановить приложение.
- **Параллельная работа с ограничением** — `concurrentMap(maxConcurrency:)` сохраняет порядок входных данных, выполняет не более N преобразований одновременно и использует typed throws: для преобразования, которое не может выбросить ошибку, `try` не нужен.
- **Ограничения размера** — `collect(limit:)` и `URLSession.data(for:limit:)` прекращают чтение на лимите, а не заполняют память; `truncated(toUTF8ByteCount:)` удерживает текст в пределах бюджета байтов, не разрезая эмодзи пополам.
- **iOS 27** — `UIApplication.activeWindowScene` и `activeKeyWindow` заменяют устаревшие `windows` и `keyWindow` для жизненного цикла сцен, который требуется в iOS 27, а `ResourceUsageAdvice` объединяет настройку сокращённого потребления ресурсов из iOS 27 с режимом энергосбережения и тепловым состоянием начиная с iOS 18.
- **Строгая конкурентность Swift 6** — каждый публичный тип — `Sendable`, каждое замыкание указывает свою изоляцию, а пакет собирается без предупреждений в языковом режиме Swift 6.
- **Протестировано** — 89 тестов Swift Testing на macOS, включая примеры из README; те же тесты плюс тесты UIKit на симуляторе iOS и 7 UI-тестов, управляющих примером приложения.

## Быстрый старт

**1. Добавьте пакет**

В Xcode выберите **File › Add Package Dependencies…** и вставьте адрес репозитория в поле поиска вверху справа:

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

Оставьте **Dependency Rule** равным **Up to Next Major Version** начиная с `2.0.0` и нажмите **Add Package**. В следующем окне выберите таргет вашего приложения рядом с **SwiftExtensions** и снова нажмите **Add Package**.

**2. Импортируйте модуль**

```swift
import SwiftExtensions
```

Добавьте эту строку в начало каждого Swift-файла, который использует extension.

**3. Используйте**

В новом приложении Xcode (**File › New › Project… › App**) замените всё содержимое `ContentView.swift` на:

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

Нажмите **Run** (⌘R). Первая строка показывает `-1`, потому что `Int(rounding:)` вернул `nil` для NaN, тогда как `Int(0.0 / 0.0)` остановил бы приложение. Вторая строка показывает `Grüß…` — 9 байт UTF-8 вместе с многоточием. Кнопка запускает задачу на 3 секунды и показывает **Stopped after 1 second**.

## Установка

### Swift Package Manager

Адрес репозитория — `https://github.com/muhittincamdali/SwiftExtensions.git`, введите его в Xcode через **File › Add Package Dependencies…** либо добавьте пакет в `dependencies` вашего `Package.swift`:

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

### Требования

| | Минимум |
| --- | --- |
| Swift | 6.2 (Xcode 26 или новее) |
| Платформы | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | iOS 27 SDK (Xcode 27) |

Версия 2.0.0 заменяет API версии 1.0.0 от февраля 2026 года — широкий набор удобных функций, который в основном повторял SwifterSwift; в июне 2026 года эти исходники были заменены кодом-заглушкой. 2.0.0 — это новый, более компактный пакет, собранный и протестированный для языкового режима Swift 6. Изменения перечислены в [CHANGELOG.md](CHANGELOG.md).

## Использование

Приведённые ниже примеры компилируются и выполняются тестами ([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### Преобразования, которые не останавливают приложение

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

| Вызов | Возвращает `nil` для |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±бесконечности, округлённого значения вне диапазона типа |
| `UInt8(clamping: x)` | Только NaN; остальные значения ограничиваются `min` или `max` |
| `Duration(timeInterval: x)` | NaN, ±бесконечности, величины от 2⁶³ секунд и больше |

`Duration.timeInterval` преобразует обратно, а `Date.advanced(by: .seconds(30))` принимает `Duration`.

### Ограничения по времени, повторные попытки и параллельная работа

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

- `withTimeout` выбрасывает `TimeoutError` по истечении лимита и отменяет операцию. Отмена кооперативная: операция, которая никогда её не проверяет, откладывает ошибку до своего завершения.
- `withRetry` ждёт `initialDelay × multiplier^(n − 1)`, но не более `maxDelay`, за вычетом доли до `jitter`. Он выполняется на actor вызывающего кода и никогда не повторяет `CancellationError`.
- `concurrentMap` возвращает результаты в порядке `ids`. Первая ошибка отменяет выполняющиеся преобразования и выбрасывается; `concurrentCompactMap` и `concurrentForEach` работают так же.

### Ограничения размера

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

- `data(for:limit:)` отклоняет `Content-Length` выше лимита ещё до чтения тела, любое другое тело останавливает на байте `limit + 1`, отменяет передачу и выбрасывает `ResponseTooLargeError`.
- `collect(limit:)` и `collectData(limit:)` делают то же для любой `AsyncSequence`.
- `truncated(toUTF8ByteCount:ending:)` сохраняет символы целиком: 25-байтовый эмодзи семьи либо остаётся, либо отбрасывается, но никогда не обрезается.

### Сцены окон

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

Вызывайте её с `UIApplication.shared`. `activeWindowScene` отдаёт предпочтение сцене на переднем плане и активной, затем неактивной, затем находящейся в фоне. Заметка Apple
[TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
объясняет жизненный цикл сцен, который обязаны использовать приложения, собранные с iOS 27 SDK.

### Сокращённое потребление ресурсов

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

`shouldReduceWork` равно `true`, когда включён режим энергосбережения, тепловое состояние — `serious` или `critical` или, в iOS 27, система предпочитает сокращённое потребление ресурсов. Передавайте значение iOS 27 из `@Environment(\.systemPrefersReducedResourceUsage)` или из trait collection; [статья](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources) показывает оба способа.

## SwiftExtensions и SwifterSwift

| Задача | Без этого пакета | SwiftExtensions |
| --- | --- | --- |
| Целое число из `Double`, который может быть NaN | `Int(x)` останавливает приложение | `Int(rounding:)`, `Int(clamping:)` |
| `Duration` из `TimeInterval` | `.seconds(x)` останавливает приложение при NaN | `Duration(timeInterval:)` |
| Текст в пределах лимита байтов | `truncated(toLength:)` из SwifterSwift считает символы | `truncated(toUTF8ByteCount:)` |
| Ограничение по времени для асинхронной работы | Вручную написанная task group | `withTimeout` |
| Повторные попытки с экспоненциальной задержкой | Цикл с `Task.sleep` | `withRetry`, `RetryPolicy` |
| Параллельный map с ограничением | Одна task на элемент | `concurrentMap(maxConcurrency:)` |
| Асинхронная последовательность или загрузка с ограничением размера | `Array(sequence)` и `data(for:)` читают данные любого размера | `collect(limit:)`, `data(for:limit:)` |
| Окно на экране | `UIApplication.shared.windows` устарело; SwifterSwift его всё ещё использует | `activeWindowScene`, `activeKeyWindow` |
| Сократить работу с iOS 18 по 27 | Три API, один из них только для iOS 27 | `ResourceUsageAdvice` |

Статья [SwiftExtensions и SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
также сравнивает пакет с swift-async-algorithms, swift-concurrency-extras и CollectionConcurrencyKit.

## Пример приложения

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) — приложение SwiftUI для iOS и macOS с отдельным экраном для каждой группы extension: преобразования значений, которые останавливают приложение, текстовое поле, обрезаемое до лимита байтов, кнопки, запускающие `withTimeout`, `withRetry` и `concurrentMap`, а также актуальная рекомендация по ресурсам и состояние сцены окна. Откройте `ExtensionsDemo.xcodeproj` и нажмите **Run**. Его UI-тесты проверяют на симуляторе iOS, что показывает каждый экран.

<p align="center">
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/conversions-dark.png"><img src="docs/images/conversions-light.png" width="200" alt="Экран Conversions в ExtensionsDemo"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/truncation-dark.png"><img src="docs/images/truncation-light.png" width="200" alt="Экран UTF-8 truncation в ExtensionsDemo"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/async-dark.png"><img src="docs/images/async-light.png" width="200" alt="Экран Async limits в ExtensionsDemo с измеренными результатами"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/system-dark.png"><img src="docs/images/system-light.png" width="200" alt="Экран Scenes and resources в ExtensionsDemo"></picture>
</p>

Снимки экрана сделаны скриптом `scripts/capture-screens.sh` с приложения на симуляторе iPhone.

## Документация

[Документация](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)
охватывает каждый тип и содержит пять статей:

- [Начало работы](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions и SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [Ограничение асинхронной работы](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [Преобразования без остановки приложения](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [Жизненный цикл сцен и сокращённое потребление ресурсов](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## Участие в разработке

Каждый extension должен иметь обоснование (чего не покрывают стандартная библиотека, Foundation и SwifterSwift), тесты граничных случаев и документацию; как предложить новый, объясняет [CONTRIBUTING.md](CONTRIBUTING.md). О проблемах безопасности сообщайте так, как описано в [SECURITY.md](SECURITY.md).

## Лицензия

SwiftExtensions распространяется по лицензии MIT. Подробнее — в файле [LICENSE](LICENSE).
