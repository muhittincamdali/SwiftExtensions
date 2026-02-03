import XCTest
@testable import SwiftExtensions

final class SwiftExtensionsTests: XCTestCase {
    
    // MARK: - String Validation Tests
    
    func testEmailValidation() {
        XCTAssertTrue("user@example.com".isValidEmail)
        XCTAssertTrue("test.user+tag@domain.co.uk".isValidEmail)
        XCTAssertFalse("invalid-email".isValidEmail)
        XCTAssertFalse("@domain.com".isValidEmail)
        XCTAssertFalse("user@".isValidEmail)
    }
    
    func testURLValidation() {
        XCTAssertTrue("https://example.com".isValidURL)
        XCTAssertTrue("http://localhost:8080/path".isValidURL)
        XCTAssertFalse("not a url".isValidURL)
        XCTAssertFalse("example.com".isValidURL)
    }
    
    func testPhoneValidation() {
        XCTAssertTrue("+1-555-123-4567".isValidPhoneNumber)
        XCTAssertTrue("(555) 123-4567".isValidPhoneNumber)
        XCTAssertTrue("5551234567".isValidPhoneNumber)
    }
    
    func testNumericValidation() {
        XCTAssertTrue("12345".isNumeric)
        XCTAssertFalse("12.34".isNumeric)
        XCTAssertFalse("12abc".isNumeric)
        XCTAssertTrue("12345".isInteger)
        XCTAssertTrue("12.34".isDecimal)
    }
    
    func testAlphanumericValidation() {
        XCTAssertTrue("abc123".isAlphanumeric)
        XCTAssertFalse("abc 123".isAlphanumeric)
        XCTAssertTrue("abcDEF".isAlphabetic)
    }
    
    // MARK: - String Formatting Tests
    
    func testCaseConversion() {
        XCTAssertEqual("hello_world".camelCased, "helloWorld")
        XCTAssertEqual("helloWorld".snakeCased, "hello_world")
        XCTAssertEqual("hello world".pascalCased, "HelloWorld")
        XCTAssertEqual("HelloWorld".kebabCased, "hello-world")
    }
    
    func testTruncation() {
        XCTAssertEqual("Hello World".truncated(to: 8), "Hello...")
        XCTAssertEqual("Short".truncated(to: 10), "Short")
        XCTAssertEqual("Hello Beautiful World".truncatedMiddle(to: 15), "Hello...World")
    }
    
    func testPadding() {
        XCTAssertEqual("42".paddedLeft(to: 5, with: "0"), "00042")
        XCTAssertEqual("42".paddedRight(to: 5, with: " "), "42   ")
        XCTAssertEqual("Hi".centered(to: 6, with: "-"), "--Hi--")
    }
    
    func testSlugification() {
        XCTAssertEqual("Hello World!".slugified, "hello-world")
        XCTAssertEqual("Café au Lait".slugified, "cafe-au-lait")
    }
    
    // MARK: - String Search Tests
    
    func testContains() {
        XCTAssertTrue("Hello World".containsIgnoringCase("world"))
        XCTAssertTrue("Hello World".containsAny(of: ["Hello", "Goodbye"]))
        XCTAssertTrue("Hello World".containsAll(of: ["Hello", "World"]))
    }
    
    func testOccurrences() {
        XCTAssertEqual("Hello World World".occurrences(of: "World"), 2)
    }
    
    func testFuzzyMatch() {
        XCTAssertTrue("Hello World".fuzzyMatches("hw"))
        XCTAssertFalse("Hello World".fuzzyMatches("xyz"))
    }
    
    func testLevenshteinDistance() {
        XCTAssertEqual("kitten".levenshteinDistance(to: "sitting"), 3)
        XCTAssertEqual("hello".levenshteinDistance(to: "hello"), 0)
    }
    
    // MARK: - Array Safe Tests
    
    func testSafeSubscript() {
        let array = [1, 2, 3]
        XCTAssertEqual(array[safe: 1], 2)
        XCTAssertNil(array[safe: 10])
        XCTAssertEqual(array[safe: 10, default: 0], 0)
    }
    
    func testCircularAccess() {
        let array = [1, 2, 3]
        XCTAssertEqual(array[circular: -1], 3)
        XCTAssertEqual(array[circular: 3], 1)
    }
    
    // MARK: - Array Grouping Tests
    
    func testChunked() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.chunked(into: 2), [[1, 2], [3, 4], [5]])
    }
    
    func testGrouped() {
        let words = ["apple", "banana", "avocado"]
        let grouped = words.grouped(by: { $0.first! })
        XCTAssertEqual(grouped["a"]?.count, 2)
        XCTAssertEqual(grouped["b"]?.count, 1)
    }
    
    func testUniqued() {
        let array = [1, 2, 2, 3, 1]
        XCTAssertEqual(array.uniqued, [1, 2, 3])
    }
    
    // MARK: - Array Sorting Tests
    
    func testSortedByKeyPath() {
        struct Person { let name: String; let age: Int }
        let people = [Person(name: "Bob", age: 30), Person(name: "Alice", age: 25)]
        let sorted = people.sorted(by: \.age)
        XCTAssertEqual(sorted.first?.name, "Alice")
    }
    
    func testIsSorted() {
        XCTAssertTrue([1, 2, 3, 4, 5].isSorted)
        XCTAssertFalse([1, 3, 2].isSorted)
        XCTAssertTrue([5, 4, 3, 2, 1].isSortedDescending)
    }
    
    // MARK: - Array Math Tests
    
    func testSum() {
        XCTAssertEqual([1, 2, 3, 4, 5].sum, 15)
        XCTAssertEqual([1.5, 2.5, 3.0].sum, 7.0)
    }
    
    func testAverage() {
        XCTAssertEqual([1, 2, 3, 4, 5].average, 3.0)
        XCTAssertEqual([2.0, 4.0, 6.0].average, 4.0)
    }
    
    func testMedian() {
        XCTAssertEqual([1, 3, 5, 7, 9].median, 5.0)
        XCTAssertEqual([1, 2, 3, 4].median, 2.5)
    }
    
    // MARK: - Date Formatting Tests
    
    func testISO8601() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertTrue(date.iso8601.contains("1970"))
    }
    
    func testDateFormatted() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.formatted("yyyy"), "1970")
    }
    
    // MARK: - Date Comparison Tests
    
    func testIsToday() {
        XCTAssertTrue(Date().isToday)
        XCTAssertFalse(Date().isTomorrow)
        XCTAssertFalse(Date().isYesterday)
    }
    
    func testIsSameDay() {
        let date1 = Date()
        let date2 = Date()
        XCTAssertTrue(date1.isSameDay(as: date2))
    }
    
    func testDaysDifference() {
        let today = Date()
        let tomorrow = today.adding(days: 1)
        XCTAssertEqual(tomorrow.days(from: today), 1)
    }
    
    // MARK: - Date Components Tests
    
    func testDateComponents() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.year, 1970)
    }
    
    func testStartEndOfDay() {
        let date = Date()
        let startOfDay = date.startOfDay
        let endOfDay = date.endOfDay
        
        XCTAssertEqual(startOfDay.hour, 0)
        XCTAssertEqual(startOfDay.minute, 0)
        XCTAssertEqual(endOfDay.hour, 23)
        XCTAssertEqual(endOfDay.minute, 59)
    }
    
    // MARK: - Number Tests
    
    func testIntClamped() {
        XCTAssertEqual(15.clamped(to: 0...10), 10)
        XCTAssertEqual((-5).clamped(to: 0...10), 0)
        XCTAssertEqual(5.clamped(to: 0...10), 5)
    }
    
    func testIntOrdinal() {
        XCTAssertEqual(1.ordinalSuffix, "st")
        XCTAssertEqual(2.ordinalSuffix, "nd")
        XCTAssertEqual(3.ordinalSuffix, "rd")
        XCTAssertEqual(4.ordinalSuffix, "th")
        XCTAssertEqual(11.ordinalSuffix, "th")
        XCTAssertEqual(21.ordinalSuffix, "st")
    }
    
    func testIntProperties() {
        XCTAssertTrue(4.isEven)
        XCTAssertTrue(5.isOdd)
        XCTAssertTrue(7.isPrime)
        XCTAssertFalse(8.isPrime)
        XCTAssertEqual(5.factorial, 120)
        XCTAssertEqual(12345.digits, [1, 2, 3, 4, 5])
    }
    
    func testDoubleRounded() {
        XCTAssertEqual(3.14159.rounded(to: 2), 3.14)
        XCTAssertEqual(3.14159.rounded(to: 4), 3.1416)
    }
    
    func testDoubleLerp() {
        XCTAssertEqual(0.0.lerp(to: 100, amount: 0.5), 50.0)
    }
    
    // MARK: - Optional Tests
    
    func testOptionalOr() {
        let nilString: String? = nil
        let someString: String? = "Hello"
        
        XCTAssertEqual(nilString.or("Default"), "Default")
        XCTAssertEqual(someString.or("Default"), "Hello")
    }
    
    func testOptionalIsNil() {
        let nilValue: String? = nil
        let someValue: String? = "Hello"
        
        XCTAssertTrue(nilValue.isNil)
        XCTAssertFalse(someValue.isNil)
        XCTAssertTrue(someValue.isNotNil)
    }
    
    func testStringOptional() {
        let nilString: String? = nil
        let emptyString: String? = ""
        let validString: String? = "Hello"
        
        XCTAssertEqual(nilString.orEmpty, "")
        XCTAssertTrue(nilString.isNilOrEmpty)
        XCTAssertTrue(emptyString.isNilOrEmpty)
        XCTAssertFalse(validString.isNilOrEmpty)
    }
    
    // MARK: - Dictionary Tests
    
    func testDictionaryMerged() {
        let dict1 = ["a": 1, "b": 2]
        let dict2 = ["b": 3, "c": 4]
        let merged = dict1.merged(with: dict2)
        
        XCTAssertEqual(merged["a"], 1)
        XCTAssertEqual(merged["b"], 3)
        XCTAssertEqual(merged["c"], 4)
    }
    
    func testDictionaryMapKeys() {
        let dict = ["a": 1, "b": 2]
        let mapped = dict.mapKeys { $0.uppercased() }
        
        XCTAssertEqual(mapped["A"], 1)
        XCTAssertEqual(mapped["B"], 2)
    }
    
    func testDictionaryInverted() {
        let dict = ["a": 1, "b": 2]
        let inverted = dict.inverted()
        
        XCTAssertEqual(inverted[1], "a")
        XCTAssertEqual(inverted[2], "b")
    }
    
    // MARK: - Collection Tests
    
    func testCollectionSafeSubscript() {
        let array = [1, 2, 3]
        XCTAssertEqual(array[safe: 0], 1)
        XCTAssertNil(array[safe: 5])
    }
    
    // MARK: - URL Tests
    
    func testURLQueryParameters() {
        let url = URL(string: "https://example.com?name=John&age=30")!
        
        XCTAssertEqual(url.queryParameter("name"), "John")
        XCTAssertEqual(url.queryParameter("age"), "30")
        XCTAssertEqual(url.queryParameterInt("age"), 30)
    }
    
    func testURLAppendingQueryParameter() {
        let url = URL(string: "https://example.com")!
        let modified = url.appendingQueryParameter("key", value: "value")
        
        XCTAssertEqual(modified.queryParameter("key"), "value")
    }
    
    func testURLComponents() {
        let url = URL(string: "https://example.com/path/to/resource")!
        
        XCTAssertEqual(url.pathSegments, ["path", "to", "resource"])
        XCTAssertEqual(url.lastPathSegment, "resource")
    }
    
    func testURLValidation() {
        let httpURL = URL(string: "http://example.com")!
        let httpsURL = URL(string: "https://example.com")!
        let fileURL = URL(fileURLWithPath: "/tmp/test.txt")
        
        XCTAssertTrue(httpURL.isHTTP)
        XCTAssertTrue(httpsURL.isHTTPS)
        XCTAssertTrue(httpsURL.isWebURL)
        XCTAssertTrue(fileURL.isFileScheme)
    }
    
    // MARK: - Data Tests
    
    func testDataHexEncoding() {
        let data = Data([0x48, 0x65, 0x6C, 0x6C, 0x6F])
        XCTAssertEqual(data.hexString, "48656c6c6f")
        
        let decoded = Data(hexString: "48656c6c6f")
        XCTAssertEqual(decoded, data)
    }
    
    func testDataBase64() {
        let data = "Hello".data(using: .utf8)!
        let base64 = data.base64String
        let decoded = Data(base64String: base64)
        
        XCTAssertNotNil(decoded)
        XCTAssertEqual(String(data: decoded!, encoding: .utf8), "Hello")
    }
    
    func testDataJSON() {
        let json = "{\"name\":\"John\",\"age\":30}".data(using: .utf8)!
        
        XCTAssertTrue(json.isValidJSON)
        XCTAssertEqual(json.jsonString(at: "name"), "John")
        XCTAssertEqual(json.jsonInt(at: "age"), 30)
    }
    
    // MARK: - Codable Tests
    
    func testCodableJSON() throws {
        struct Person: Codable, Equatable {
            let name: String
            let age: Int
        }
        
        let person = Person(name: "John", age: 30)
        let jsonData = try person.jsonData()
        let decoded = try Person.from(jsonData: jsonData)
        
        XCTAssertEqual(person, decoded)
    }
    
    func testCodableJSONString() throws {
        struct Item: Codable {
            let id: Int
            let title: String
        }
        
        let item = Item(id: 1, title: "Test")
        let jsonString = try item.jsonString()
        
        XCTAssertTrue(jsonString.contains("\"id\":1"))
        XCTAssertTrue(jsonString.contains("\"title\":\"Test\""))
    }
    
    // MARK: - Bundle Tests
    
    func testBundleAppInfo() {
        let version = Bundle.main.appVersion
        let buildNumber = Bundle.main.buildNumber
        
        // These will be empty in test bundle, just verify they don't crash
        XCTAssertNotNil(version)
        XCTAssertNotNil(buildNumber)
    }
    
    // MARK: - FileManager Tests
    
    func testFileManagerDirectories() {
        let fm = FileManager.default
        
        XCTAssertNotNil(fm.documentsDirectory)
        XCTAssertNotNil(fm.cachesDirectory)
        XCTAssertNotNil(fm.tempDirectory)
    }
}

// MARK: - Performance Tests

extension SwiftExtensionsTests {
    
    func testArraySortingPerformance() {
        let largeArray = (0..<10000).map { _ in Int.random(in: 0...1000) }
        
        measure {
            _ = largeArray.sorted()
        }
    }
    
    func testStringSearchPerformance() {
        let longString = String(repeating: "Hello World ", count: 1000)
        
        measure {
            _ = longString.occurrences(of: "World")
        }
    }
}
