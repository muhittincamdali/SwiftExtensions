extension StringProtocol {
    /// Shortens the text to at most `maxByteCount` bytes of UTF-8 without cutting a character
    /// in half.
    ///
    /// Limits measured in bytes are common: an HTTP header, a push notification payload, a
    /// database column, a file name (255 bytes on APFS). `prefix(_:)` counts characters, and an
    /// emoji or an accented letter can take up to dozens of bytes, so a text of the right
    /// length in characters can still be too long. Cutting the UTF-8 bytes at the limit can
    /// split a character and leave invalid text.
    ///
    /// This method keeps whole characters (grapheme clusters, as `String` counts them) and
    /// stops before the first character that does not fit. When the text is shortened and an
    /// `ending` such as `"…"` is given, the ending is added and its bytes count toward the limit.
    ///
    /// ```swift
    /// "Grüße 👋🏽".truncated(toUTF8ByteCount: 7)               // "Grüße" (7 bytes)
    /// "Grüße 👋🏽".truncated(toUTF8ByteCount: 9, ending: "…")  // "Grüß…" (9 bytes)
    /// ```
    ///
    /// - Parameters:
    ///   - maxByteCount: The largest number of UTF-8 bytes of the result; values below 0
    ///     count as 0.
    ///   - ending: Text appended when the text is shortened. When the ending alone is longer
    ///     than `maxByteCount`, the text is shortened without it.
    /// - Returns: The text itself when it fits, otherwise its longest prefix of whole
    ///   characters that fits together with `ending`.
    public func truncated(toUTF8ByteCount maxByteCount: Int, ending: String = "") -> String {
        let limit = Swift.max(0, maxByteCount)
        if utf8.count <= limit {
            return String(self)
        }
        let endingBytes = ending.utf8.count
        let fitsEnding = endingBytes <= limit
        let budget = fitsEnding ? limit - endingBytes : limit
        var used = 0
        var end = startIndex
        for character in self {
            let size = character.utf8.count
            guard used + size <= budget else { break }
            used += size
            end = index(after: end)
        }
        let kept = String(self[startIndex..<end])
        return fitsEnding ? kept + ending : kept
    }
}
