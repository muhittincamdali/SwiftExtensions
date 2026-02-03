import Foundation

// MARK: - URL Validation Extensions

public extension URL {
    
    // MARK: - Scheme Validation
    
    /// Checks if URL has HTTP scheme.
    var isHTTP: Bool {
        return scheme?.lowercased() == "http"
    }
    
    /// Checks if URL has HTTPS scheme.
    var isHTTPS: Bool {
        return scheme?.lowercased() == "https"
    }
    
    /// Checks if URL is HTTP or HTTPS.
    var isWebURL: Bool {
        return isHTTP || isHTTPS
    }
    
    /// Checks if URL is a file URL.
    var isFileScheme: Bool {
        return isFileURL
    }
    
    /// Checks if URL has FTP scheme.
    var isFTP: Bool {
        return scheme?.lowercased() == "ftp" || scheme?.lowercased() == "sftp"
    }
    
    /// Checks if URL is mailto link.
    var isMailto: Bool {
        return scheme?.lowercased() == "mailto"
    }
    
    /// Checks if URL is tel link.
    var isTel: Bool {
        return scheme?.lowercased() == "tel"
    }
    
    /// Checks if URL is app-specific scheme.
    ///
    /// - Parameter scheme: Expected scheme.
    /// - Returns: `true` if matches.
    func isScheme(_ scheme: String) -> Bool {
        return self.scheme?.lowercased() == scheme.lowercased()
    }
    
    /// Checks if URL has one of the specified schemes.
    func hasScheme(in schemes: [String]) -> Bool {
        guard let scheme = scheme?.lowercased() else { return false }
        return schemes.map { $0.lowercased() }.contains(scheme)
    }
    
    // MARK: - Content Validation
    
    /// Checks if URL has valid structure.
    var isValidStructure: Bool {
        return scheme != nil && host != nil
    }
    
    /// Checks if URL has non-empty path.
    var hasPath: Bool {
        return !path.isEmpty && path != "/"
    }
    
    /// Checks if URL has query parameters.
    var hasQuery: Bool {
        return query != nil && !query!.isEmpty
    }
    
    /// Checks if URL has fragment.
    var hasFragment: Bool {
        return fragment != nil && !fragment!.isEmpty
    }
    
    /// Checks if URL has port specified.
    var hasPort: Bool {
        return port != nil
    }
    
    /// Checks if URL uses default port for scheme.
    var usesDefaultPort: Bool {
        guard let port = port, let scheme = scheme?.lowercased() else { return true }
        
        let defaultPorts: [String: Int] = [
            "http": 80,
            "https": 443,
            "ftp": 21,
            "ssh": 22
        ]
        
        return defaultPorts[scheme] == port
    }
    
    // MARK: - File Validation
    
    /// Checks if URL points to existing file.
    var fileExists: Bool {
        guard isFileURL else { return false }
        return FileManager.default.fileExists(atPath: path)
    }
    
    /// Checks if URL points to directory.
    var isDirectoryURL: Bool {
        guard isFileURL else { return false }
        var isDir: ObjCBool = false
        return FileManager.default.fileExists(atPath: path, isDirectory: &isDir) && isDir.boolValue
    }
    
    /// Checks if URL points to regular file.
    var isRegularFileURL: Bool {
        guard isFileURL else { return false }
        var isDir: ObjCBool = false
        return FileManager.default.fileExists(atPath: path, isDirectory: &isDir) && !isDir.boolValue
    }
    
    /// Checks if file at URL is readable.
    var isReadable: Bool {
        guard isFileURL else { return false }
        return FileManager.default.isReadableFile(atPath: path)
    }
    
    /// Checks if file at URL is writable.
    var isWritable: Bool {
        guard isFileURL else { return false }
        return FileManager.default.isWritableFile(atPath: path)
    }
    
    // MARK: - Extension Validation
    
    /// Checks if URL has specific file extension.
    ///
    /// - Parameter ext: Extension to check (without dot).
    /// - Returns: `true` if extension matches.
    func hasExtension(_ ext: String) -> Bool {
        return pathExtension.lowercased() == ext.lowercased()
    }
    
    /// Checks if URL has one of the specified extensions.
    func hasExtension(in extensions: [String]) -> Bool {
        let ext = pathExtension.lowercased()
        return extensions.map { $0.lowercased() }.contains(ext)
    }
    
    /// Checks if URL points to image file.
    var isImageURL: Bool {
        return hasExtension(in: ["jpg", "jpeg", "png", "gif", "webp", "bmp", "tiff", "heic"])
    }
    
    /// Checks if URL points to video file.
    var isVideoURL: Bool {
        return hasExtension(in: ["mp4", "mov", "avi", "mkv", "wmv", "flv", "webm"])
    }
    
    /// Checks if URL points to audio file.
    var isAudioURL: Bool {
        return hasExtension(in: ["mp3", "wav", "aac", "m4a", "flac", "ogg", "wma"])
    }
    
    /// Checks if URL points to document file.
    var isDocumentURL: Bool {
        return hasExtension(in: ["pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "txt", "rtf"])
    }
    
    // MARK: - Reachability
    
    /// Checks if URL is reachable (file URLs only).
    var isReachable: Bool {
        guard isFileURL else { return false }
        return (try? checkResourceIsReachable()) ?? false
    }
    
    /// Returns file size if URL is reachable file.
    var fileSize: Int64? {
        guard isFileURL else { return nil }
        let values = try? resourceValues(forKeys: [.fileSizeKey])
        return values?.fileSize.map { Int64($0) }
    }
    
    /// Returns creation date if URL is reachable file.
    var creationDate: Date? {
        guard isFileURL else { return nil }
        let values = try? resourceValues(forKeys: [.creationDateKey])
        return values?.creationDate
    }
    
    /// Returns modification date if URL is reachable file.
    var modificationDate: Date? {
        guard isFileURL else { return nil }
        let values = try? resourceValues(forKeys: [.contentModificationDateKey])
        return values?.contentModificationDate
    }
}

// MARK: - URL String Validation

public extension String {
    
    /// Checks if string is a valid URL.
    var isValidURLString: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil && url.host != nil
    }
    
    /// Checks if string is a valid HTTP(S) URL.
    var isValidWebURLString: Bool {
        guard let url = URL(string: self) else { return false }
        return url.isWebURL
    }
    
    /// Returns URL if string is valid.
    var asURL: URL? {
        return URL(string: self)
    }
    
    /// Returns URL with percent encoding applied.
    var asEncodedURL: URL? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).flatMap { URL(string: $0) }
    }
}
