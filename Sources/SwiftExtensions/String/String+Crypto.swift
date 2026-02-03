import Foundation
import CryptoKit

extension String {

    /// Returns the MD5 hash of the string as a lowercase hex string.
    ///
    /// ```swift
    /// "hello".md5 // "5d41402abc4b2a76b9719d911017c592"
    /// ```
    public var md5: String {
        let data = Data(utf8)
        let hash = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    /// Returns the SHA-256 hash of the string as a lowercase hex string.
    ///
    /// ```swift
    /// "hello".sha256 // "2cf24dba5fb0a30e26e83b2ac5b9e29e..."
    /// ```
    public var sha256: String {
        let data = Data(utf8)
        let hash = SHA256.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    /// Returns the SHA-384 hash of the string as a lowercase hex string.
    public var sha384: String {
        let data = Data(utf8)
        let hash = SHA384.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    /// Returns the SHA-512 hash of the string as a lowercase hex string.
    public var sha512: String {
        let data = Data(utf8)
        let hash = SHA512.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    /// Returns an HMAC-SHA256 signature using the given key.
    ///
    /// - Parameter key: The secret key for HMAC computation.
    /// - Returns: Hex-encoded HMAC string.
    public func hmacSHA256(key: String) -> String {
        let keyData = SymmetricKey(data: Data(key.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: Data(utf8), using: keyData)
        return Data(signature).map { String(format: "%02x", $0) }.joined()
    }
}
