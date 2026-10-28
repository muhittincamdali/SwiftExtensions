# The scene life cycle and reduced resource usage

Find the window scene the user sees without the deprecated window APIs, and scale back work when
iOS 27, Low Power Mode or the device temperature ask for it.

## Windows in the scene life cycle

Apple's technote [TN3187: Migrating to the UIKit scene-based life cycle](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
states that from the next major release after iOS 26 on, the UIScene life cycle is required
when building with the latest SDK. In such an
app there is no single window: each scene has its own, and `UIApplication.shared.keyWindow`
(deprecated in iOS 13) and `UIApplication.shared.windows` (deprecated in iOS 15) do not say which
one the user is looking at.

``UIKit/UIApplication/activeWindowScene`` picks a connected window scene in this order: in the
foreground and active, in the foreground but inactive, in the background, unattached.
``UIKit/UIApplication/activeKeyWindow`` is that scene's key window:

```swift
@MainActor
func presentSessionExpiredAlert() {
    guard let root = UIApplication.shared.activeKeyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: "Signed out", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    root.present(alert, animated: true)
}
```

When code has a view or a view controller, its own `view.window?.windowScene` is the better
answer: with two scenes side by side on iPad, that is the scene it belongs to.

Both properties are members of `UIApplication` and never read `UIApplication.shared` themselves,
so the package can be linked into app extensions, where `shared` is unavailable.

## Reduced resource usage

iOS 27, tvOS 27 and visionOS 27 add `systemPrefersReducedResourceUsage`, a UIKit trait and a
SwiftUI environment value. When it is `true`, Apple asks apps to defer prefetching, choose lighter
assets and simplify live effects, and not to start expensive work in response to the change.

Earlier versions have no such flag, but Low Power Mode and a `serious` or `critical` thermal
state ask for the same thing. ``ResourceUsageAdvice`` combines the three:

```swift
struct GalleryView: View {
    @State private var advice = ResourceUsageAdvice.current()

    var body: some View {
        Gallery(prefetches: !advice.shouldReduceWork)
            .task {
                for await next in ResourceUsageAdvice.updates() {
                    advice = next
                }
            }
    }
}
```

On iOS 27, pass the system flag in. In SwiftUI it comes from the environment:

```swift
@available(iOS 27, *)
struct EffectsView: View {
    @Environment(\.systemPrefersReducedResourceUsage) private var systemPrefersLess

    var body: some View {
        let advice = ResourceUsageAdvice.current(systemPrefersReducedResourceUsage: systemPrefersLess)
        LiveEffect(enabled: !advice.shouldReduceWork)
    }
}
```

In UIKit, ``ResourceUsageAdvice/current(traitCollection:)`` reads the trait of a view or view
controller.

``ResourceUsageAdvice/updates(systemPrefersReducedResourceUsage:)`` keeps only the newest value
while nobody reads it and stops observing when the reading task ends, so a burst of power or
thermal notifications cannot fill a buffer.
