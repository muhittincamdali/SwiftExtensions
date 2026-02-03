import Foundation

extension Data {

    /// Returns the data as a lowercase hexadecimal string.
    ///
    /// ```swift
    /// Data("Hello".utf8).hexString // "48656c6c6f"
    /// ```
    public var hexString: String {
        map { String(format: "%02x", $0) }.joined()
    }

    /// Creates `Data` from a hexadecimal string.
    ///
    /// - Parameter hexString: A hex-encoded string (e.g., `"48656c6c6f"`).
    public init?(hexString: String) {
        let hex = hexString.hasPrefix("0x") ? String(hexString.dropFirst(2)) : hexString
        guard hex.count.isMultiple(of: 2) else { return nil }

        var data = Data(capacity: hex.count / 2)
        var index = hex.startIndex
        while index < hex.endIndex {
            let nextIndex = hex.index(index, offsetBy: 2)
            guard let byte = UInt8(hex[index..<nextIndex], radix: 16) else { return nil }
            data.append(byte)
            index = nextIndex
        }
        self = data
    }

    /// Returns a URL-safe Base64 encoded string.
    public var base64URLSafe: String {
        base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }

    /// Returns the data decoded as a UTF-8 string, or `nil` if invalid.
    public var utf8String: String? {
        String(data: self, encoding: .utf8)
    }

    /// Returns a pretty-printed JSON string if the data contains valid JSON.
    ///
    /// ```swift
    /// jsonData.prettyJSONString // formatted JSON output
    /// ```
    public var prettyJSONString: String? {
        guard let json = try? JSONSerialization.jsonObject(with: self),
              let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return nil
        }
        return String(data: prettyData, encoding: .utf8)
    }

    /// Returns the size formatted as a human-readable string.
    ///
    /// ```swift
    /// Data(count: 1536).formattedSize // "1.5 KB"
    /// ```
    public var formattedSize: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(count))
    }
}
