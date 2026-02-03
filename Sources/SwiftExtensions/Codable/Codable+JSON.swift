import Foundation

// MARK: - Encodable Extensions

public extension Encodable {
    
    // MARK: - JSON Encoding
    
    /// Encodes to JSON Data.
    ///
    /// - Parameter encoder: JSON encoder (default: standard encoder).
    /// - Returns: JSON data.
    /// - Throws: Encoding error.
    func jsonData(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
    /// Encodes to pretty-printed JSON Data.
    ///
    /// - Returns: Pretty-printed JSON data.
    /// - Throws: Encoding error.
    func prettyJSONData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return try encoder.encode(self)
    }
    
    /// Encodes to JSON string.
    ///
    /// - Parameter encoder: JSON encoder.
    /// - Returns: JSON string.
    /// - Throws: Encoding error.
    func jsonString(using encoder: JSONEncoder = JSONEncoder()) throws -> String {
        let data = try jsonData(using: encoder)
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    /// Encodes to pretty-printed JSON string.
    ///
    /// - Returns: Pretty-printed JSON string.
    /// - Throws: Encoding error.
    func prettyJSONString() throws -> String {
        let data = try prettyJSONData()
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    /// Encodes to JSON dictionary.
    ///
    /// - Returns: Dictionary representation.
    /// - Throws: Encoding error.
    func jsonDictionary() throws -> [String: Any] {
        let data = try jsonData()
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw CodableError.notDictionary
        }
        return dict
    }
    
    /// Encodes to JSON array.
    ///
    /// - Returns: Array representation.
    /// - Throws: Encoding error.
    func jsonArray() throws -> [Any] {
        let data = try jsonData()
        guard let array = try JSONSerialization.jsonObject(with: data) as? [Any] else {
            throw CodableError.notArray
        }
        return array
    }
    
    // MARK: - Custom Encoding Options
    
    /// Encodes with snake_case key conversion.
    ///
    /// - Returns: JSON data with snake_case keys.
    /// - Throws: Encoding error.
    func jsonDataSnakeCase() throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
    
    /// Encodes with custom date format.
    ///
    /// - Parameter dateFormat: Date format string.
    /// - Returns: JSON data.
    /// - Throws: Encoding error.
    func jsonData(dateFormat: String) throws -> Data {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        encoder.dateEncodingStrategy = .formatted(formatter)
        return try encoder.encode(self)
    }
    
    /// Encodes with ISO 8601 date format.
    ///
    /// - Returns: JSON data with ISO dates.
    /// - Throws: Encoding error.
    func jsonDataISO8601() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}

// MARK: - Decodable Extensions

public extension Decodable {
    
    // MARK: - JSON Decoding
    
    /// Decodes from JSON data.
    ///
    /// - Parameters:
    ///   - data: JSON data.
    ///   - decoder: JSON decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(jsonData data: Data, using decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
    
    /// Decodes from JSON string.
    ///
    /// - Parameters:
    ///   - string: JSON string.
    ///   - decoder: JSON decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(jsonString string: String, using decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        guard let data = string.data(using: .utf8) else {
            throw CodableError.invalidString
        }
        return try from(jsonData: data, using: decoder)
    }
    
    /// Decodes from JSON dictionary.
    ///
    /// - Parameters:
    ///   - dictionary: JSON dictionary.
    ///   - decoder: JSON decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(dictionary: [String: Any], using decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: dictionary)
        return try from(jsonData: data, using: decoder)
    }
    
    // MARK: - Custom Decoding Options
    
    /// Decodes with snake_case key conversion.
    ///
    /// - Parameter data: JSON data.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func fromSnakeCase(jsonData data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try from(jsonData: data, using: decoder)
    }
    
    /// Decodes with custom date format.
    ///
    /// - Parameters:
    ///   - data: JSON data.
    ///   - dateFormat: Date format string.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(jsonData data: Data, dateFormat: String) throws -> Self {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try from(jsonData: data, using: decoder)
    }
    
    /// Decodes with ISO 8601 date format.
    ///
    /// - Parameter data: JSON data.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func fromISO8601(jsonData data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try from(jsonData: data, using: decoder)
    }
    
    // MARK: - File Decoding
    
    /// Decodes from JSON file.
    ///
    /// - Parameters:
    ///   - url: File URL.
    ///   - decoder: JSON decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(jsonFile url: URL, using decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        let data = try Data(contentsOf: url)
        return try from(jsonData: data, using: decoder)
    }
    
    /// Decodes from bundle resource.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - ext: File extension.
    ///   - bundle: Bundle containing resource.
    ///   - decoder: JSON decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(
        resource name: String,
        extension ext: String = "json",
        bundle: Bundle = .main,
        using decoder: JSONDecoder = JSONDecoder()
    ) throws -> Self {
        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            throw CodableError.resourceNotFound(name: name, extension: ext)
        }
        return try from(jsonFile: url, using: decoder)
    }
}

// MARK: - Codable Error

/// Errors for Codable operations
public enum CodableError: Error, LocalizedError {
    case invalidString
    case notDictionary
    case notArray
    case resourceNotFound(name: String, extension: String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidString:
            return "Invalid UTF-8 string"
        case .notDictionary:
            return "JSON is not a dictionary"
        case .notArray:
            return "JSON is not an array"
        case .resourceNotFound(let name, let ext):
            return "Resource not found: \(name).\(ext)"
        }
    }
}
