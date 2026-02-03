import XCTest
@testable import SwiftExtensions

final class StringTests: XCTestCase {

    // MARK: - Validation

    func testValidEmail() {
        XCTAssertTrue("user@example.com".isValidEmail)
        XCTAssertTrue("test.user+tag@domain.co.uk".isValidEmail)
        XCTAssertFalse("not-an-email".isValidEmail)
        XCTAssertFalse("@missing.com".isValidEmail)
        XCTAssertFalse("user@".isValidEmail)
    }

    func testValidURL() {
        XCTAssertTrue("https://apple.com".isValidURL)
        XCTAssertTrue("http://localhost:8080/path".isValidURL)
        XCTAssertFalse("not a url".isValidURL)
        XCTAssertFalse("".isValidURL)
    }

    func testValidPhone() {
        XCTAssertTrue("+1234567890".isValidPhone)
        XCTAssertTrue("(123) 456-7890".isValidPhone)
        XCTAssertFalse("abc".isValidPhone)
        XCTAssertFalse("12".isValidPhone)
    }

    func testValidIPv4() {
        XCTAssertTrue("192.168.1.1".isValidIPv4)
        XCTAssertTrue("0.0.0.0".isValidIPv4)
        XCTAssertFalse("256.1.1.1".isValidIPv4)
        XCTAssertFalse("1.2.3".isValidIPv4)
    }

    func testIsAlphanumeric() {
        XCTAssertTrue("abc123".isAlphanumeric)
        XCTAssertFalse("abc 123".isAlphanumeric)
        XCTAssertFalse("".isAlphanumeric)
    }

    func testIsBlank() {
        XCTAssertTrue("".isBlank)
        XCTAssertTrue("   ".isBlank)
        XCTAssertTrue("\n\t".isBlank)
        XCTAssertFalse("hello".isBlank)
    }

    func testContainsOnlyLetters() {
        XCTAssertTrue("hello".containsOnlyLetters)
        XCTAssertFalse("hello1".containsOnlyLetters)
        XCTAssertFalse("".containsOnlyLetters)
    }

    func testContainsOnlyDigits() {
        XCTAssertTrue("12345".containsOnlyDigits)
        XCTAssertFalse("123a".containsOnlyDigits)
    }

    // MARK: - Formatting

    func testCamelCased() {
        XCTAssertEqual("hello world".camelCased, "helloWorld")
        XCTAssertEqual("some-variable".camelCased, "someVariable")
        XCTAssertEqual("snake_case".camelCased, "snakeCase")
    }

    func testSnakeCased() {
        XCTAssertEqual("helloWorld".snakeCased, "hello_world")
        XCTAssertEqual("Hello World".snakeCased, "hello_world")
    }

    func testTitleCased() {
        XCTAssertEqual("hello world".titleCased, "Hello World")
        XCTAssertEqual("swift extensions".titleCased, "Swift Extensions")
    }

    func testSlugified() {
        XCTAssertEqual("Hello World!".slugified, "hello-world")
        XCTAssertEqual("Swift Extensions 2.0".slugified, "swift-extensions-20")
    }

    func testTruncated() {
        XCTAssertEqual("Hello World".truncated(to: 5), "Hello...")
        XCTAssertEqual("Hi".truncated(to: 10), "Hi")
        XCTAssertEqual("Long text".truncated(to: 4, trailing: "…"), "Long…")
    }

    func testTrimmed() {
        XCTAssertEqual("  hello  ".trimmed, "hello")
        XCTAssertEqual("\nhello\n".trimmed, "hello")
    }

    func testPadded() {
        XCTAssertEqual("42".padded(toLength: 5, with: "0"), "00042")
        XCTAssertEqual("hello".padded(toLength: 3), "hello")
    }

    // MARK: - Crypto

    func testMD5() {
        XCTAssertEqual("hello".md5, "5d41402abc4b2a76b9719d911017c592")
        XCTAssertEqual("".md5, "d41d8cd98f00b204e9800998ecf8427e")
    }

    func testSHA256() {
        XCTAssertEqual(
            "hello".sha256,
            "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"
        )
    }
}
