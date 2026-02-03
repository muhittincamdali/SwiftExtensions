import Foundation

// MARK: - URL Components Extensions

public extension URL {
    
    // MARK: - Component Access
    
    /// Returns URL scheme (http, https, ftp, etc.).
    var urlScheme: String? {
        return scheme
    }
    
    /// Returns URL host.
    var urlHost: String? {
        return host
    }
    
    /// Returns URL port.
    var urlPort: Int? {
        return port
    }
    
    /// Returns URL path.
    var urlPath: String {
        return path
    }
    
    /// Returns URL fragment (part after #).
    var urlFragment: String? {
        return fragment
    }
    
    /// Returns URL user component.
    var urlUser: String? {
        return user
    }
    
    /// Returns URL password component.
    var urlPassword: String? {
        return password
    }
    
    // MARK: - Path Operations
    
    /// Returns array of path components.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/users/123/profile")!
    /// url.pathSegments    // ["users", "123", "profile"]
    /// ```
    var pathSegments: [String] {
        return pathComponents.filter { $0 != "/" }
    }
    
    /// Returns path segment at index.
    ///
    /// - Parameter index: Segment index.
    /// - Returns: Path segment or nil.
    func pathSegment(at index: Int) -> String? {
        let segments = pathSegments
        guard index >= 0 && index < segments.count else { return nil }
        return segments[index]
    }
    
    /// Returns first path segment.
    var firstPathSegment: String? {
        return pathSegments.first
    }
    
    /// Returns last path segment.
    var lastPathSegment: String? {
        return pathSegments.last
    }
    
    /// Returns URL with appended path segment.
    ///
    /// - Parameter segment: Segment to append.
    /// - Returns: URL with appended segment.
    func appendingPathSegment(_ segment: String) -> URL {
        return appendingPathComponent(segment)
    }
    
    /// Returns URL with appended path segments.
    ///
    /// - Parameter segments: Segments to append.
    /// - Returns: URL with appended segments.
    func appendingPathSegments(_ segments: [String]) -> URL {
        var url = self
        for segment in segments {
            url = url.appendingPathComponent(segment)
        }
        return url
    }
    
    /// Returns URL with replaced path.
    ///
    /// - Parameter path: New path.
    /// - Returns: URL with new path.
    func withPath(_ path: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        components.path = path.hasPrefix("/") ? path : "/\(path)"
        return components.url ?? self
    }
    
    /// Returns URL with replaced last path component.
    ///
    /// - Parameter component: New last component.
    /// - Returns: URL with replaced component.
    func replacingLastPathComponent(with component: String) -> URL {
        return deletingLastPathComponent().appendingPathComponent(component)
    }
    
    // MARK: - File Extension Operations
    
    /// Returns URL with appended file extension.
    ///
    /// - Parameter ext: Extension to append (without dot).
    /// - Returns: URL with extension.
    func appendingFileExtension(_ ext: String) -> URL {
        return appendingPathExtension(ext)
    }
    
    /// Returns URL with replaced file extension.
    ///
    /// - Parameter ext: New extension (without dot).
    /// - Returns: URL with new extension.
    func replacingFileExtension(with ext: String) -> URL {
        return deletingPathExtension().appendingPathExtension(ext)
    }
    
    /// Returns file name without extension.
    var fileNameWithoutExtension: String {
        return deletingPathExtension().lastPathComponent
    }
    
    /// Returns file name with extension.
    var fileName: String {
        return lastPathComponent
    }
    
    // MARK: - Scheme Operations
    
    /// Returns URL with replaced scheme.
    ///
    /// - Parameter scheme: New scheme (http, https, etc.).
    /// - Returns: URL with new scheme.
    func withScheme(_ scheme: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        components.scheme = scheme
        return components.url ?? self
    }
    
    /// Returns HTTPS version of URL.
    var https: URL {
        return withScheme("https")
    }
    
    /// Returns HTTP version of URL.
    var http: URL {
        return withScheme("http")
    }
    
    // MARK: - Host Operations
    
    /// Returns URL with replaced host.
    ///
    /// - Parameter host: New host.
    /// - Returns: URL with new host.
    func withHost(_ host: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        components.host = host
        return components.url ?? self
    }
    
    /// Returns URL with replaced port.
    ///
    /// - Parameter port: New port (nil to remove).
    /// - Returns: URL with new port.
    func withPort(_ port: Int?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        components.port = port
        return components.url ?? self
    }
    
    // MARK: - Fragment Operations
    
    /// Returns URL with replaced fragment.
    ///
    /// - Parameter fragment: New fragment (without #).
    /// - Returns: URL with new fragment.
    func withFragment(_ fragment: String?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        components.fragment = fragment
        return components.url ?? self
    }
    
    /// Returns URL without fragment.
    var removingFragment: URL {
        return withFragment(nil)
    }
    
    // MARK: - Domain Components
    
    /// Returns top-level domain (com, org, etc.).
    var topLevelDomain: String? {
        return host?.split(separator: ".").last.map(String.init)
    }
    
    /// Returns domain without subdomain.
    var baseDomain: String? {
        guard let host = host else { return nil }
        let parts = host.split(separator: ".")
        guard parts.count >= 2 else { return host }
        return parts.suffix(2).joined(separator: ".")
    }
    
    /// Returns subdomain.
    var subdomain: String? {
        guard let host = host else { return nil }
        let parts = host.split(separator: ".")
        guard parts.count > 2 else { return nil }
        return parts.dropLast(2).joined(separator: ".")
    }
    
    // MARK: - Full Component Modification
    
    /// Returns URLComponents for this URL.
    var components: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)
    }
    
    /// Modifies URL using closure on components.
    ///
    /// - Parameter modify: Closure to modify components.
    /// - Returns: Modified URL or self if modification fails.
    func modifying(_ modify: (inout URLComponents) -> Void) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        modify(&components)
        return components.url ?? self
    }
}

// MARK: - URL Relative Operations

public extension URL {
    
    /// Returns URL relative to base URL.
    ///
    /// - Parameter base: Base URL.
    /// - Returns: Relative URL string or nil.
    func relativePath(from base: URL) -> String? {
        guard scheme == base.scheme,
              host == base.host,
              port == base.port else { return nil }
        
        let basePath = base.pathComponents
        let selfPath = pathComponents
        
        var commonCount = 0
        for (a, b) in zip(basePath, selfPath) {
            if a == b { commonCount += 1 }
            else { break }
        }
        
        let upCount = basePath.count - commonCount
        let relativeParts = Array(repeating: "..", count: upCount) + Array(selfPath.dropFirst(commonCount))
        
        return relativeParts.joined(separator: "/")
    }
    
    /// Returns URL resolved against base.
    ///
    /// - Parameter base: Base URL.
    /// - Returns: Resolved URL.
    func resolved(against base: URL) -> URL {
        return URL(string: absoluteString, relativeTo: base)?.absoluteURL ?? self
    }
}
