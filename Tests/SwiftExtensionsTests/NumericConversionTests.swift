import Testing
import SwiftExtensions

@Suite("Int(rounding:)")
struct RoundingTests {
    @Test(arguments: [
        (2.5, 3), (-2.5, -3), (2.4, 2), (-0.4, 0), (0, 0), (1e15, 1_000_000_000_000_000)
    ])
    func roundsHalvesAwayFromZero(value: Double, expected: Int) {
        #expect(Int(rounding: value) == expected)
    }

    @Test func followsTheRoundingRule() {
        #expect(Int(rounding: 2.9, .down) == 2)
        #expect(Int(rounding: -2.1, .down) == -3)
        #expect(Int(rounding: 2.1, .up) == 3)
        #expect(Int(rounding: 2.5, .toNearestOrEven) == 2)
        #expect(Int(rounding: -2.9, .towardZero) == -2)
    }

    @Test(arguments: [Double.nan, .infinity, -.infinity, 9_223_372_036_854_775_808.0, -1e19])
    func givesNilInsteadOfTrapping(value: Double) {
        #expect(Int(rounding: value) == nil)
    }

    @Test func theEdgesOfSmallTypesAreExact() {
        #expect(Int8(rounding: 127.4) == 127)
        #expect(Int8(rounding: 127.5) == nil)
        #expect(Int8(rounding: -128.4) == -128)
        #expect(Int8(rounding: -128.5) == nil)
        #expect(UInt(rounding: -0.4) == 0)
        #expect(UInt(rounding: -0.6) == nil)
    }

    @Test func acceptsEveryFloatingPointType() {
        #expect(Int(rounding: Float(3.6)) == 4)
        #expect(Int64(rounding: Float.greatestFiniteMagnitude) == nil)
        #if !(os(macOS) && arch(x86_64))
        #expect(Int(rounding: Float16(-7.5)) == -8)
        #endif
    }

    @Test func doubleOfIntMaxDoesNotFit() {
        // Double(Int.max) rounds up to 2^63, one more than Int.max.
        #expect(Int(rounding: Double(Int.max)) == nil)
        #expect(Int(rounding: Double(Int.min)) == Int.min)
    }
}

@Suite("Int(clamping:)")
struct ClampingTests {
    @Test(arguments: [
        (300.0, 255), (-2.0, 0), (254.9, 254), (.infinity, 255), (-.infinity, 0)
    ] as [(Double, UInt8)])
    func holdsValuesAtTheEdgesOfTheType(value: Double, expected: UInt8) {
        #expect(UInt8(clamping: value) == expected)
    }

    @Test func nanHasNoNearestInteger() {
        #expect(Int(clamping: Double.nan) == nil)
        #expect(UInt8(clamping: Float.nan) == nil)
    }

    @Test func dropsTheFractionUnlessToldOtherwise() {
        #expect(Int(clamping: 2.9) == 2)
        #expect(Int(clamping: -2.9) == -2)
        #expect(Int(clamping: 2.1, rounding: .up) == 3)
        #expect(Int(clamping: 2.5, rounding: .toNearestOrAwayFromZero) == 3)
    }

    @Test func largeDoublesBecomeMaxAndMin() {
        #expect(Int(clamping: Double.greatestFiniteMagnitude) == Int.max)
        #expect(Int(clamping: -Double.greatestFiniteMagnitude) == Int.min)
        #expect(Int(clamping: Double(Int.max)) == Int.max)
        #expect(Int32(clamping: 1e10) == Int32.max)
    }

    @Test func integerSourcesStillUseTheStandardLibrary() {
        // The standard library's init(clamping:) for integers is not optional; this extension
        // must not take its place.
        let fromLiteral: Int8 = Int8(clamping: 1_000)
        let fromInteger: UInt8 = UInt8(clamping: -5 as Int)
        #expect(fromLiteral == 127)
        #expect(fromInteger == 0)
    }
}
