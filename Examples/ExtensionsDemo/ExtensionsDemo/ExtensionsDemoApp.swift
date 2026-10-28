import SwiftUI

@main
struct ExtensionsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            DemoRootView(initialScreen: DemoScreen.fromLaunchArguments())
        }
    }
}

/// The screens of the demo, one per group of extensions.
enum DemoScreen: String, CaseIterable, Hashable, Identifiable {
    case conversions
    case text
    case async
    case system

    var id: Self { self }

    var title: String {
        switch self {
        case .conversions: "Conversions"
        case .text: "UTF-8 truncation"
        case .async: "Async limits"
        case .system: "Scenes and resources"
        }
    }

    var subtitle: String {
        switch self {
        case .conversions: "Int(rounding:), clamping, Duration"
        case .text: "truncated(toUTF8ByteCount:ending:)"
        case .async: "withTimeout, withRetry, concurrentMap"
        case .system: "activeWindowScene, ResourceUsageAdvice"
        }
    }

    /// `-screen <name>` opens a screen at launch; the screenshot script and UI tests use it.
    static func fromLaunchArguments(_ arguments: [String] = ProcessInfo.processInfo.arguments) -> DemoScreen? {
        guard let flag = arguments.firstIndex(of: "-screen"), arguments.indices.contains(flag + 1) else {
            return nil
        }
        return DemoScreen(rawValue: arguments[flag + 1])
    }
}

struct DemoRootView: View {
    @State private var path: [DemoScreen]

    init(initialScreen: DemoScreen?) {
        _path = State(initialValue: initialScreen.map { [$0] } ?? [])
    }

    var body: some View {
        NavigationStack(path: $path) {
            List(DemoScreen.allCases) { screen in
                NavigationLink(value: screen) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(screen.title)
                        Text(screen.subtitle)
                            .font(.caption.monospaced())
                            .foregroundStyle(.secondary)
                    }
                }
                .accessibilityIdentifier("open-\(screen.rawValue)")
            }
            .navigationTitle("SwiftExtensions")
            .navigationDestination(for: DemoScreen.self) { screen in
                destination(for: screen)
                    .navigationTitle(screen.title)
            }
        }
    }

    @ViewBuilder
    private func destination(for screen: DemoScreen) -> some View {
        switch screen {
        case .conversions: ConversionsScreen()
        case .text: TruncationScreen()
        case .async: AsyncLimitsScreen()
        case .system: SystemScreen()
        }
    }
}
