import Foundation

// MARK: - Data Encoding Extensions

public extension Data {
    
    // MARK: - Hexadecimal Encoding
    
    /// Returns hexadecimal string representation.
    ///
    /// ```swift
    /// data.hexString    // "48656c6c6f"
    /// ```
    var hexString: String {
        return map { String(format: "%02x", $0) }.joined()
    }
    
    /// Returns uppercase hexadecimal string.
    var hexStringUppercase: String {
        return map { String(format: "%02X", $0) }.joined()
    }
    
    /// Returns hexadecimal string with spaces between bytes.
    var hexStringWithSpaces: String {
        return map { String(format: "%02x", $0) }.joined(separator: " ")
    }
    
    /// Returns hexadecimal string with 0x prefix.
    var hexStringWithPrefix: String {
        return "0x" + hexString
    }
    
    /// Creates Data from hexadecimal string.
    ///
    /// - Parameter hexString: Hexadecimal string.
    init?(hexString: String) {
        var hex = hexString
        
        // Remove common prefixes and whitespace
        hex = hex.replacingOccurrences(of: "0x", with: "")
        hex = hex.replacingOccurrences(of: " ", with: "")
        
        guard hex.count % 2 == 0 else { return nil }
        
        var data = Data()
        var index = hex.startIndex
        
        while index < hex.endIndex {
            let nextIndex = hex.index(index, offsetBy: 2)
            let byteString = String(hex[index..<nextIndex])
            guard let byte = UInt8(byteString, radix: 16) else { return nil }
            data.append(byte)
            index = nextIndex
        }
        
        self = data
    }
    
    // MARK: - Base64 Encoding
    
    /// Returns Base64 encoded string.
    var base64String: String {
        return base64EncodedString()
    }
    
    /// Returns Base64 encoded string with line breaks.
    ///
    /// - Parameter lineLength: Maximum line length (default: 76).
    /// - Returns: Base64 string with line breaks.
    func base64String(lineLength: Int = 76) -> String {
        return base64EncodedString(options: .lineLength76Characters)
    }
    
    /// Returns URL-safe Base64 encoded string.
    ///
    /// Replaces + with -, / with _, and removes padding.
    var base64URLString: String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    /// Creates Data from Base64 string.
    ///
    /// - Parameter base64String: Base64 encoded string.
    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self = data
    }
    
    /// Creates Data from URL-safe Base64 string.
    ///
    /// - Parameter base64URLString: URL-safe Base64 string.
    init?(base64URLString: String) {
        var base64 = base64URLString
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Add padding if needed
        let remainder = base64.count % 4
        if remainder > 0 {
            base64 += String(repeating: "=", count: 4 - remainder)
        }
        
        self.init(base64String: base64)
    }
    
    // MARK: - UTF-8 String Conversion
    
    /// Returns UTF-8 string representation.
    var utf8String: String? {
        return String(data: self, encoding: .utf8)
    }
    
    /// Returns UTF-8 string or empty string if conversion fails.
    var utf8StringOrEmpty: String {
        return utf8String ?? ""
    }
    
    /// Creates Data from UTF-8 string.
    ///
    /// - Parameter string: UTF-8 string.
    init(utf8String: String) {
        self = utf8String.data(using: .utf8) ?? Data()
    }
    
    // MARK: - ASCII Conversion
    
    /// Returns ASCII string representation.
    var asciiString: String? {
        return String(data: self, encoding: .ascii)
    }
    
    /// Creates Data from ASCII string.
    ///
    /// - Parameter string: ASCII string.
    init?(asciiString: String) {
        guard let data = string.data(using: .ascii) else { return nil }
        self = data
    }
    
    // MARK: - Byte Array Conversion
    
    /// Returns array of bytes.
    var bytes: [UInt8] {
        return Array(self)
    }
    
    /// Creates Data from byte array.
    ///
    /// - Parameter bytes: Array of bytes.
    init(bytes: [UInt8]) {
        self.init(bytes)
    }
    
    // MARK: - Integer Conversion
    
    /// Creates Data from integer (big endian).
    ///
    /// - Parameter value: Integer value.
    init<T: FixedWidthInteger>(integer value: T) {
        var bigEndian = value.bigEndian
        self = Data(bytes: &bigEndian, count: MemoryLayout<T>.size)
    }
    
    /// Creates Data from integer (little endian).
    ///
    /// - Parameter value: Integer value.
    init<T: FixedWidthInteger>(littleEndian value: T) {
        var littleEndian = value.littleEndian
        self = Data(bytes: &littleEndian, count: MemoryLayout<T>.size)
    }
    
    /// Converts to integer (big endian).
    func toInteger<T: FixedWidthInteger>() -> T? {
        guard count >= MemoryLayout<T>.size else { return nil }
        return withUnsafeBytes { $0.load(as: T.self).bigEndian }
    }
    
    /// Converts to integer (little endian).
    func toLittleEndianInteger<T: FixedWidthInteger>() -> T? {
        guard count >= MemoryLayout<T>.size else { return nil }
        return withUnsafeBytes { $0.load(as: T.self).littleEndian }
    }
    
    // MARK: - Bit Manipulation
    
    /// Returns bit at specified index.
    ///
    /// - Parameter index: Bit index (0 is LSB of first byte).
    /// - Returns: Bit value (0 or 1).
    func bit(at index: Int) -> UInt8? {
        let byteIndex = index / 8
        let bitIndex = index % 8
        
        guard byteIndex < count else { return nil }
        return (self[byteIndex] >> bitIndex) & 1
    }
    
    /// Sets bit at specified index.
    ///
    /// - Parameters:
    ///   - index: Bit index.
    ///   - value: Bit value (true = 1, false = 0).
    mutating func setBit(at index: Int, to value: Bool) {
        let byteIndex = index / 8
        let bitIndex = index % 8
        
        guard byteIndex < count else { return }
        
        if value {
            self[byteIndex] |= (1 << bitIndex)
        } else {
            self[byteIndex] &= ~(1 << bitIndex)
        }
    }
    
    // MARK: - Chunking
    
    /// Splits data into chunks.
    ///
    /// - Parameter size: Chunk size in bytes.
    /// - Returns: Array of data chunks.
    func chunked(into size: Int) -> [Data] {
        guard size > 0 else { return [] }
        
        return stride(from: 0, to: count, by: size).map { startIndex in
            let endIndex = Swift.min(startIndex + size, count)
            return self[startIndex..<endIndex]
        }
    }
}

// MARK: - Data Hashing

public extension Data {
    
    /// Returns MD5 hash.
    var md5: Data {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        withUnsafeBytes { bytes in
            _ = CC_MD5(bytes.baseAddress, CC_LONG(count), &digest)
        }
        return Data(digest)
    }
    
    /// Returns SHA1 hash.
    var sha1: Data {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        withUnsafeBytes { bytes in
            _ = CC_SHA1(bytes.baseAddress, CC_LONG(count), &digest)
        }
        return Data(digest)
    }
    
    /// Returns SHA256 hash.
    var sha256: Data {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        withUnsafeBytes { bytes in
            _ = CC_SHA256(bytes.baseAddress, CC_LONG(count), &digest)
        }
        return Data(digest)
    }
    
    /// Returns SHA512 hash.
    var sha512: Data {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        withUnsafeBytes { bytes in
            _ = CC_SHA512(bytes.baseAddress, CC_LONG(count), &digest)
        }
        return Data(digest)
    }
    
    /// Returns MD5 hash as hex string.
    var md5Hex: String {
        return md5.hexString
    }
    
    /// Returns SHA256 hash as hex string.
    var sha256Hex: String {
        return sha256.hexString
    }
}

import CommonCrypto
