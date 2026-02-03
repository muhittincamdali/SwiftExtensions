import Foundation

// MARK: - Data JSON Extensions

public extension Data {
    
    // MARK: - JSON Parsing
    
    /// Parses data as JSON and returns Any object.
    ///
    /// - Parameter options: JSON reading options.
    /// - Returns: Parsed JSON object or nil.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: options)
    }
    
    /// Parses data as JSON dictionary.
    ///
    /// - Returns: Dictionary or nil if not a dictionary.
    var jsonDictionary: [String: Any]? {
        return jsonObject() as? [String: Any]
    }
    
    /// Parses data as JSON array.
    ///
    /// - Returns: Array or nil if not an array.
    var jsonArray: [Any]? {
        return jsonObject() as? [Any]
    }
    
    /// Parses data as array of dictionaries.
    var jsonDictionaryArray: [[String: Any]]? {
        return jsonObject() as? [[String: Any]]
    }
    
    // MARK: - Pretty Printing
    
    /// Returns pretty-printed JSON string.
    ///
    /// ```swift
    /// data.prettyPrintedJSON    // Formatted JSON string
    /// ```
    var prettyPrintedJSON: String? {
        guard let jsonObject = jsonObject(),
              let prettyData = try? JSONSerialization.data(
                  withJSONObject: jsonObject,
                  options: [.prettyPrinted, .sortedKeys]
              ) else { return nil }
        
        return String(data: prettyData, encoding: .utf8)
    }
    
    /// Returns compact JSON string (no whitespace).
    var compactJSON: String? {
        guard let jsonObject = jsonObject(),
              let compactData = try? JSONSerialization.data(
                  withJSONObject: jsonObject,
                  options: []
              ) else { return nil }
        
        return String(data: compactData, encoding: .utf8)
    }
    
    /// Returns JSON string with custom formatting options.
    ///
    /// - Parameter options: JSON writing options.
    /// - Returns: Formatted JSON string.
    func jsonString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String? {
        guard let jsonObject = jsonObject(),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: options) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: - JSON Validation
    
    /// Checks if data is valid JSON.
    var isValidJSON: Bool {
        return jsonObject() != nil
    }
    
    /// Checks if data represents a JSON object (dictionary).
    var isJSONObject: Bool {
        return jsonDictionary != nil
    }
    
    /// Checks if data represents a JSON array.
    var isJSONArray: Bool {
        return jsonArray != nil
    }
    
    // MARK: - Codable Helpers
    
    /// Decodes JSON data to Codable type.
    ///
    /// - Parameters:
    ///   - type: Type to decode to.
    ///   - decoder: JSON decoder (default: standard decoder).
    /// - Returns: Decoded object or nil.
    ///
    /// ```swift
    /// let user: User? = data.decoded()
    /// ```
    func decoded<T: Decodable>(as type: T.Type = T.self, using decoder: JSONDecoder = JSONDecoder()) -> T? {
        return try? decoder.decode(type, from: self)
    }
    
    /// Decodes JSON data to Codable type or throws error.
    ///
    /// - Parameters:
    ///   - type: Type to decode to.
    ///   - decoder: JSON decoder.
    /// - Returns: Decoded object.
    /// - Throws: DecodingError if decoding fails.
    func decodedOrThrow<T: Decodable>(as type: T.Type = T.self, using decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(type, from: self)
    }
    
    /// Decodes JSON data with snake_case key conversion.
    ///
    /// - Parameter type: Type to decode to.
    /// - Returns: Decoded object or nil.
    func decodedFromSnakeCase<T: Decodable>(as type: T.Type = T.self) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(type, from: self)
    }
    
    /// Decodes JSON data with custom date format.
    ///
    /// - Parameters:
    ///   - type: Type to decode to.
    ///   - dateFormat: Date format string.
    /// - Returns: Decoded object or nil.
    func decoded<T: Decodable>(as type: T.Type = T.self, dateFormat: String) -> T? {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try? decoder.decode(type, from: self)
    }
    
    // MARK: - JSON Creation
    
    /// Creates Data from JSON object.
    ///
    /// - Parameters:
    ///   - jsonObject: Object to serialize (dictionary, array, etc.).
    ///   - options: Writing options.
    /// - Returns: Serialized JSON data.
    static func fromJSON(_ jsonObject: Any, options: JSONSerialization.WritingOptions = []) -> Data? {
        guard JSONSerialization.isValidJSONObject(jsonObject) else { return nil }
        return try? JSONSerialization.data(withJSONObject: jsonObject, options: options)
    }
    
    /// Creates Data from Encodable object.
    ///
    /// - Parameters:
    ///   - value: Encodable object.
    ///   - encoder: JSON encoder.
    /// - Returns: Encoded JSON data.
    static func fromEncodable<T: Encodable>(_ value: T, using encoder: JSONEncoder = JSONEncoder()) -> Data? {
        return try? encoder.encode(value)
    }
    
    /// Creates pretty-printed Data from Encodable object.
    static func prettyJSONFrom<T: Encodable>(_ value: T) -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return try? encoder.encode(value)
    }
}

// MARK: - JSON Path Access

public extension Data {
    
    /// Accesses nested JSON value using key path.
    ///
    /// - Parameter keyPath: Dot-separated key path (e.g., "user.profile.name").
    /// - Returns: Value at key path or nil.
    ///
    /// ```swift
    /// let name = data.jsonValue(at: "user.profile.name") as? String
    /// ```
    func jsonValue(at keyPath: String) -> Any? {
        guard var current = jsonObject() else { return nil }
        
        let keys = keyPath.split(separator: ".").map(String.init)
        
        for (index, key) in keys.enumerated() {
            if let dict = current as? [String: Any] {
                if index == keys.count - 1 {
                    return dict[key]
                }
                guard let next = dict[key] else { return nil }
                current = next
            } else if let array = current as? [Any], let arrayIndex = Int(key) {
                guard arrayIndex >= 0 && arrayIndex < array.count else { return nil }
                if index == keys.count - 1 {
                    return array[arrayIndex]
                }
                current = array[arrayIndex]
            } else {
                return nil
            }
        }
        
        return current
    }
    
    /// Returns string value at JSON key path.
    func jsonString(at keyPath: String) -> String? {
        return jsonValue(at: keyPath) as? String
    }
    
    /// Returns integer value at JSON key path.
    func jsonInt(at keyPath: String) -> Int? {
        return jsonValue(at: keyPath) as? Int
    }
    
    /// Returns double value at JSON key path.
    func jsonDouble(at keyPath: String) -> Double? {
        return jsonValue(at: keyPath) as? Double
    }
    
    /// Returns boolean value at JSON key path.
    func jsonBool(at keyPath: String) -> Bool? {
        return jsonValue(at: keyPath) as? Bool
    }
    
    /// Returns array value at JSON key path.
    func jsonArray(at keyPath: String) -> [Any]? {
        return jsonValue(at: keyPath) as? [Any]
    }
    
    /// Returns dictionary value at JSON key path.
    func jsonDictionary(at keyPath: String) -> [String: Any]? {
        return jsonValue(at: keyPath) as? [String: Any]
    }
}
