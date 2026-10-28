<!-- i18n-source: README.md@3d180556cbc0c706aa68ef860bd106b3c803f68b status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/banner-light.svg" alt="SwiftExtensions: Swift 6 extensions for time limits, retries, bounded parallel work and conversions that do not trap."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/SwiftExtensions/actions/workflows/ci.yml/badge.svg" alt="Status da CI"></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-version-light.svg" alt="Versão mais recente: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-platforms-light.svg" alt="Plataformas compatíveis: iOS 18+ · macOS 15+ · tvOS 18+ · watchOS 11+ · visionOS 2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-language-light.svg" alt="Versão da linguagem: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/badge-license-light.svg" alt="Licença: MIT"></picture></a>
</p>

<p align="center">
<a href="#início-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-start-pt-BR-light.svg" alt="Começar"></picture></a>
<a href="https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-docs-pt-BR-light.svg" alt="Documentação"></picture></a>
<a href="https://github.com/muhittincamdali/SwiftExtensions/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-pt-BR-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-pt-BR-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftExtensions/main/.github/brand/button-examples-pt-BR-light.svg" alt="Exemplos"></picture></a>
</p>

> Esta é uma tradução do README em inglês. Se houver diferença, vale a versão em inglês.

<!-- brand:end -->

O SwiftExtensions é um pequeno pacote Swift com extensions que a biblioteca padrão, o Foundation e o [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) não oferecem: limites de tempo, novas tentativas e trabalho paralelo limitado para Swift concurrency, conversões que retornam `nil` onde os próprios inicializadores do Swift interrompem o app, limites de tamanho para downloads e texto, e utilitários para o ciclo de vida das cenas e a preferência de recursos reduzidos do iOS 27. Ele roda no iOS 18+, macOS 15+, tvOS 18+, watchOS 11+ e visionOS 2+ e não tem dependências.

**Como ele difere do SwifterSwift:** o SwifterSwift é uma grande coleção de utilitários de conveniência (centenas de extensions para strings, coleções, cores e UIKit). Este pacote é o oposto: extensions em dez áreas específicas que o SwifterSwift não cobre, cada uma correta quanto a `Sendable` sob a concorrência estrita do Swift 6, testada em seus casos extremos e documentada com o motivo de existir. Use o SwifterSwift para conveniência e este pacote para os casos abaixo; os dois podem ser importados juntos.

## Destaques

- **Conversões que não interrompem o app** — `Int(rounding:)`, `UInt8(clamping:)` e `Duration(timeInterval:)` retornam `nil` para NaN, infinito e valores fora do intervalo, enquanto `Int(_:)` e `Duration.seconds(_:)` interrompem o app.
- **Limites de tempo e novas tentativas** — `withTimeout` cancela o trabalho que demora demais; `withRetry` espera com backoff exponencial e jitter, nunca tenta de novo um cancelamento, e sua `RetryPolicy` corrige valores inválidos, de modo que uma configuração remota não consiga colocá-lo em loop nem interromper o app.
- **Trabalho paralelo com limite** — `concurrentMap(maxConcurrency:)` mantém a ordem da entrada, executa no máximo N transformações por vez e usa typed throws: nenhum `try` para uma transformação que não pode lançar erros.
- **Limites de tamanho** — `collect(limit:)` e `URLSession.data(for:limit:)` param de ler no limite em vez de encher a memória; `truncated(toUTF8ByteCount:)` mantém o texto dentro de um orçamento de bytes sem cortar um emoji ao meio.
- **iOS 27** — `UIApplication.activeWindowScene` e `activeKeyWindow` substituem `windows` e `keyWindow`, descontinuados, para o ciclo de vida das cenas que o iOS 27 exige, e `ResourceUsageAdvice` combina a preferência de recursos reduzidos do iOS 27 com o Modo de Pouca Energia e o estado térmico a partir do iOS 18.
- **Concorrência estrita do Swift 6** — todo tipo público é `Sendable`, toda closure declara seu isolamento e o pacote compila sem avisos no modo de linguagem Swift 6.
- **Testado** — 89 testes do Swift Testing no macOS, incluindo os exemplos do README; os mesmos testes mais os do UIKit em um simulador de iOS, e 7 testes de interface que controlam o app de exemplo.

## Início rápido

**1. Adicione o pacote**

No Xcode, escolha **File › Add Package Dependencies…** e cole a URL do repositório no campo de busca no canto superior direito:

```text
https://github.com/muhittincamdali/SwiftExtensions.git
```

Deixe **Dependency Rule** em **Up to Next Major Version** a partir de `2.0.0` e clique em **Add Package**. Na janela seguinte, escolha o target do seu app ao lado de **SwiftExtensions** e clique em **Add Package** novamente.

**2. Importe o módulo**

```swift
import SwiftExtensions
```

Coloque esta linha no topo de cada arquivo Swift que usa as extensions.

**3. Use**

Em um novo app do Xcode (**File › New › Project… › App**), substitua todo o conteúdo de `ContentView.swift` por:

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

Pressione **Run** (⌘R). A primeira linha mostra `-1`, porque `Int(rounding:)` retornou `nil` para NaN, enquanto `Int(0.0 / 0.0)` teria interrompido o app. A segunda linha mostra `Grüß…`: 9 bytes de UTF-8 com as reticências. O botão inicia uma tarefa de 3 segundos e mostra **Stopped after 1 second**.

## Instalação

### Swift Package Manager

No Xcode, escolha **File › Add Package Dependencies…** e informe `https://github.com/muhittincamdali/SwiftExtensions.git`, ou adicione-o às `dependencies` do seu `Package.swift`:

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
| Swift | 6.2 (Xcode 26 ou posterior) |
| Plataformas | iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2 |
| `ResourceUsageAdvice.current(traitCollection:)` | SDK do iOS 27 (Xcode 27) |

A versão 2.0.0 substitui a API da 1.0.0 de fevereiro de 2026, um amplo conjunto de utilitários de conveniência que em grande parte repetia o SwifterSwift; em junho de 2026, esse código-fonte foi substituído por código provisório. A 2.0.0 é um pacote novo e menor, construído e testado para o modo de linguagem Swift 6. O [CHANGELOG.md](CHANGELOG.md) lista as mudanças.

## Uso

Os exemplos abaixo são compilados e executados pelos testes ([`ReadmeSamples.swift`](Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift)).

### Conversões que não interrompem o app

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

| Chamada | Retorna `nil` para |
| --- | --- |
| `Int(rounding: x, rule)` | NaN, ±infinito, um valor arredondado fora do intervalo do tipo |
| `UInt8(clamping: x)` | Apenas NaN; os demais valores são limitados a `min` ou `max` |
| `Duration(timeInterval: x)` | NaN, ±infinito, uma magnitude de 2⁶³ segundos ou mais |

`Duration.timeInterval` converte no sentido inverso, e `Date.advanced(by: .seconds(30))` aceita uma `Duration`.

### Limites de tempo, novas tentativas e trabalho paralelo

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

- `withTimeout` lança `TimeoutError` após o limite e cancela a operação. O cancelamento é cooperativo: uma operação que nunca o verifica atrasa o erro até retornar.
- `withRetry` espera `initialDelay × multiplier^(n − 1)`, no máximo `maxDelay`, menos até `jitter` desse valor. Ele roda no actor de quem o chama e nunca tenta de novo um `CancellationError`.
- `concurrentMap` retorna os resultados na ordem de `ids`. O primeiro erro cancela as transformações em andamento e é lançado; `concurrentCompactMap` e `concurrentForEach` funcionam da mesma forma.

### Limites de tamanho

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

- `data(for:limit:)` recusa um `Content-Length` acima do limite antes de ler o corpo, interrompe qualquer outro corpo no byte `limit + 1`, cancela a transferência e lança `ResponseTooLargeError`.
- `collect(limit:)` e `collectData(limit:)` fazem o mesmo para qualquer `AsyncSequence`.
- `truncated(toUTF8ByteCount:ending:)` mantém os caracteres inteiros: um emoji de família de 25 bytes é mantido ou deixado de fora, nunca cortado.

### Cenas de janela

```swift
@MainActor
func presentSignedOutAlert(in application: UIApplication) {
    guard let root = application.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

Chame-o com `UIApplication.shared`. `activeWindowScene` prefere uma cena em primeiro plano e ativa, depois uma inativa e, por fim, uma em segundo plano. A
[TN3187](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
da Apple explica o ciclo de vida das cenas que os apps compilados com o SDK do iOS 27 devem usar.

### Uso reduzido de recursos

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

`shouldReduceWork` é `true` quando o Modo de Pouca Energia está ativado, o estado térmico é `serious` ou `critical` ou, no iOS 27, o sistema prefere o uso reduzido de recursos. Passe o valor do iOS 27 a partir de `@Environment(\.systemPrefersReducedResourceUsage)` ou de uma trait collection; o [artigo](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources) mostra as duas formas.

## SwiftExtensions e SwifterSwift

| Necessidade | Sem este pacote | SwiftExtensions |
| --- | --- | --- |
| Um inteiro a partir de um `Double` que pode ser NaN | `Int(x)` interrompe o app | `Int(rounding:)`, `Int(clamping:)` |
| Uma `Duration` a partir de um `TimeInterval` | `.seconds(x)` interrompe o app com NaN | `Duration(timeInterval:)` |
| Texto dentro de um limite de bytes | `truncated(toLength:)` do SwifterSwift conta caracteres | `truncated(toUTF8ByteCount:)` |
| Um limite de tempo para trabalho assíncrono | Um task group escrito à mão | `withTimeout` |
| Novas tentativas com backoff | Um loop com `Task.sleep` | `withRetry`, `RetryPolicy` |
| Um map paralelo com limite | Uma task por elemento | `concurrentMap(maxConcurrency:)` |
| Uma sequência assíncrona ou um download com limite de tamanho | `Array(sequence)` e `data(for:)` leem qualquer tamanho | `collect(limit:)`, `data(for:limit:)` |
| A janela na tela | `UIApplication.shared.windows`, descontinuado; o SwifterSwift ainda o usa | `activeWindowScene`, `activeKeyWindow` |
| Reduzir o trabalho do iOS 18 ao 27 | Três APIs, uma delas só do iOS 27 | `ResourceUsageAdvice` |

O artigo [SwiftExtensions e SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
também compara o pacote com swift-async-algorithms, swift-concurrency-extras e CollectionConcurrencyKit.

## App de exemplo

[`Examples/ExtensionsDemo`](Examples/ExtensionsDemo) é um app SwiftUI para iOS e macOS com uma tela por grupo de extensions: conversões de valores que interrompem o app, um campo de texto truncado em um limite de bytes, botões que executam `withTimeout`, `withRetry` e `concurrentMap`, e a recomendação de recursos e o estado da cena de janela ao vivo. Abra `ExtensionsDemo.xcodeproj` e pressione **Run**. Seus testes de interface verificam, em um simulador de iOS, o que cada tela mostra.

## Documentação

A [documentação](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/)
cobre todos os tipos e tem cinco artigos:

- [Primeiros passos](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/gettingstarted)
- [SwiftExtensions e SwifterSwift](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/comparisonwithswifterswift)
- [Como limitar o trabalho assíncrono](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/boundingasyncwork)
- [Converter sem interromper o app](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/convertingwithouttraps)
- [O ciclo de vida das cenas e o uso reduzido de recursos](https://muhittincamdali.github.io/SwiftExtensions/documentation/swiftextensions/scenelifecycleandresources)

## Como contribuir

Toda extension precisa de um motivo pelo qual a biblioteca padrão, o Foundation e o SwifterSwift não a cobrem, de testes para seus casos extremos e de documentação; o [CONTRIBUTING.md](CONTRIBUTING.md) explica como propor uma. Relate problemas de segurança conforme descrito no [SECURITY.md](SECURITY.md).

## Licença

O SwiftExtensions é publicado sob a licença MIT. Veja [LICENSE](LICENSE).
