import Foundation

// MARK: - Encodable Plist Extensions

public extension Encodable {
    
    // MARK: - Plist Encoding
    
    /// Encodes to property list data.
    ///
    /// - Parameters:
    ///   - format: Output format (default: binary).
    ///   - encoder: Property list encoder.
    /// - Returns: Plist data.
    /// - Throws: Encoding error.
    func plistData(
        format: PropertyListSerialization.PropertyListFormat = .binary,
        using encoder: PropertyListEncoder = PropertyListEncoder()
    ) throws -> Data {
        encoder.outputFormat = format
        return try encoder.encode(self)
    }
    
    /// Encodes to XML property list data.
    ///
    /// - Returns: XML plist data.
    /// - Throws: Encoding error.
    func xmlPlistData() throws -> Data {
        return try plistData(format: .xml)
    }
    
    /// Encodes to binary property list data.
    ///
    /// - Returns: Binary plist data.
    /// - Throws: Encoding error.
    func binaryPlistData() throws -> Data {
        return try plistData(format: .binary)
    }
    
    /// Encodes to XML plist string.
    ///
    /// - Returns: XML plist string.
    /// - Throws: Encoding error.
    func xmlPlistString() throws -> String {
        let data = try xmlPlistData()
        guard let string = String(data: data, encoding: .utf8) else {
            throw PlistError.invalidEncoding
        }
        return string
    }
    
    /// Writes to plist file.
    ///
    /// - Parameters:
    ///   - url: Destination URL.
    ///   - format: Output format.
    /// - Throws: Encoding or write error.
    func writePlist(to url: URL, format: PropertyListSerialization.PropertyListFormat = .binary) throws {
        let data = try plistData(format: format)
        try data.write(to: url)
    }
}

// MARK: - Decodable Plist Extensions

public extension Decodable {
    
    // MARK: - Plist Decoding
    
    /// Decodes from property list data.
    ///
    /// - Parameters:
    ///   - data: Plist data.
    ///   - decoder: Property list decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(plistData data: Data, using decoder: PropertyListDecoder = PropertyListDecoder()) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
    
    /// Decodes from plist file.
    ///
    /// - Parameters:
    ///   - url: File URL.
    ///   - decoder: Property list decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(plistFile url: URL, using decoder: PropertyListDecoder = PropertyListDecoder()) throws -> Self {
        let data = try Data(contentsOf: url)
        return try from(plistData: data, using: decoder)
    }
    
    /// Decodes from bundle plist resource.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - bundle: Bundle containing resource.
    ///   - decoder: Property list decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(
        plistResource name: String,
        bundle: Bundle = .main,
        using decoder: PropertyListDecoder = PropertyListDecoder()
    ) throws -> Self {
        guard let url = bundle.url(forResource: name, withExtension: "plist") else {
            throw PlistError.resourceNotFound(name: name)
        }
        return try from(plistFile: url, using: decoder)
    }
    
    /// Decodes from XML plist string.
    ///
    /// - Parameters:
    ///   - string: XML plist string.
    ///   - decoder: Property list decoder.
    /// - Returns: Decoded instance.
    /// - Throws: Decoding error.
    static func from(plistString string: String, using decoder: PropertyListDecoder = PropertyListDecoder()) throws -> Self {
        guard let data = string.data(using: .utf8) else {
            throw PlistError.invalidString
        }
        return try from(plistData: data, using: decoder)
    }
}

// MARK: - Plist Error

/// Errors for Plist operations
public enum PlistError: Error, LocalizedError {
    case invalidEncoding
    case invalidString
    case resourceNotFound(name: String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidEncoding:
            return "Failed to encode plist as UTF-8"
        case .invalidString:
            return "Invalid UTF-8 string"
        case .resourceNotFound(let name):
            return "Plist resource not found: \(name)"
        }
    }
}

// MARK: - UserDefaults Codable Support

public extension UserDefaults {
    
    /// Stores Codable value for key.
    ///
    /// - Parameters:
    ///   - value: Codable value.
    ///   - key: Defaults key.
    func setCodable<T: Encodable>(_ value: T, forKey key: String) {
        if let data = try? value.plistData() {
            set(data, forKey: key)
        }
    }
    
    /// Retrieves Codable value for key.
    ///
    /// - Parameters:
    ///   - type: Type to decode.
    ///   - key: Defaults key.
    /// - Returns: Decoded value or nil.
    func codable<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try? T.from(plistData: data)
    }
}
