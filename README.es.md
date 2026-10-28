<!-- i18n-source: README.md@c00d9955298fc27d6c0cca3e349200338c272d46 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="Estado de CI"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="Última versión: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="Plataformas compatibles: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="Versión del lenguaje: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="Licencia: MIT"></picture></a>
</p>

<p align="center">
<a href="#inicio-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-es-light.svg" alt="Empezar"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-es-light.svg" alt="Documentación"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-es-light.svg" alt="Ejemplos"></picture></a>
</p>

> Esta es una traducción del README en inglés. Si hay diferencias, la versión en inglés es la vigente.

<!-- brand:end -->

SwiftExtensions es un pequeño paquete de Swift con extensiones que la biblioteca estándar, Foundation y [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) no ofrecen: límites de tiempo, reintentos y trabajo en paralelo acotado para Swift concurrency, conversiones que devuelven `nil` donde los inicializadores del propio Swift detienen la app, límites de tamaño para descargas y texto, y utilidades para el ciclo de vida de las escenas y la preferencia de recursos reducidos de iOS 27. Funciona en iOS 18+, macOS 15+, tvOS 18+, watchOS 11+ y visionOS 2+ y no tiene dependencias.

**En qué se diferencia de SwifterSwift:** SwifterSwift es una gran colección de utilidades de conveniencia (cientos de extensiones para cadenas, colecciones, colores y UIKit). Este paquete es lo contrario: extensiones en diez áreas concretas que SwifterSwift no cubre, cada una correcta en cuanto a `Sendable` con la concurrencia estricta de Swift 6, probada en sus casos límite y documentada con el motivo por el que existe. Usa SwifterSwift para las utilidades de conveniencia y este paquete para los casos que se describen a continuación; se pueden importar juntos.

## Lo más destacado

- **Conversiones que no detienen la app** — `Int(rounding:)`, `UInt8(clamping:)` y `Duration(timeInterval:)` devuelven `nil` para NaN, infinito y valores fuera de rango, mientras que `Int(_:)` y `Duration.seconds(_:)` detienen la app.
- **Límites de tiempo y reintentos** — `withTimeout` cancela el trabajo que tarda demasiado; `withRetry` espera con retroceso exponencial y jitter, nunca reintenta una cancelación, y su `RetryPolicy` corrige los valores no válidos, de modo que una configuración remota no pueda hacerlo entrar en un bucle ni detener la app.
- **Trabajo en paralelo con límite** — `concurrentMap(maxConcurrency:)` conserva el orden de la entrada, ejecuta como máximo N transformaciones a la vez y usa typed throws: no hace falta `try` para una transformación que no puede lanzar errores.
- **Límites de tamaño** — `collect(limit:)` y `URLSession.data(for:limit:)` dejan de leer al llegar al límite en lugar de llenar la memoria; `truncated(toUTF8ByteCount:)` mantiene el texto dentro de un presupuesto de bytes sin cortar un emoji por la mitad.
- **iOS 27** — `UIApplication.activeWindowScene` y `activeKeyWindow` sustituyen a `windows` y `keyWindow`, obsoletos, para el ciclo de vida de las escenas que exige iOS 27, y `ResourceUsageAdvice` combina la preferencia de recursos reducidos de iOS 27 con el modo de bajo consumo y el estado térmico desde iOS 18.
- **Concurrencia estricta de Swift 6** — todos los tipos públicos son `Sendable`, todos los closures indican su aislamiento y el paquete compila sin advertencias en el modo de lenguaje de Swift 6.
- **Probado** — 89 pruebas con Swift Testing en macOS, incluidos los ejemplos del README; las mismas pruebas más las de UIKit en un simulador de iOS, y 7 pruebas de interfaz que manejan la app de ejemplo.

## Inicio rápido

**1. Añade el paquete**

En Xcode, elige **File › Add Package Dependencies…** y pega la URL del repositorio en el campo de búsqueda de la esquina superior derecha:

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

Deja **Dependency Rule** en **Up to Next Major Version** desde `2.0.0` y haz clic en **Add Package**. En la ventana siguiente, elige el target de tu app junto a **SwiftExtensions** y haz clic de nuevo en **Add Package**.

**2. Importa el módulo**

```swift
import SwiftExtensions
```

Pon esta línea al principio de cada archivo Swift que use las extensiones.

**3. Úsalo**

En una app nueva de Xcode (**File › New › Project… › App**), sustituye todo el contenido de `ContentView.swift` por:

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

Pulsa **Run** (⌘R). La primera línea muestra `-1`, porque `Int(rounding:)` devolvió `nil` para NaN, mientras que `Int(0.0 / 0.0)` habría detenido la app. La segunda línea muestra `Grüß…`: 9 bytes de UTF-8 con los puntos suspensivos. El botón inicia una tarea de 3 segundos y muestra **Stopped after 1 second**.

## Instalación

### Swift Package Manager

En Xcode, elige **File › Add Package Dependencies…** e introduce `https://github.com/muhittincamdali/SwiftExtensions.git`, o añádelo a las `dependencies` de tu `Package.swift`:

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

### Requisitos

| | Mínimo |
| --- | --- |
| Swift | 6.2 (Xcode 26 o posterior) |
| Plataformas | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | SDK de iOS 27 (Xcode 27) |

La versión 2.0.0 sustituye a la API de la 1.0.0 de febrero de 2026, un amplio conjunto de utilidades de conveniencia que en su mayoría repetían SwifterSwift; en junio de 2026 ese código fuente se sustituyó por código de relleno. La 2.0.0 es un paquete nuevo y más pequeño, compilado y probado para el modo de lenguaje de Swift 6. [CHANGELOG.md](CHANGELOG.md) enumera los cambios.

## Uso

Las pruebas compilan y ejecutan los ejemplos siguientes ([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### Conversiones que no detienen la app

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

| Llamada | Devuelve `nil` para |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±infinito, un valor redondeado fuera del rango del tipo |
| `UInt8(clamping: x)` | Solo NaN; los demás valores se limitan a `min` o `max` |
| `Duration(timeInterval: x)` | NaN, ±infinito, una magnitud de 2⁶³ segundos o más |

`Duration.timeInterval` convierte en sentido inverso, y `Date.advanced(by: .seconds(30))` acepta un `Duration`.

### Límites de tiempo, reintentos y trabajo en paralelo

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

- `withTimeout` lanza `TimeoutError` al cumplirse el límite y cancela la operación. La cancelación es cooperativa: una operación que nunca la comprueba retrasa el error hasta que termina.
- `withRetry` espera `initialDelay × multiplier^(n − 1)`, como máximo `maxDelay`, menos hasta `jitter` de ese valor. Se ejecuta en el actor del llamador y nunca reintenta `CancellationError`.
- `concurrentMap` devuelve los resultados en el orden de `ids`. El primer error cancela las transformaciones en curso y se lanza; `concurrentCompactMap` y `concurrentForEach` funcionan igual.

### Límites de tamaño

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

- `data(for:limit:)` rechaza un `Content-Length` superior al límite antes de leer el cuerpo, detiene cualquier otro cuerpo en el byte `limit + 1`, cancela la transferencia y lanza `ResponseTooLargeError`.
- `collect(limit:)` y `collectData(limit:)` hacen lo mismo con cualquier `AsyncSequence`.
- `truncated(toUTF8ByteCount:ending:)` conserva los caracteres completos: un emoji de familia de 25 bytes se mantiene entero o se omite, nunca se corta.

### Escenas de ventana

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

Llámalo con `UIApplication.shared`. `activeWindowScene` prefiere una escena en primer plano y activa, después una inactiva y por último una en segundo plano. La
[TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
de Apple explica el ciclo de vida de las escenas que deben usar las apps compiladas con el SDK de iOS 27.

### Uso reducido de recursos

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

`shouldReduceWork` es `true` cuando el modo de bajo consumo está activado, el estado térmico es `serious` o `critical` o, en iOS 27, el sistema prefiere un uso reducido de recursos. Pasa el valor de iOS 27 desde `@Environment(\.systemPrefersReducedResourceUsage)` o desde una trait collection; el [artículo](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources) muestra ambas formas.

## SwiftExtensions y SwifterSwift

| Necesidad | Sin este paquete | SwiftExtensions |
| --- | --- | --- |
| Un entero a partir de un `Double` que puede ser NaN | `Int(x)` detiene la app | `Int(rounding:)`, `Int(clamping:)` |
| Un `Duration` a partir de un `TimeInterval` | `.seconds(x)` detiene la app con NaN | `Duration(timeInterval:)` |
| Texto dentro de un límite de bytes | `truncated(toLength:)` de SwifterSwift cuenta caracteres | `truncated(toUTF8ByteCount:)` |
| Un límite de tiempo para trabajo asíncrono | Un task group escrito a mano | `withTimeout` |
| Reintentos con retroceso | Un bucle con `Task.sleep` | `withRetry`, `RetryPolicy` |
| Un map en paralelo con límite | Una task por elemento | `concurrentMap(maxConcurrency:)` |
| Una secuencia asíncrona o una descarga con límite de tamaño | `Array(sequence)` y `data(for:)` leen cualquier tamaño | `collect(limit:)`, `data(for:limit:)` |
| La ventana en pantalla | `UIApplication.shared.windows`, obsoleto; SwifterSwift aún lo usa | `activeWindowScene`, `activeKeyWindow` |
| Reducir el trabajo de iOS 18 a 27 | Tres API, una de ellas solo de iOS 27 | `ResourceUsageAdvice` |

[SwiftExtensions y SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
también compara el paquete con swift-async-algorithms, swift-concurrency-extras y CollectionConcurrencyKit.

## App de ejemplo

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) es una app de SwiftUI para iOS y macOS con una pantalla por cada grupo de extensiones: conversiones de valores que detienen la app, un campo de texto truncado a un límite de bytes, botones que ejecutan `withTimeout`, `withRetry` y `concurrentMap`, y el consejo de recursos y el estado de la escena de ventana en directo. Abre `ExtensionsDemo.xcodeproj` y pulsa **Run**. Sus pruebas de interfaz comprueban en un simulador de iOS lo que muestra cada pantalla.

<p align="center">
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/conversions-dark.png"><img src="docs/images/conversions-light.png" width="200" alt="La pantalla Conversions de ExtensionsDemo"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/truncation-dark.png"><img src="docs/images/truncation-light.png" width="200" alt="La pantalla UTF-8 truncation de ExtensionsDemo"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/async-dark.png"><img src="docs/images/async-light.png" width="200" alt="La pantalla Async limits de ExtensionsDemo con resultados medidos"></picture>
<picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/system-dark.png"><img src="docs/images/system-light.png" width="200" alt="La pantalla Scenes and resources de ExtensionsDemo"></picture>
</p>

Las capturas salen de la app en un simulador de iPhone y las toma `scripts/capture-screens.sh`.

## Documentación

La [documentación](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)
cubre todos los tipos y tiene cinco artículos:

- [Primeros pasos](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions y SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [Cómo acotar el trabajo asíncrono](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [Convertir sin detener la app](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [El ciclo de vida de las escenas y el uso reducido de recursos](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## Contribuir

Cada extensión necesita un motivo por el que la biblioteca estándar, Foundation y SwifterSwift no la cubren, pruebas de sus casos límite y documentación; [CONTRIBUTING.md](CONTRIBUTING.md) explica cómo proponer una. Informa de los problemas de seguridad como se describe en [SECURITY.md](SECURITY.md).

## Licencia

SwiftExtensions se publica bajo la licencia MIT. Consulta [LICENSE](LICENSE).
