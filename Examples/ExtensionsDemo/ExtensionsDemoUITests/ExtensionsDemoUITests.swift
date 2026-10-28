import XCTest

/// Drives the example app on an iOS simulator: each test opens one screen and checks what the
/// extensions produced on the device.
@MainActor
final class ExtensionsDemoUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    private func launch(_ screen: String? = nil) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-AppleLanguages", "(en)", "-AppleLocale", "en_US"]
        if let screen { app.launchArguments += ["-screen", screen] }
        app.launch()
        return app
    }

    func testTheListOpensEveryScreen() {
        let app = launch()
        for screen in ["conversions", "text", "async", "system"] {
            app.buttons["open-\(screen)"].tap()
            XCTAssertTrue(app.navigationBars.buttons.firstMatch.waitForExistence(timeout: 5))
            app.navigationBars.buttons.firstMatch.tap()
        }
    }

    func testConversionsReturnNilWhereTheStandardInitializersTrap() {
        let app = launch("conversions")
        let nan = app.descendants(matching: .any)["conversion-0 / 0"]
        XCTAssertTrue(nan.waitForExistence(timeout: 5))
        XCTAssertEqual(nan.label.components(separatedBy: "nil").count - 1, 3, nan.label)

        let intMax = app.descendants(matching: .any)["conversion-Double(Int.max)"]
        XCTAssertTrue(intMax.label.contains("255"), intMax.label)
    }

    func testTruncationKeepsWholeCharactersWithinTheLimit() {
        let app = launch("text")
        let result = app.staticTexts["truncation-result"]
        XCTAssertTrue(result.waitForExistence(timeout: 5))
        // 20 bytes: "Grüße " (8), the waving hand with a skin tone (8), a space and "…" (3).
        XCTAssertEqual(result.label, "Grüße 👋🏽 …")

        let stepper = app.steppers["truncation-limit"]
        for _ in 0..<4 { stepper.buttons["Decrement"].tap() }
        // 16 bytes leave 13 before the ellipsis: the 8-byte emoji no longer fits after "Grüße ".
        XCTAssertEqual(result.label, "Grüße …")
    }

    func testTimeoutStopsTheSlowTaskAfterOneSecond() {
        let app = launch("async")
        app.buttons["run-timeout"].tap()
        let result = app.staticTexts["result-timeout"]
        let finished = NSPredicate(format: "label BEGINSWITH 'TimeoutError after 1.'")
        expectation(for: finished, evaluatedWith: result)
        waitForExpectations(timeout: 5)
    }

    func testRetrySucceedsOnTheThirdAttempt() {
        let app = launch("async")
        app.buttons["run-retry"].tap()
        let result = app.staticTexts["result-retry"]
        expectation(for: NSPredicate(format: "label CONTAINS 'result: ok'"), evaluatedWith: result)
        waitForExpectations(timeout: 5)
        XCTAssertTrue(result.label.contains("attempt 3"), result.label)
        XCTAssertFalse(result.label.contains("attempt 4"), result.label)
    }

    func testConcurrentMapKeepsOrderAndTheLimit() {
        let app = launch("async")
        app.swipeUp()
        app.buttons["run-map"].tap()
        let result = app.staticTexts["result-map"]
        expectation(for: NSPredicate(format: "label CONTAINS 'peak'"), evaluatedWith: result)
        waitForExpectations(timeout: 10)
        XCTAssertTrue(result.label.hasPrefix("1 4 9 16 25 36 49 64 81 100 121 144"), result.label)
        let peak = result.label.components(separatedBy: "peak: ").last?.prefix(1)
        XCTAssertTrue(["1", "2", "3"].contains(peak.map(String.init) ?? ""), result.label)
    }

    func testTheActiveWindowSceneIsInTheForeground() {
        let app = launch("system")
        let state = app.descendants(matching: .any)["scene-state"]
        XCTAssertTrue(state.waitForExistence(timeout: 5))
        XCTAssertTrue(state.label.contains("foregroundActive"), state.label)
        XCTAssertTrue(app.descendants(matching: .any)["should-reduce-work"].exists)
    }
}
