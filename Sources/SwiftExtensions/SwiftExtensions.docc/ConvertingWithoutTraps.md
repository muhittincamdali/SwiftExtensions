# Converting without traps

Turn floating-point values into integers and durations, and text into a byte budget, without a
fatal error for the values you did not expect.

## Why conversions trap

Several standard conversions stop the app instead of returning an error:

| Code                  | Stops the app for                                  |
| --------------------- | -------------------------------------------------- |
| `Int(x)`              | NaN, ±infinity, values outside `Int.min...Int.max` |
| `UInt8(x)`            | the same, for the range 0...255                    |
| `Duration.seconds(x)` | NaN, ±infinity, values too large for a duration    |

These values are easy to get: `0.0 / 0.0` is NaN, `1.0 / 0.0` is infinity, and `Double(Int.max)`
is 2⁶³, one more than `Int.max`. A server that sends `1e400` in JSON gives infinity.

## Integers from floating-point values

``Swift/BinaryInteger/init(rounding:_:)`` rounds, then returns `nil` when there is no integer of the
type for the result:

```swift
Int(rounding: 2.5)              // 3
Int(rounding: 2.5, .down)       // 2
Int(rounding: .nan)             // nil
Int(rounding: Double(Int.max))  // nil, 2⁶³ does not fit
Int8(rounding: 127.4)           // 127
Int8(rounding: 127.5)           // nil, 128 does not fit
```

``Swift/FixedWidthInteger/init(clamping:rounding:)`` holds values at the edge of the type instead
and returns `nil` only for NaN:

```swift
UInt8(clamping: 300.0)          // 255
UInt8(clamping: -2.0)           // 0
Int(clamping: Double.infinity)  // Int.max
Int(clamping: 2.9)              // 2, the fraction is dropped like Int(_:)
```

For integer sources, Swift's own `init(clamping:)` is used as before; it is not optional.

## Durations and time intervals

Swift concurrency measures time in `Duration`; Foundation, UIKit and Core Animation in
`TimeInterval`. ``Swift/Duration/timeInterval`` converts one way and
``Swift/Duration/init(timeInterval:)`` the other, returning `nil` for a value that is not finite
or whose magnitude is 2⁶³ seconds or more:

```swift
let seconds = Duration.milliseconds(1_500).timeInterval   // 1.5
let wait = Duration(timeInterval: retryAfter) ?? .seconds(5)
let deadline = Date.now.advanced(by: .seconds(30))
```

## Text within a byte limit

``Swift/StringProtocol/truncated(toUTF8ByteCount:ending:)`` keeps whole characters, so the result
is always valid text and never longer than the limit:

```swift
"Grüße 👋🏽".truncated(toUTF8ByteCount: 7)               // "Grüße"
"Grüße 👋🏽".truncated(toUTF8ByteCount: 9, ending: "…")  // "Grüß…"
```

An emoji with a skin tone or a family emoji is one character of up to 25 or more bytes; it is
kept whole or left out, never cut.
