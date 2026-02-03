import Foundation
import CommonCrypto

// MARK: - String Crypto Extensions

public extension String {
    
    // MARK: - MD5
    
    /// Returns MD5 hash of the string.
    ///
    /// ```swift
    /// "Hello".md5    // "8b1a9953c4611296a827abf8c47804d7"
    /// ```
    var md5: String {
        guard let data = data(using: .utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { bytes in
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    /// Returns MD5 hash in uppercase.
    var md5Uppercase: String {
        return md5.uppercased()
    }
    
    // MARK: - SHA Hashing
    
    /// Returns SHA1 hash of the string.
    ///
    /// ```swift
    /// "Hello".sha1    // "f7ff9e8b7bb2e09b70935a5d785e0cc5d9d0abf0"
    /// ```
    var sha1: String {
        guard let data = data(using: .utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { bytes in
            CC_SHA1(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    /// Returns SHA256 hash of the string.
    ///
    /// ```swift
    /// "Hello".sha256    // "185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969"
    /// ```
    var sha256: String {
        guard let data = data(using: .utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { bytes in
            CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    /// Returns SHA384 hash of the string.
    var sha384: String {
        guard let data = data(using: .utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA384_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { bytes in
            CC_SHA384(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    /// Returns SHA512 hash of the string.
    var sha512: String {
        guard let data = data(using: .utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { bytes in
            CC_SHA512(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    // MARK: - HMAC
    
    /// Generates HMAC-SHA256 signature.
    ///
    /// - Parameter key: Secret key for HMAC.
    /// - Returns: HMAC-SHA256 hex string.
    func hmacSHA256(key: String) -> String {
        return hmac(algorithm: .sha256, key: key)
    }
    
    /// Generates HMAC-SHA512 signature.
    ///
    /// - Parameter key: Secret key for HMAC.
    /// - Returns: HMAC-SHA512 hex string.
    func hmacSHA512(key: String) -> String {
        return hmac(algorithm: .sha512, key: key)
    }
    
    /// Generates HMAC signature with specified algorithm.
    ///
    /// - Parameters:
    ///   - algorithm: HMAC algorithm to use.
    ///   - key: Secret key for HMAC.
    /// - Returns: HMAC hex string.
    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
        guard let data = data(using: .utf8),
              let keyData = key.data(using: .utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count: algorithm.digestLength)
        
        keyData.withUnsafeBytes { keyBytes in
            data.withUnsafeBytes { dataBytes in
                CCHmac(
                    algorithm.ccAlgorithm,
                    keyBytes.baseAddress,
                    keyData.count,
                    dataBytes.baseAddress,
                    data.count,
                    &digest
                )
            }
        }
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    // MARK: - Base64
    
    /// Encodes string to Base64.
    ///
    /// ```swift
    /// "Hello".base64Encoded    // "SGVsbG8="
    /// ```
    var base64Encoded: String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    /// Decodes Base64 string.
    ///
    /// ```swift
    /// "SGVsbG8=".base64Decoded    // "Hello"
    /// ```
    var base64Decoded: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Encodes string to URL-safe Base64.
    ///
    /// Replaces + with -, / with _, and removes padding.
    var base64URLEncoded: String? {
        return base64Encoded?
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    /// Decodes URL-safe Base64 string.
    var base64URLDecoded: String? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Add padding if needed
        let remainder = base64.count % 4
        if remainder > 0 {
            base64 += String(repeating: "=", count: 4 - remainder)
        }
        
        guard let data = Data(base64Encoded: base64) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: - Hex Encoding
    
    /// Encodes string to hexadecimal.
    ///
    /// ```swift
    /// "Hello".hexEncoded    // "48656c6c6f"
    /// ```
    var hexEncoded: String {
        return data(using: .utf8)?.map { String(format: "%02x", $0) }.joined() ?? ""
    }
    
    /// Decodes hexadecimal string.
    ///
    /// ```swift
    /// "48656c6c6f".hexDecoded    // "Hello"
    /// ```
    var hexDecoded: String? {
        var hex = self
        if hex.hasPrefix("0x") {
            hex = String(hex.dropFirst(2))
        }
        
        guard hex.count % 2 == 0 else { return nil }
        
        var bytes: [UInt8] = []
        var index = hex.startIndex
        
        while index < hex.endIndex {
            let nextIndex = hex.index(index, offsetBy: 2)
            let byteString = String(hex[index..<nextIndex])
            guard let byte = UInt8(byteString, radix: 16) else { return nil }
            bytes.append(byte)
            index = nextIndex
        }
        
        return String(bytes: bytes, encoding: .utf8)
    }
    
    // MARK: - ROT13
    
    /// Applies ROT13 cipher to string.
    ///
    /// ```swift
    /// "Hello".rot13    // "Uryyb"
    /// "Uryyb".rot13    // "Hello"
    /// ```
    var rot13: String {
        return String(map { char -> Character in
            guard char.isLetter else { return char }
            
            let base: Character = char.isUppercase ? "A" : "a"
            let baseValue = base.asciiValue!
            let charValue = char.asciiValue!
            let rotated = (charValue - baseValue + 13) % 26 + baseValue
            
            return Character(UnicodeScalar(rotated))
        })
    }
    
    // MARK: - Caesar Cipher
    
    /// Applies Caesar cipher with specified shift.
    ///
    /// - Parameter shift: Number of positions to shift.
    /// - Returns: Shifted string.
    func caesarCipher(shift: Int) -> String {
        let normalizedShift = ((shift % 26) + 26) % 26
        
        return String(map { char -> Character in
            guard char.isLetter else { return char }
            
            let base: Character = char.isUppercase ? "A" : "a"
            let baseValue = Int(base.asciiValue!)
            let charValue = Int(char.asciiValue!)
            let shifted = (charValue - baseValue + normalizedShift) % 26 + baseValue
            
            return Character(UnicodeScalar(shifted)!)
        })
    }
    
    // MARK: - XOR Encryption
    
    /// XOR encrypts/decrypts string with key.
    ///
    /// - Parameter key: Encryption key.
    /// - Returns: XOR'd string in hex format.
    func xorEncrypt(key: String) -> String {
        guard !key.isEmpty, let data = data(using: .utf8) else { return "" }
        let keyData = Array(key.utf8)
        
        let encrypted = data.enumerated().map { index, byte in
            byte ^ keyData[index % keyData.count]
        }
        
        return encrypted.map { String(format: "%02x", $0) }.joined()
    }
    
    /// XOR decrypts hex string with key.
    ///
    /// - Parameter key: Decryption key.
    /// - Returns: Decrypted string.
    func xorDecrypt(key: String) -> String? {
        guard !key.isEmpty, count % 2 == 0 else { return nil }
        let keyData = Array(key.utf8)
        
        var bytes: [UInt8] = []
        var index = startIndex
        
        while index < endIndex {
            let nextIndex = self.index(index, offsetBy: 2)
            let byteString = String(self[index..<nextIndex])
            guard let byte = UInt8(byteString, radix: 16) else { return nil }
            bytes.append(byte)
            index = nextIndex
        }
        
        let decrypted = bytes.enumerated().map { index, byte in
            byte ^ keyData[index % keyData.count]
        }
        
        return String(bytes: decrypted, encoding: .utf8)
    }
    
    // MARK: - Checksum
    
    /// Calculates CRC32 checksum.
    var crc32: UInt32 {
        guard let data = data(using: .utf8) else { return 0 }
        
        var crc: UInt32 = 0xFFFFFFFF
        let polynomial: UInt32 = 0xEDB88320
        
        for byte in data {
            crc ^= UInt32(byte)
            for _ in 0..<8 {
                crc = (crc >> 1) ^ (crc & 1 == 1 ? polynomial : 0)
            }
        }
        
        return ~crc
    }
    
    /// Returns CRC32 checksum as hex string.
    var crc32Hex: String {
        return String(format: "%08x", crc32)
    }
}

// MARK: - HMAC Algorithm

/// Supported HMAC algorithms
public enum HMACAlgorithm {
    case sha1
    case sha256
    case sha384
    case sha512
    
    var ccAlgorithm: CCHmacAlgorithm {
        switch self {
        case .sha1: return CCHmacAlgorithm(kCCHmacAlgSHA1)
        case .sha256: return CCHmacAlgorithm(kCCHmacAlgSHA256)
        case .sha384: return CCHmacAlgorithm(kCCHmacAlgSHA384)
        case .sha512: return CCHmacAlgorithm(kCCHmacAlgSHA512)
        }
    }
    
    var digestLength: Int {
        switch self {
        case .sha1: return Int(CC_SHA1_DIGEST_LENGTH)
        case .sha256: return Int(CC_SHA256_DIGEST_LENGTH)
        case .sha384: return Int(CC_SHA384_DIGEST_LENGTH)
        case .sha512: return Int(CC_SHA512_DIGEST_LENGTH)
        }
    }
}
