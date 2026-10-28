#if canImport(UIKit) && !os(watchOS)
import Testing
import UIKit
@testable import SwiftExtensions

@Suite("UIApplication.activeWindowScene")
struct ScenePriorityTests {
    private typealias State = UIScene.ActivationState

    private func pick(_ scenes: [(String, State)]) -> String? {
        ScenePriority.preferred(among: scenes, state: \.1)?.0
    }

    @Test func prefersTheActiveForegroundScene() {
        #expect(pick([("background", .background), ("active", .foregroundActive), ("inactive", .foregroundInactive)]) == "active")
    }

    @Test func fallsBackInOrder() {
        #expect(pick([("background", .background), ("inactive", .foregroundInactive)]) == "inactive")
        #expect(pick([("unattached", .unattached), ("background", .background)]) == "background")
        #expect(pick([("unattached", .unattached)]) == "unattached")
    }

    @Test func noScenesGiveNil() {
        #expect(pick([]) == nil)
    }

    @Test func amongEqualScenesTheFirstIsKept() {
        #expect(pick([("a", .foregroundActive), ("b", .foregroundActive)]) == "a")
    }

    @MainActor
    @Test func anAppWithoutConnectedScenesHasNoActiveWindow() throws {
        // The test runner has an application object, but no connected window scenes.
        let application = UIApplication.shared
        try #require(application.connectedScenes.isEmpty)
        #expect(application.activeWindowScene == nil)
        #expect(application.activeKeyWindow == nil)
    }
}
#endif
