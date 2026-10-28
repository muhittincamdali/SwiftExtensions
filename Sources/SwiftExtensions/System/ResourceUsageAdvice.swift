import Foundation

#if canImport(UIKit) && !os(watchOS)
import UIKit
#endif

/// Whether the app should scale back expensive work right now, from every signal the system
/// gives: the reduced-resource preference of iOS 27, Low Power Mode and the thermal state.
///
/// iOS 27, tvOS 27 and visionOS 27 add `systemPrefersReducedResourceUsage` (a trait in UIKit, an
/// environment value in SwiftUI): the system asks apps to defer prefetching, use lighter assets
/// and skip live effects. Earlier versions have no such flag, but Low Power Mode and a serious
/// thermal state ask for the same thing. ``shouldReduceWork`` combines all three, so one check
/// works from iOS 18 to iOS 27:
///
/// ```swift
/// if ResourceUsageAdvice.current().shouldReduceWork {
///     prefetcher.pause()
/// }
/// ```
///
/// On iOS 27 pass the system flag from a trait collection or the SwiftUI environment, see
/// ``current(systemPrefersReducedResourceUsage:)``.
public struct ResourceUsageAdvice: Sendable, Hashable {
    /// The iOS 27 preference, or `nil` where the system has none (before iOS 27, and on macOS
    /// and watchOS unless it was passed in).
    public var systemPrefersReducedResourceUsage: Bool?
    /// Whether Low Power Mode is on.
    public var isLowPowerModeEnabled: Bool
    /// The thermal state of the device.
    public var thermalState: ProcessInfo.ThermalState

    /// Creates advice from explicit values, for example in tests and previews.
    public init(
        systemPrefersReducedResourceUsage: Bool?,
        isLowPowerModeEnabled: Bool,
        thermalState: ProcessInfo.ThermalState
    ) {
        self.systemPrefersReducedResourceUsage = systemPrefersReducedResourceUsage
        self.isLowPowerModeEnabled = isLowPowerModeEnabled
        self.thermalState = thermalState
    }

    /// `true` when the system prefers reduced resource usage, Low Power Mode is on, or the
    /// thermal state is `.serious` or `.critical`.
    ///
    /// Apple's guidance for both the iOS 27 preference and the thermal state is to defer
    /// non-essential work and choose lighter paths, and not to start expensive work in response
    /// to the change itself.
    public var shouldReduceWork: Bool {
        if systemPrefersReducedResourceUsage == true || isLowPowerModeEnabled {
            return true
        }
        switch thermalState {
        case .serious, .critical:
            return true
        case .nominal, .fair:
            return false
        @unknown default:
            return true
        }
    }

    /// The advice for this moment.
    ///
    /// - Parameter systemPrefersReducedResourceUsage: The iOS 27 preference, read from
    ///   `traitCollection.systemPrefersReducedResourceUsage` in UIKit or
    ///   `@Environment(\.systemPrefersReducedResourceUsage)` in SwiftUI. Leave it `nil` before
    ///   iOS 27.
    public static func current(systemPrefersReducedResourceUsage: Bool? = nil) -> Self {
        let process = ProcessInfo.processInfo
        return ResourceUsageAdvice(
            systemPrefersReducedResourceUsage: systemPrefersReducedResourceUsage,
            isLowPowerModeEnabled: process.isLowPowerModeEnabled,
            thermalState: process.thermalState
        )
    }

    /// The current advice, followed by new advice each time Low Power Mode or the thermal state
    /// changes.
    ///
    /// The stream keeps only the latest value while nobody reads it, and stops observing when
    /// the task that reads it ends:
    ///
    /// ```swift
    /// .task {
    ///     for await advice in ResourceUsageAdvice.updates() {
    ///         reducesWork = advice.shouldReduceWork
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter systemPrefersReducedResourceUsage: The iOS 27 preference to include in each
    ///   value; see ``current(systemPrefersReducedResourceUsage:)``.
    public static func updates(
        systemPrefersReducedResourceUsage: Bool? = nil
    ) -> AsyncStream<ResourceUsageAdvice> {
        let (stream, continuation) = AsyncStream.makeStream(
            of: ResourceUsageAdvice.self,
            bufferingPolicy: .bufferingNewest(1)
        )
        continuation.yield(current(systemPrefersReducedResourceUsage: systemPrefersReducedResourceUsage))
        let center = NotificationCenter.default
        // Registered before the stream is returned, so no change after this call is missed.
        let tokens = [
            Notification.Name.NSProcessInfoPowerStateDidChange,
            ProcessInfo.thermalStateDidChangeNotification
        ].map { name in
            center.addObserver(forName: name, object: nil, queue: nil) { _ in
                continuation.yield(current(systemPrefersReducedResourceUsage: systemPrefersReducedResourceUsage))
            }
        }
        let observers = ObserverTokens(center: center, tokens: tokens)
        continuation.onTermination = { _ in
            observers.remove()
        }
        return stream
    }
}

/// Notification observer tokens that are removed together. The tokens are only read, and
/// `NotificationCenter.removeObserver(_:)` may be called from any thread.
private final class ObserverTokens: @unchecked Sendable {
    private let center: NotificationCenter
    private let tokens: [any NSObjectProtocol]

    init(center: NotificationCenter, tokens: [any NSObjectProtocol]) {
        self.center = center
        self.tokens = tokens
    }

    func remove() {
        tokens.forEach(center.removeObserver)
    }
}

// UITraitCollection.systemPrefersReducedResourceUsage is in the iOS 27 SDK, which ships with
// Swift 6.4 (Xcode 27). With an older Xcode the package builds without this method.
#if canImport(UIKit) && !os(watchOS) && compiler(>=6.4)
@available(iOS 27.0, tvOS 27.0, visionOS 27.0, *)
extension ResourceUsageAdvice {
    /// The advice for this moment, with the iOS 27 preference read from a trait collection.
    ///
    /// Call it from `viewIsAppearing(_:)` or a trait-change registration of a view controller:
    ///
    /// ```swift
    /// registerForTraitChanges([UITraitSystemPrefersReducedResourceUsage.self]) { (self: Self, _) in
    ///     self.applyAdvice(.current(traitCollection: self.traitCollection))
    /// }
    /// ```
    @MainActor
    public static func current(traitCollection: UITraitCollection) -> Self {
        current(systemPrefersReducedResourceUsage: traitCollection.systemPrefersReducedResourceUsage)
    }
}
#endif
