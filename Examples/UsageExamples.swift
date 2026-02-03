// UsageExamples.swift
// SwiftExtensions Examples
//
// Demonstrates common extension usage patterns

import Foundation
import SwiftExtensions

// MARK: - String Extension Examples

func stringExamples() {
    // Validation
    let email = "user@example.com"
    if email.isValidEmail {
        print("Valid email!")
    }
    
    let url = "https://github.com"
    if url.isValidURL {
        print("Valid URL!")
    }
    
    // Manipulation
    let longText = "This is a very long text that needs to be truncated"
    print(longText.truncated(to: 20)) // "This is a very long..."
    
    let camelCase = "myVariableName"
    print(camelCase.snakeCased) // "my_variable_name"
    
    // Word operations
    let sentence = "Hello World Swift Extensions"
    print(sentence.words) // ["Hello", "World", "Swift", "Extensions"]
    print(sentence.wordCount) // 4
    
    // Encoding
    let htmlString = "&lt;div&gt;Hello&lt;/div&gt;"
    print(htmlString.htmlDecoded) // "<div>Hello</div>"
    
    let urlString = "Hello World"
    print(urlString.urlEncoded ?? "") // "Hello%20World"
    
    // Regular expressions
    let text = "Contact: 123-456-7890"
    let phones = text.matches(pattern: #"\d{3}-\d{3}-\d{4}"#)
    print(phones) // ["123-456-7890"]
}

// MARK: - Array Extension Examples

func arrayExamples() {
    let numbers = [1, 2, 3, 4, 5]
    
    // Safe subscript (no crash on invalid index)
    print(numbers[safe: 10] ?? "nil") // nil
    print(numbers[safe: 2] ?? "nil") // 3
    
    // Convenience accessors
    print(numbers.second ?? 0) // 2
    print(numbers.third ?? 0) // 3
    print(numbers.last(3)) // [3, 4, 5]
    print(numbers.first(3)) // [1, 2, 3]
    
    // Unique elements
    let duplicates = [1, 1, 2, 2, 3, 3, 3]
    print(duplicates.unique()) // [1, 2, 3]
    
    // Chunking
    let items = [1, 2, 3, 4, 5, 6, 7]
    print(items.chunked(into: 3)) // [[1, 2, 3], [4, 5, 6], [7]]
    
    // Grouping
    struct Person {
        let name: String
        let age: Int
    }
    
    let people = [
        Person(name: "Alice", age: 25),
        Person(name: "Bob", age: 30),
        Person(name: "Charlie", age: 25)
    ]
    
    let grouped = people.grouped(by: \.age)
    // [25: [Alice, Charlie], 30: [Bob]]
    
    // Filtering
    let adults = people.filter(where: \.age, greaterThan: 20)
    
    // Sorting
    let sorted = people.sorted(by: \.name)
    let sortedDesc = people.sorted(by: \.age, ascending: false)
}

// MARK: - Date Extension Examples

func dateExamples() {
    let now = Date()
    
    // Date checks
    print("Is today: \(now.isToday)")
    print("Is weekend: \(now.isWeekend)")
    print("Is weekday: \(now.isWeekday)")
    
    // Date components
    print("Start of day: \(now.startOfDay)")
    print("End of day: \(now.endOfDay)")
    print("Start of week: \(now.startOfWeek)")
    print("Start of month: \(now.startOfMonth)")
    
    // Date manipulation
    let tomorrow = now.adding(1, to: .day)
    let nextWeek = now.adding(1, to: .weekOfYear)
    let nextMonth = now.adding(1, to: .month)
    
    // Date formatting
    print(now.formatted(as: "yyyy-MM-dd")) // "2026-02-06"
    print(now.formatted(as: "EEEE, MMMM d")) // "Thursday, February 6"
    
    // Relative time
    let fiveMinutesAgo = now.adding(-5, to: .minute)
    print(fiveMinutesAgo.timeAgo) // "5 minutes ago"
    
    let yesterday = now.adding(-1, to: .day)
    print(yesterday.timeAgo) // "yesterday"
    
    // Date comparison
    let futureDate = now.adding(1, to: .day)
    print(now < futureDate) // true
    print(now.isSameDay(as: now.startOfDay)) // true
}

// MARK: - Optional Extension Examples

func optionalExamples() {
    let name: String? = nil
    let age: Int? = 25
    
    // Default values
    print(name.or("Unknown")) // "Unknown"
    print(age.or(0)) // 25
    
    // Nil checks
    if name.isNil {
        print("Name is nil")
    }
    
    if age.isNotNil {
        print("Age is not nil")
    }
    
    // Filter
    let filteredAge = age.filter { $0 >= 18 }
    print(filteredAge ?? 0) // 25
    
    // Map with default
    let description = name.map { "Hello, \($0)" } ?? "Hello, Guest"
}

// MARK: - Collection Extension Examples

func collectionExamples() {
    let items = [1, 2, 3, 4, 5]
    
    // Empty check
    if items.isNotEmpty {
        print("Has items!")
    }
    
    // Count with condition
    let evenCount = items.count(where: { $0 % 2 == 0 })
    print("Even numbers: \(evenCount)") // 2
    
    // Sum
    let sum = items.sum()
    print("Sum: \(sum)") // 15
    
    // Average
    let average = items.average()
    print("Average: \(average)") // 3.0
    
    // Dictionary operations
    let dict = ["a": 1, "b": 2, "c": 3]
    let keys = dict.keys(where: { $0 > 1 })
    print(keys) // ["b", "c"]
}

// MARK: - UIKit Extension Examples

#if canImport(UIKit)
import UIKit

func uiKitExamples() {
    // UIColor from hex
    let color = UIColor(hex: "#FF5733")
    let colorWithAlpha = UIColor(hex: "#FF5733", alpha: 0.8)
    
    // Color manipulation
    let lighter = color?.lighter(by: 20)
    let darker = color?.darker(by: 20)
    
    // Random color
    let random = UIColor.random
    
    // UIView extensions
    let view = UIView()
    
    // Add multiple subviews
    let label = UILabel()
    let button = UIButton()
    view.addSubviews(label, button)
    
    // Corner radius
    view.roundCorners([.topLeft, .topRight], radius: 12)
    
    // Shadow
    view.addShadow(
        color: .black,
        opacity: 0.3,
        offset: CGSize(width: 0, height: 2),
        radius: 8
    )
    
    // Border
    view.addBorder(color: .gray, width: 1)
    
    // Gradient
    view.addGradient(
        colors: [.blue, .purple],
        startPoint: CGPoint(x: 0, y: 0),
        endPoint: CGPoint(x: 1, y: 1)
    )
}
#endif

// MARK: - Foundation Extension Examples

func foundationExamples() {
    // Bundle
    let appVersion = Bundle.main.appVersion
    let buildNumber = Bundle.main.buildNumber
    print("Version: \(appVersion) (\(buildNumber))")
    
    // FileManager
    let documentsURL = FileManager.documentsDirectory
    let cachesURL = FileManager.cachesDirectory
    
    // UserDefaults
    UserDefaults.standard[key: "username"] = "JohnDoe"
    let username: String? = UserDefaults.standard[key: "username"]
    
    // Data
    let string = "Hello, World!"
    if let data = string.data(using: .utf8) {
        print("Base64: \(data.base64EncodedString())")
        print("Hex: \(data.hexString)")
    }
    
    // URL
    let url = URL(string: "https://api.example.com/users")!
    let withQuery = url.appendingQueryParameters(["page": "1", "limit": "10"])
    print(withQuery?.absoluteString ?? "")
    // "https://api.example.com/users?page=1&limit=10"
}

// MARK: - Main Entry

@main
struct ExamplesApp {
    static func main() {
        print("=== String Examples ===")
        stringExamples()
        
        print("\n=== Array Examples ===")
        arrayExamples()
        
        print("\n=== Date Examples ===")
        dateExamples()
        
        print("\n=== Optional Examples ===")
        optionalExamples()
        
        print("\n=== Collection Examples ===")
        collectionExamples()
        
        print("\n=== Foundation Examples ===")
        foundationExamples()
    }
}
