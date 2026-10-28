#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIApplication {
    /// The window scene the user is most likely looking at.
    ///
    /// Apps built with the iOS 27 SDK must use the scene life cycle, and the old ways to find
    /// "the" window, `UIApplication.shared.keyWindow` and `UIApplication.shared.windows`, have
    /// been deprecated since iOS 13 and iOS 15 because an app can show several windows at once.
    /// This property looks at the connected scenes instead and picks, in this order, a window
    /// scene in the foreground and active, one in the foreground but inactive (for example
    /// behind Control Center), one in the background, and an unattached one. `connectedScenes`
    /// is a set, so among several scenes in the same state any one of them can be returned.
    ///
    /// When you have a view or a view controller, prefer its own `view.window?.windowScene`:
    /// with several scenes, that is the one it is shown in.
    @MainActor
    public var activeWindowScene: UIWindowScene? {
        let windowScenes = connectedScenes.compactMap { $0 as? UIWindowScene }
        return ScenePriority.preferred(among: windowScenes, state: \.activationState)
    }

    /// The key window of ``activeWindowScene``, or its first window when none is key.
    ///
    /// Use it to present an alert or a sheet from code that has no view of its own, such as a
    /// push notification handler.
    @MainActor
    public var activeKeyWindow: UIWindow? {
        guard let scene = activeWindowScene else { return nil }
        return scene.keyWindow ?? scene.windows.first
    }
}

/// Picks the scene the user most likely sees. Separate from `UIApplication` so the order can be
/// tested without connected scenes.
enum ScenePriority {
    static func rank(_ state: UIScene.ActivationState) -> Int {
        switch state {
        case .foregroundActive: 0
        case .foregroundInactive: 1
        case .background: 2
        case .unattached: 3
        @unknown default: 4
        }
    }

    static func preferred<Scene>(
        among scenes: [Scene],
        state: (Scene) -> UIScene.ActivationState
    ) -> Scene? {
        var best: (scene: Scene, rank: Int)?
        for scene in scenes {
            let rank = rank(state(scene))
            if let current = best, current.rank <= rank {
                continue
            }
            best = (scene, rank)
        }
        return best?.scene
    }
}
#endif
