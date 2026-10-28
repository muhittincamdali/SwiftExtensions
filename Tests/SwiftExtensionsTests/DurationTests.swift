import Foundation
import Testing
import SwiftExtensions

@Suite("Duration and TimeInterval")
struct DurationTests {
    @Test(arguments: [
        (Duration.seconds(90), 90.0),
        (.milliseconds(1_500), 1.5),
        (.milliseconds(-250), -0.25),
        (.microseconds(1), 0.000_001),
        (.zero, 0)
    ])
    func timeIntervalIsTheNumberOfSeconds(duration: Duration, seconds: Double) {
        #expect(abs(duration.timeInterval - seconds) < 1e-12)
    }

    @Test(arguments: [
        (1.5, Duration.milliseconds(1_500)),
        (-1.25, .milliseconds(-1_250)),
        (0.000_001, .microseconds(1)),
        (-0.0, .zero),
        (86_400, .seconds(86_400))
    ])
    func aFiniteIntervalBecomesADuration(seconds: Double, expected: Duration) throws {
        let duration = try #require(Duration(timeInterval: seconds))
        #expect(abs((duration - expected).timeInterval) < 1e-12)
    }

    @Test func theLargestWholeNumberOfSecondsIsKept() throws {
        // The largest Double below 2^63.
        let seconds = 9_223_372_036_854_774_784.0
        let duration = try #require(Duration(timeInterval: seconds))
        #expect(duration.components.seconds == 9_223_372_036_854_774_784)
        let negative = try #require(Duration(timeInterval: -seconds))
        #expect(negative.components.seconds == -9_223_372_036_854_774_784)
    }

    @Test(arguments: [
        Double.nan, .signalingNaN, .infinity, -.infinity,
        9_223_372_036_854_775_808.0, -9_223_372_036_854_775_808.0, -9_223_372_036_854_777_856.0, 1e300,
        -.greatestFiniteMagnitude
    ])
    func aValueWithoutADurationGivesNil(seconds: Double) {
        #expect(Duration(timeInterval: seconds) == nil)
    }

    @Test func roundTripsThroughTimeInterval() throws {
        for duration in [Duration.seconds(3), .milliseconds(17), .seconds(-42), .nanoseconds(5_000)] {
            let back = try #require(Duration(timeInterval: duration.timeInterval))
            #expect(abs((back - duration).timeInterval) < 1e-9)
        }
    }

    @Test func dateAdvancesByADuration() {
        let start = Date(timeIntervalSinceReferenceDate: 1_000)
        #expect(start.advanced(by: .seconds(30)) == Date(timeIntervalSinceReferenceDate: 1_030))
        #expect(start.advanced(by: .milliseconds(-500)) == Date(timeIntervalSinceReferenceDate: 999.5))
    }
}
