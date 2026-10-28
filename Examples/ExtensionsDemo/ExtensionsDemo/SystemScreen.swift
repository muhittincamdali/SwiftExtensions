import SwiftExtensions
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// Shows the active window scene and the resource-usage advice, live.
struct SystemScreen: View {
    @State private var advice = ResourceUsageAdvice.current()
    @State private var sceneState = "–"
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        List {
            Section("ResourceUsageAdvice") {
                LabeledContent("System preference (iOS 27)", value: systemPreference)
                LabeledContent("Low Power Mode", value: advice.isLowPowerModeEnabled ? "on" : "off")
                LabeledContent("Thermal state", value: thermalName)
                LabeledContent("shouldReduceWork", value: advice.shouldReduceWork ? "true" : "false")
                    .accessibilityIdentifier("should-reduce-work")
            }
            #if os(iOS)
            Section("UIApplication.activeWindowScene") {
                LabeledContent("Activation state", value: sceneState)
                    .accessibilityIdentifier("scene-state")
            }
            #endif
        }
        .modifier(SystemPreferenceReader(advice: $advice))
        // The scene is still inactive while the app launches, so read it again on every change.
        .onChange(of: scenePhase, initial: true) { readScene() }
    }

    private var systemPreference: String {
        advice.systemPrefersReducedResourceUsage.map { $0 ? "reduce" : "normal" } ?? "not available"
    }

    private var thermalName: String {
        switch advice.thermalState {
        case .nominal: "nominal"
        case .fair: "fair"
        case .serious: "serious"
        case .critical: "critical"
        @unknown default: "unknown"
        }
    }

    private func readScene() {
        #if os(iOS)
        let state = UIApplication.shared.activeWindowScene?.activationState
        sceneState = switch state {
        case .foregroundActive: "foregroundActive"
        case .foregroundInactive: "foregroundInactive"
        case .background: "background"
        case .unattached: "unattached"
        case nil: "no window scene"
        @unknown default: "unknown"
        }
        #endif
    }
}

/// Keeps the advice current: the power and thermal updates on every version, and on iOS 27 the
/// system preference from the SwiftUI environment.
private struct SystemPreferenceReader: ViewModifier {
    @Binding var advice: ResourceUsageAdvice

    func body(content: Content) -> some View {
        #if compiler(>=6.4)
        if #available(iOS 27, macOS 27, *) {
            content.modifier(EnvironmentPreference(advice: $advice))
        } else {
            content.task { await follow(systemPreference: nil) }
        }
        #else
        content.task { await follow(systemPreference: nil) }
        #endif
    }

    private func follow(systemPreference: Bool?) async {
        for await next in ResourceUsageAdvice.updates(systemPrefersReducedResourceUsage: systemPreference) {
            advice = next
        }
    }
}

#if compiler(>=6.4)
@available(iOS 27, macOS 27, *)
private struct EnvironmentPreference: ViewModifier {
    @Binding var advice: ResourceUsageAdvice
    @Environment(\.systemPrefersReducedResourceUsage) private var systemPrefersLess

    func body(content: Content) -> some View {
        content.task(id: systemPrefersLess) {
            for await next in ResourceUsageAdvice.updates(systemPrefersReducedResourceUsage: systemPrefersLess) {
                advice = next
            }
        }
    }
}
#endif
