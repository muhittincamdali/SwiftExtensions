import Foundation
import Compression

// MARK: - Data Compression Extensions

public extension Data {
    
    // MARK: - Generic Compression
    
    /// Compresses data using specified algorithm.
    ///
    /// - Parameter algorithm: Compression algorithm to use.
    /// - Returns: Compressed data or nil if compression fails.
    func compressed(using algorithm: compression_algorithm = COMPRESSION_ZLIB) -> Data? {
        guard !isEmpty else { return nil }
        
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        defer { destinationBuffer.deallocate() }
        
        let compressedSize = withUnsafeBytes { sourceBuffer -> Int in
            guard let sourcePointer = sourceBuffer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return 0
            }
            return compression_encode_buffer(
                destinationBuffer,
                count,
                sourcePointer,
                count,
                nil,
                algorithm
            )
        }
        
        guard compressedSize > 0 else { return nil }
        return Data(bytes: destinationBuffer, count: compressedSize)
    }
    
    /// Decompresses data using specified algorithm.
    ///
    /// - Parameters:
    ///   - algorithm: Compression algorithm used.
    ///   - decompressedSize: Expected size of decompressed data.
    /// - Returns: Decompressed data or nil if decompression fails.
    func decompressed(using algorithm: compression_algorithm = COMPRESSION_ZLIB, decompressedSize: Int? = nil) -> Data? {
        guard !isEmpty else { return nil }
        
        let bufferSize = decompressedSize ?? count * 10
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { destinationBuffer.deallocate() }
        
        let decompressedSize = withUnsafeBytes { sourceBuffer -> Int in
            guard let sourcePointer = sourceBuffer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return 0
            }
            return compression_decode_buffer(
                destinationBuffer,
                bufferSize,
                sourcePointer,
                count,
                nil,
                algorithm
            )
        }
        
        guard decompressedSize > 0 else { return nil }
        return Data(bytes: destinationBuffer, count: decompressedSize)
    }
    
    // MARK: - ZLIB Compression
    
    /// Compresses data using ZLIB algorithm.
    ///
    /// ```swift
    /// let compressed = data.zlibCompressed
    /// ```
    var zlibCompressed: Data? {
        return compressed(using: COMPRESSION_ZLIB)
    }
    
    /// Decompresses ZLIB compressed data.
    ///
    /// - Parameter decompressedSize: Expected decompressed size.
    /// - Returns: Decompressed data.
    func zlibDecompressed(decompressedSize: Int? = nil) -> Data? {
        return decompressed(using: COMPRESSION_ZLIB, decompressedSize: decompressedSize)
    }
    
    // MARK: - LZFSE Compression (Apple's native algorithm)
    
    /// Compresses data using LZFSE algorithm.
    ///
    /// LZFSE is optimized for Apple platforms and provides
    /// a good balance of compression ratio and speed.
    var lzfseCompressed: Data? {
        return compressed(using: COMPRESSION_LZFSE)
    }
    
    /// Decompresses LZFSE compressed data.
    func lzfseDecompressed(decompressedSize: Int? = nil) -> Data? {
        return decompressed(using: COMPRESSION_LZFSE, decompressedSize: decompressedSize)
    }
    
    // MARK: - LZ4 Compression (Fast compression)
    
    /// Compresses data using LZ4 algorithm.
    ///
    /// LZ4 provides very fast compression/decompression
    /// with moderate compression ratio.
    var lz4Compressed: Data? {
        return compressed(using: COMPRESSION_LZ4)
    }
    
    /// Decompresses LZ4 compressed data.
    func lz4Decompressed(decompressedSize: Int? = nil) -> Data? {
        return decompressed(using: COMPRESSION_LZ4, decompressedSize: decompressedSize)
    }
    
    // MARK: - LZMA Compression (High compression ratio)
    
    /// Compresses data using LZMA algorithm.
    ///
    /// LZMA provides high compression ratio but is slower.
    var lzmaCompressed: Data? {
        return compressed(using: COMPRESSION_LZMA)
    }
    
    /// Decompresses LZMA compressed data.
    func lzmaDecompressed(decompressedSize: Int? = nil) -> Data? {
        return decompressed(using: COMPRESSION_LZMA, decompressedSize: decompressedSize)
    }
    
    // MARK: - Compression Statistics
    
    /// Returns compression ratio after compression.
    ///
    /// - Parameter algorithm: Compression algorithm to use.
    /// - Returns: Compression ratio (compressed/original), or nil if failed.
    func compressionRatio(using algorithm: compression_algorithm = COMPRESSION_ZLIB) -> Double? {
        guard let compressed = compressed(using: algorithm), count > 0 else { return nil }
        return Double(compressed.count) / Double(count)
    }
    
    /// Returns space saved by compression as percentage.
    ///
    /// - Parameter algorithm: Compression algorithm to use.
    /// - Returns: Percentage of space saved (0-100).
    func compressionSavings(using algorithm: compression_algorithm = COMPRESSION_ZLIB) -> Double? {
        guard let ratio = compressionRatio(using: algorithm) else { return nil }
        return (1.0 - ratio) * 100
    }
}

// MARK: - Compression Algorithm Info

/// Compression algorithm options with metadata
public enum CompressionAlgorithm: CaseIterable {
    case zlib
    case lzfse
    case lz4
    case lzma
    
    /// Returns the underlying compression algorithm.
    public var algorithm: compression_algorithm {
        switch self {
        case .zlib: return COMPRESSION_ZLIB
        case .lzfse: return COMPRESSION_LZFSE
        case .lz4: return COMPRESSION_LZ4
        case .lzma: return COMPRESSION_LZMA
        }
    }
    
    /// Returns human-readable name.
    public var name: String {
        switch self {
        case .zlib: return "ZLIB"
        case .lzfse: return "LZFSE"
        case .lz4: return "LZ4"
        case .lzma: return "LZMA"
        }
    }
    
    /// Returns description of algorithm characteristics.
    public var description: String {
        switch self {
        case .zlib: return "Standard compression, good balance"
        case .lzfse: return "Apple optimized, fast with good ratio"
        case .lz4: return "Very fast, moderate compression"
        case .lzma: return "High compression, slower speed"
        }
    }
}

// MARK: - Data Extension for CompressionAlgorithm Enum

public extension Data {
    
    /// Compresses data using CompressionAlgorithm enum.
    func compressed(using algorithm: CompressionAlgorithm) -> Data? {
        return compressed(using: algorithm.algorithm)
    }
    
    /// Decompresses data using CompressionAlgorithm enum.
    func decompressed(using algorithm: CompressionAlgorithm, decompressedSize: Int? = nil) -> Data? {
        return decompressed(using: algorithm.algorithm, decompressedSize: decompressedSize)
    }
}
