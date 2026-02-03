import Foundation

// MARK: - KeyedDecodingContainer Extensions

public extension KeyedDecodingContainer {
    
    // MARK: - Safe Decoding
    
    /// Decodes value or returns nil on failure (doesn't throw).
    ///
    /// - Parameters:
    ///   - type: Type to decode.
    ///   - key: Coding key.
    /// - Returns: Decoded value or nil.
    func decodeIfPresentSafe<T: Decodable>(_ type: T.Type, forKey key: Key) -> T? {
        return try? decodeIfPresent(type, forKey: key)
    }
    
    /// Decodes value or returns default on failure.
    ///
    /// - Parameters:
    ///   - type: Type to decode.
    ///   - key: Coding key.
    ///   - defaultValue: Default value.
    /// - Returns: Decoded value or default.
    func decodeOrDefault<T: Decodable>(_ type: T.Type, forKey key: Key, default defaultValue: T) -> T {
        return (try? decode(type, forKey: key)) ?? defaultValue
    }
    
    /// Decodes optional value with default.
    ///
    /// - Parameters:
    ///   - type: Type to decode.
    ///   - key: Coding key.
    ///   - defaultValue: Default value if missing or fails.
    /// - Returns: Decoded or default value.
    func decodeIfPresentOrDefault<T: Decodable>(_ type: T.Type, forKey key: Key, default defaultValue: T) -> T {
        return (try? decodeIfPresent(type, forKey: key)) ?? defaultValue
    }
    
    // MARK: - Lossy Array Decoding
    
    /// Decodes array, skipping invalid elements.
    ///
    /// - Parameters:
    ///   - type: Element type.
    ///   - key: Coding key.
    /// - Returns: Array with valid elements only.
    /// - Throws: Container decoding error.
    func decodeLossyArray<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> [T] {
        var container = try nestedUnkeyedContainer(forKey: key)
        var elements: [T] = []
        
        while !container.isAtEnd {
            do {
                let element = try container.decode(T.self)
                elements.append(element)
            } catch {
                // Skip invalid element by decoding as dummy
                _ = try? container.decode(DummyCodable.self)
            }
        }
        
        return elements
    }
    
    /// Decodes optional array, returning empty if missing.
    ///
    /// - Parameters:
    ///   - type: Element type.
    ///   - key: Coding key.
    /// - Returns: Decoded array or empty array.
    func decodeArrayOrEmpty<T: Decodable>(_ type: [T].Type, forKey key: Key) -> [T] {
        return (try? decode([T].self, forKey: key)) ?? []
    }
    
    // MARK: - String Conversions
    
    /// Decodes Int from String or Int.
    ///
    /// - Parameter key: Coding key.
    /// - Returns: Decoded Int.
    /// - Throws: Decoding error.
    func decodeIntFromString(forKey key: Key) throws -> Int {
        if let intValue = try? decode(Int.self, forKey: key) {
            return intValue
        }
        let stringValue = try decode(String.self, forKey: key)
        guard let intValue = Int(stringValue) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Cannot convert string to Int")
        }
        return intValue
    }
    
    /// Decodes Double from String or Double.
    ///
    /// - Parameter key: Coding key.
    /// - Returns: Decoded Double.
    /// - Throws: Decoding error.
    func decodeDoubleFromString(forKey key: Key) throws -> Double {
        if let doubleValue = try? decode(Double.self, forKey: key) {
            return doubleValue
        }
        let stringValue = try decode(String.self, forKey: key)
        guard let doubleValue = Double(stringValue) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Cannot convert string to Double")
        }
        return doubleValue
    }
    
    /// Decodes Bool from String, Int, or Bool.
    ///
    /// - Parameter key: Coding key.
    /// - Returns: Decoded Bool.
    /// - Throws: Decoding error.
    func decodeBoolFromAny(forKey key: Key) throws -> Bool {
        if let boolValue = try? decode(Bool.self, forKey: key) {
            return boolValue
        }
        if let intValue = try? decode(Int.self, forKey: key) {
            return intValue != 0
        }
        if let stringValue = try? decode(String.self, forKey: key) {
            switch stringValue.lowercased() {
            case "true", "yes", "1": return true
            case "false", "no", "0": return false
            default: break
            }
        }
        throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Cannot decode bool")
    }
    
    // MARK: - Date Decoding
    
    /// Decodes Date from multiple formats.
    ///
    /// - Parameters:
    ///   - key: Coding key.
    ///   - formats: Array of date formats to try.
    /// - Returns: Decoded Date.
    /// - Throws: Decoding error.
    func decodeDate(forKey key: Key, formats: [String]) throws -> Date {
        let string = try decode(String.self, forKey: key)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: string) {
                return date
            }
        }
        
        // Try ISO8601
        if let date = ISO8601DateFormatter().date(from: string) {
            return date
        }
        
        // Try Unix timestamp
        if let timestamp = Double(string) {
            return Date(timeIntervalSince1970: timestamp)
        }
        
        throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Cannot decode date from: \(string)")
    }
    
    /// Decodes Date from Unix timestamp (Int or Double).
    ///
    /// - Parameter key: Coding key.
    /// - Returns: Decoded Date.
    /// - Throws: Decoding error.
    func decodeDateFromTimestamp(forKey key: Key) throws -> Date {
        if let doubleValue = try? decode(Double.self, forKey: key) {
            return Date(timeIntervalSince1970: doubleValue)
        }
        if let intValue = try? decode(Int.self, forKey: key) {
            return Date(timeIntervalSince1970: Double(intValue))
        }
        throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Cannot decode timestamp")
    }
    
    // MARK: - URL Decoding
    
    /// Decodes URL from string.
    ///
    /// - Parameter key: Coding key.
    /// - Returns: Decoded URL.
    /// - Throws: Decoding error.
    func decodeURL(forKey key: Key) throws -> URL {
        let string = try decode(String.self, forKey: key)
        guard let url = URL(string: string) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Invalid URL: \(string)")
        }
        return url
    }
    
    /// Decodes optional URL from string.
    ///
    /// - Parameter key: Coding key.
    /// - Returns: Decoded URL or nil.
    func decodeURLIfPresent(forKey key: Key) -> URL? {
        guard let string = try? decodeIfPresent(String.self, forKey: key) else { return nil }
        return URL(string: string ?? "")
    }
}

// MARK: - Dummy Codable for Lossy Decoding

private struct DummyCodable: Decodable {
    init(from decoder: Decoder) throws {
        // Accept any value
        let container = try decoder.singleValueContainer()
        _ = try? container.decode(Bool.self)
        _ = try? container.decode(Int.self)
        _ = try? container.decode(Double.self)
        _ = try? container.decode(String.self)
    }
}

// MARK: - KeyedEncodingContainer Extensions

public extension KeyedEncodingContainer {
    
    /// Encodes value only if not nil.
    ///
    /// - Parameters:
    ///   - value: Optional value.
    ///   - key: Coding key.
    mutating func encodeIfNotNil<T: Encodable>(_ value: T?, forKey key: Key) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }
    
    /// Encodes value only if not empty.
    mutating func encodeIfNotEmpty(_ value: String?, forKey key: Key) throws {
        guard let value = value, !value.isEmpty else { return }
        try encode(value, forKey: key)
    }
    
    /// Encodes array only if not empty.
    mutating func encodeIfNotEmpty<T: Encodable>(_ value: [T]?, forKey key: Key) throws {
        guard let value = value, !value.isEmpty else { return }
        try encode(value, forKey: key)
    }
}
