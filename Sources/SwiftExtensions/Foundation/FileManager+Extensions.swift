import Foundation

// MARK: - FileManager Extensions

public extension FileManager {
    
    // MARK: - Common Directories
    
    /// Returns documents directory URL.
    var documentsDirectory: URL {
        return urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    /// Returns caches directory URL.
    var cachesDirectory: URL {
        return urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    /// Returns temporary directory URL.
    var tempDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    /// Returns application support directory URL.
    var applicationSupportDirectory: URL {
        let url = urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? createDirectory(at: url, withIntermediateDirectories: true)
        return url
    }
    
    /// Returns library directory URL.
    var libraryDirectory: URL {
        return urls(for: .libraryDirectory, in: .userDomainMask).first!
    }
    
    // MARK: - File Operations
    
    /// Checks if file exists at path.
    ///
    /// - Parameter path: File path.
    /// - Returns: `true` if file exists.
    func fileExistsAtPath(_ path: String) -> Bool {
        return fileExists(atPath: path)
    }
    
    /// Checks if file exists at URL.
    ///
    /// - Parameter url: File URL.
    /// - Returns: `true` if file exists.
    func fileExists(at url: URL) -> Bool {
        return fileExists(atPath: url.path)
    }
    
    /// Checks if directory exists at URL.
    ///
    /// - Parameter url: Directory URL.
    /// - Returns: `true` if directory exists.
    func directoryExists(at url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        return fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
    }
    
    /// Creates directory at URL with intermediate directories.
    ///
    /// - Parameter url: Directory URL.
    /// - Throws: Error if creation fails.
    func createDirectoryIfNeeded(at url: URL) throws {
        if !directoryExists(at: url) {
            try createDirectory(at: url, withIntermediateDirectories: true)
        }
    }
    
    // MARK: - Read/Write
    
    /// Writes data to file.
    ///
    /// - Parameters:
    ///   - data: Data to write.
    ///   - url: Destination URL.
    ///   - createDirectories: Create parent directories if needed.
    /// - Throws: Error if write fails.
    func write(_ data: Data, to url: URL, createDirectories: Bool = true) throws {
        if createDirectories {
            try createDirectoryIfNeeded(at: url.deletingLastPathComponent())
        }
        try data.write(to: url)
    }
    
    /// Reads data from file.
    ///
    /// - Parameter url: File URL.
    /// - Returns: File data.
    /// - Throws: Error if read fails.
    func read(from url: URL) throws -> Data {
        return try Data(contentsOf: url)
    }
    
    /// Writes string to file.
    ///
    /// - Parameters:
    ///   - string: String to write.
    ///   - url: Destination URL.
    ///   - encoding: String encoding.
    /// - Throws: Error if write fails.
    func write(_ string: String, to url: URL, encoding: String.Encoding = .utf8) throws {
        try string.write(to: url, atomically: true, encoding: encoding)
    }
    
    /// Reads string from file.
    ///
    /// - Parameters:
    ///   - url: File URL.
    ///   - encoding: String encoding.
    /// - Returns: File contents as string.
    /// - Throws: Error if read fails.
    func readString(from url: URL, encoding: String.Encoding = .utf8) throws -> String {
        return try String(contentsOf: url, encoding: encoding)
    }
    
    // MARK: - Copy/Move/Delete
    
    /// Copies file with overwrite option.
    ///
    /// - Parameters:
    ///   - source: Source URL.
    ///   - destination: Destination URL.
    ///   - overwrite: Overwrite if exists.
    /// - Throws: Error if copy fails.
    func copy(from source: URL, to destination: URL, overwrite: Bool = false) throws {
        if overwrite && fileExists(at: destination) {
            try removeItem(at: destination)
        }
        try copyItem(at: source, to: destination)
    }
    
    /// Moves file with overwrite option.
    ///
    /// - Parameters:
    ///   - source: Source URL.
    ///   - destination: Destination URL.
    ///   - overwrite: Overwrite if exists.
    /// - Throws: Error if move fails.
    func move(from source: URL, to destination: URL, overwrite: Bool = false) throws {
        if overwrite && fileExists(at: destination) {
            try removeItem(at: destination)
        }
        try moveItem(at: source, to: destination)
    }
    
    /// Deletes file if it exists.
    ///
    /// - Parameter url: File URL.
    /// - Returns: `true` if file was deleted.
    @discardableResult
    func deleteIfExists(at url: URL) -> Bool {
        guard fileExists(at: url) else { return false }
        do {
            try removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - File Info
    
    /// Returns file size in bytes.
    ///
    /// - Parameter url: File URL.
    /// - Returns: File size or nil.
    func fileSize(at url: URL) -> Int64? {
        guard let attrs = try? attributesOfItem(atPath: url.path),
              let size = attrs[.size] as? Int64 else { return nil }
        return size
    }
    
    /// Returns formatted file size.
    ///
    /// - Parameter url: File URL.
    /// - Returns: Formatted size string.
    func formattedFileSize(at url: URL) -> String? {
        guard let size = fileSize(at: url) else { return nil }
        return ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
    
    /// Returns file creation date.
    ///
    /// - Parameter url: File URL.
    /// - Returns: Creation date or nil.
    func creationDate(at url: URL) -> Date? {
        guard let attrs = try? attributesOfItem(atPath: url.path) else { return nil }
        return attrs[.creationDate] as? Date
    }
    
    /// Returns file modification date.
    ///
    /// - Parameter url: File URL.
    /// - Returns: Modification date or nil.
    func modificationDate(at url: URL) -> Date? {
        guard let attrs = try? attributesOfItem(atPath: url.path) else { return nil }
        return attrs[.modificationDate] as? Date
    }
    
    // MARK: - Directory Contents
    
    /// Returns contents of directory.
    ///
    /// - Parameters:
    ///   - url: Directory URL.
    ///   - includingHidden: Include hidden files.
    /// - Returns: Array of file URLs.
    func contentsOfDirectory(
        at url: URL,
        includingHidden: Bool = false
    ) throws -> [URL] {
        var options: DirectoryEnumerationOptions = [.skipsSubdirectoryDescendants]
        if !includingHidden {
            options.insert(.skipsHiddenFiles)
        }
        return try contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: options)
    }
    
    /// Returns all files in directory with extension.
    ///
    /// - Parameters:
    ///   - url: Directory URL.
    ///   - ext: File extension.
    /// - Returns: Array of matching file URLs.
    func files(in url: URL, withExtension ext: String) throws -> [URL] {
        return try contentsOfDirectory(at: url).filter { $0.pathExtension == ext }
    }
    
    // MARK: - Disk Space
    
    /// Returns available disk space in bytes.
    var availableDiskSpace: Int64? {
        guard let attrs = try? attributesOfFileSystem(forPath: NSHomeDirectory()),
              let space = attrs[.systemFreeSize] as? Int64 else { return nil }
        return space
    }
    
    /// Returns total disk space in bytes.
    var totalDiskSpace: Int64? {
        guard let attrs = try? attributesOfFileSystem(forPath: NSHomeDirectory()),
              let space = attrs[.systemSize] as? Int64 else { return nil }
        return space
    }
}
