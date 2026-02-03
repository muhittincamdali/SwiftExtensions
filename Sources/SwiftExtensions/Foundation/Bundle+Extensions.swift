import Foundation

// MARK: - Bundle Extensions

public extension Bundle {
    
    // MARK: - App Info
    
    /// Returns app name.
    var appName: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    /// Returns app display name.
    var displayName: String {
        return infoDictionary?["CFBundleDisplayName"] as? String ?? appName
    }
    
    /// Returns app version string (e.g., "1.2.3").
    var appVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    /// Returns build number string (e.g., "42").
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    /// Returns full version string (e.g., "1.2.3 (42)").
    var fullVersion: String {
        return "\(appVersion) (\(buildNumber))"
    }
    
    /// Returns bundle identifier.
    var identifier: String {
        return bundleIdentifier ?? ""
    }
    
    // MARK: - Info Dictionary Access
    
    /// Returns value from Info.plist.
    ///
    /// - Parameter key: Info.plist key.
    /// - Returns: Value or nil.
    func info<T>(for key: String) -> T? {
        return infoDictionary?[key] as? T
    }
    
    /// Returns string from Info.plist.
    func infoString(for key: String) -> String? {
        return info(for: key)
    }
    
    /// Returns bool from Info.plist.
    func infoBool(for key: String) -> Bool {
        return info(for: key) ?? false
    }
    
    // MARK: - Resource Access
    
    /// Returns URL for resource with name and extension.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - ext: File extension.
    /// - Returns: Resource URL or nil.
    func resourceURL(name: String, extension ext: String) -> URL? {
        return url(forResource: name, withExtension: ext)
    }
    
    /// Returns data from resource file.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - ext: File extension.
    /// - Returns: File data or nil.
    func resourceData(name: String, extension ext: String) -> Data? {
        guard let url = resourceURL(name: name, extension: ext) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    /// Returns string from resource file.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - ext: File extension.
    ///   - encoding: String encoding.
    /// - Returns: File contents as string.
    func resourceString(name: String, extension ext: String, encoding: String.Encoding = .utf8) -> String? {
        guard let data = resourceData(name: name, extension: ext) else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    /// Returns JSON object from resource file.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - ext: File extension (default: "json").
    /// - Returns: JSON object.
    func resourceJSON(name: String, extension ext: String = "json") -> Any? {
        guard let data = resourceData(name: name, extension: ext) else { return nil }
        return try? JSONSerialization.jsonObject(with: data)
    }
    
    /// Decodes JSON resource to Codable type.
    ///
    /// - Parameters:
    ///   - type: Type to decode.
    ///   - name: Resource name.
    ///   - ext: File extension (default: "json").
    /// - Returns: Decoded object or nil.
    func resourceDecoded<T: Decodable>(_ type: T.Type, name: String, extension ext: String = "json") -> T? {
        guard let data = resourceData(name: name, extension: ext) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
    
    // MARK: - Localization
    
    /// Returns localized string.
    ///
    /// - Parameters:
    ///   - key: Localization key.
    ///   - table: Localization table (optional).
    /// - Returns: Localized string.
    func localizedString(_ key: String, table: String? = nil) -> String {
        return localizedString(forKey: key, value: nil, table: table)
    }
    
    /// Returns bundle for specific language.
    ///
    /// - Parameter language: Language code (e.g., "en", "fr").
    /// - Returns: Language-specific bundle or nil.
    func bundle(for language: String) -> Bundle? {
        guard let path = path(forResource: language, ofType: "lproj") else { return nil }
        return Bundle(path: path)
    }
    
    // MARK: - File Existence
    
    /// Checks if resource exists.
    ///
    /// - Parameters:
    ///   - name: Resource name.
    ///   - ext: File extension.
    /// - Returns: `true` if resource exists.
    func resourceExists(name: String, extension ext: String) -> Bool {
        return url(forResource: name, withExtension: ext) != nil
    }
    
    // MARK: - All Resources
    
    /// Returns URLs for all resources with extension.
    ///
    /// - Parameter ext: File extension.
    /// - Returns: Array of resource URLs.
    func allResourceURLs(extension ext: String) -> [URL] {
        return urls(forResourcesWithExtension: ext, subdirectory: nil) ?? []
    }
    
    /// Returns URLs for all resources in subdirectory.
    ///
    /// - Parameters:
    ///   - ext: File extension.
    ///   - subdirectory: Subdirectory name.
    /// - Returns: Array of resource URLs.
    func allResourceURLs(extension ext: String, subdirectory: String) -> [URL] {
        return urls(forResourcesWithExtension: ext, subdirectory: subdirectory) ?? []
    }
}

// MARK: - Static Helpers

public extension Bundle {
    
    /// Returns main bundle app name.
    static var appName: String {
        return main.appName
    }
    
    /// Returns main bundle app version.
    static var appVersion: String {
        return main.appVersion
    }
    
    /// Returns main bundle build number.
    static var buildNumber: String {
        return main.buildNumber
    }
    
    /// Returns main bundle full version.
    static var fullVersion: String {
        return main.fullVersion
    }
    
    /// Returns main bundle identifier.
    static var appIdentifier: String {
        return main.identifier
    }
}
