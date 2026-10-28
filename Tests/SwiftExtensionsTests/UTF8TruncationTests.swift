import Foundation
import Testing
import SwiftExtensions

@Suite("truncated(toUTF8ByteCount:)")
struct UTF8TruncationTests {
    // Precomposed letters: "ü" and "ß" take two bytes each, so "Grüße" is 7 bytes.
    private let greeting = "Gr\u{00FC}\u{00DF}e \u{1F44B}\u{1F3FD}"

    @Test func textThatFitsIsReturnedUnchanged() {
        #expect("hello".truncated(toUTF8ByteCount: 5) == "hello")
        #expect("hello".truncated(toUTF8ByteCount: 50, ending: "…") == "hello")
        #expect("".truncated(toUTF8ByteCount: 0) == "")
    }

    @Test func keepsWholeCharactersOnly() {
        #expect(greeting.truncated(toUTF8ByteCount: 7) == "Gr\u{00FC}\u{00DF}e")
        // Byte 4 would cut "ß" in half, so it is left out.
        #expect(greeting.truncated(toUTF8ByteCount: 5) == "Gr\u{00FC}")
    }

    @Test func theEndingCountsTowardTheLimit() {
        let result = greeting.truncated(toUTF8ByteCount: 9, ending: "…")
        #expect(result == "Gr\u{00FC}\u{00DF}…")
        #expect(result.utf8.count == 9)
    }

    @Test func anEndingLongerThanTheLimitIsLeftOut() {
        #expect("abcdef".truncated(toUTF8ByteCount: 2, ending: "...") == "ab")
    }

    @Test func aGraphemeClusterIsNeverSplit() {
        // A family emoji is one character of 25 bytes (four people joined by three ZWJ).
        let family = "\u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467}\u{200D}\u{1F466}"
        #expect(family.utf8.count == 25)
        #expect(("a" + family).truncated(toUTF8ByteCount: 25) == "a")
        #expect(("a" + family).truncated(toUTF8ByteCount: 26) == "a" + family)
        // "e" followed by a combining acute accent is one character of 3 bytes.
        #expect("ae\u{0301}".truncated(toUTF8ByteCount: 2) == "a")
    }

    @Test(arguments: [0, -1, Int.min])
    func aLimitOfZeroOrLessGivesAnEmptyString(limit: Int) {
        #expect("text".truncated(toUTF8ByteCount: limit) == "")
        #expect("text".truncated(toUTF8ByteCount: limit, ending: "…") == "")
    }

    @Test func worksOnSubstrings() {
        let line = "first line, second line"
        let tail = line[line.range(of: "second")!.lowerBound...]
        #expect(tail.truncated(toUTF8ByteCount: 6) == "second")
    }

    @Test func everyResultFitsAndIsAPrefix() {
        let samples = [greeting, "日本語のテキスト", "a\u{1F1F9}\u{1F1F7}b", "plain ascii", "e\u{0301}\u{0301}x"]
        for text in samples {
            for limit in 0...(text.utf8.count + 2) {
                let plain = text.truncated(toUTF8ByteCount: limit)
                #expect(plain.utf8.count <= limit)
                #expect(text.hasPrefix(plain))
                let marked = text.truncated(toUTF8ByteCount: limit, ending: "…")
                #expect(marked.utf8.count <= limit)
            }
        }
    }
}
