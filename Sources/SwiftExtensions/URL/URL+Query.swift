import Foundation

// MARK: - URL Query Extensions

public extension URL {
    
    // MARK: - Query Parameter Access
    
    /// Returns all query parameters as dictionary.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com?name=John&age=30")!
    /// url.queryParameters    // ["name": "John", "age": "30"]
    /// ```
    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return [:] }
        
        var params: [String: String] = [:]
        for item in queryItems {
            params[item.name] = item.value
        }
        return params
    }
    
    /// Returns query parameter value for key.
    ///
    /// - Parameter key: Parameter key.
    /// - Returns: Parameter value or nil.
    ///
    /// ```swift
    /// url.queryParameter("name")    // "John"
    /// ```
    func queryParameter(_ key: String) -> String? {
        return queryParameters[key]
    }
    
    /// Returns query parameter as Int.
    func queryParameterInt(_ key: String) -> Int? {
        return queryParameter(key).flatMap { Int($0) }
    }
    
    /// Returns query parameter as Double.
    func queryParameterDouble(_ key: String) -> Double? {
        return queryParameter(key).flatMap { Double($0) }
    }
    
    /// Returns query parameter as Bool.
    func queryParameterBool(_ key: String) -> Bool? {
        guard let value = queryParameter(key)?.lowercased() else { return nil }
        return value == "true" || value == "1" || value == "yes"
    }
    
    /// Returns query parameters as array (for repeated keys).
    ///
    /// ```swift
    /// // url = "https://example.com?tag=a&tag=b&tag=c"
    /// url.queryParameterArray("tag")    // ["a", "b", "c"]
    /// ```
    func queryParameterArray(_ key: String) -> [String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return [] }
        
        return queryItems
            .filter { $0.name == key }
            .compactMap { $0.value }
    }
    
    // MARK: - Query Parameter Modification
    
    /// Returns URL with added query parameter.
    ///
    /// - Parameters:
    ///   - key: Parameter key.
    ///   - value: Parameter value.
    /// - Returns: URL with added parameter.
    ///
    /// ```swift
    /// url.appendingQueryParameter("sort", value: "asc")
    /// ```
    func appendingQueryParameter(_ key: String, value: String?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: key, value: value))
        components.queryItems = queryItems
        
        return components.url ?? self
    }
    
    /// Returns URL with added query parameters.
    ///
    /// - Parameter parameters: Dictionary of parameters to add.
    /// - Returns: URL with added parameters.
    func appendingQueryParameters(_ parameters: [String: String?]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        var queryItems = components.queryItems ?? []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queryItems
        
        return components.url ?? self
    }
    
    /// Returns URL with query parameter set (replaces if exists).
    ///
    /// - Parameters:
    ///   - key: Parameter key.
    ///   - value: Parameter value.
    /// - Returns: URL with parameter set.
    func settingQueryParameter(_ key: String, value: String?) -> URL {
        return removingQueryParameter(key).appendingQueryParameter(key, value: value)
    }
    
    /// Returns URL with query parameters set (replaces existing).
    ///
    /// - Parameter parameters: Dictionary of parameters.
    /// - Returns: URL with parameters set.
    func settingQueryParameters(_ parameters: [String: String?]) -> URL {
        var result = self
        for (key, value) in parameters {
            result = result.settingQueryParameter(key, value: value)
        }
        return result
    }
    
    /// Returns URL with query parameter removed.
    ///
    /// - Parameter key: Parameter key to remove.
    /// - Returns: URL without parameter.
    func removingQueryParameter(_ key: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        components.queryItems = components.queryItems?.filter { $0.name != key }
        if components.queryItems?.isEmpty == true {
            components.queryItems = nil
        }
        
        return components.url ?? self
    }
    
    /// Returns URL with all query parameters removed.
    var removingAllQueryParameters: URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        components.queryItems = nil
        return components.url ?? self
    }
    
    /// Returns URL with only specified query parameters kept.
    ///
    /// - Parameter keys: Keys to keep.
    /// - Returns: URL with only specified parameters.
    func keepingOnlyQueryParameters(_ keys: Set<String>) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        components.queryItems = components.queryItems?.filter { keys.contains($0.name) }
        if components.queryItems?.isEmpty == true {
            components.queryItems = nil
        }
        
        return components.url ?? self
    }
    
    // MARK: - Query String
    
    /// Returns query string portion of URL.
    var queryString: String? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)?.query
    }
    
    /// Returns URL with new query string.
    ///
    /// - Parameter queryString: New query string (without ?).
    /// - Returns: URL with new query string.
    func withQueryString(_ queryString: String?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        components.query = queryString
        return components.url ?? self
    }
    
    // MARK: - Query Items
    
    /// Returns all query items.
    var queryItems: [URLQueryItem]? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)?.queryItems
    }
    
    /// Returns URL with new query items.
    ///
    /// - Parameter items: New query items.
    /// - Returns: URL with new query items.
    func withQueryItems(_ items: [URLQueryItem]?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        
        components.queryItems = items
        return components.url ?? self
    }
}

// MARK: - URL Creation from Query Parameters

public extension URL {
    
    /// Creates URL with query parameters.
    ///
    /// - Parameters:
    ///   - baseURL: Base URL string.
    ///   - parameters: Query parameters.
    /// - Returns: URL with parameters or nil.
    init?(baseURL: String, parameters: [String: String]) {
        guard var components = URLComponents(string: baseURL) else { return nil }
        
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else { return nil }
        self = url
    }
    
    /// Creates URL from components.
    ///
    /// - Parameters:
    ///   - scheme: URL scheme (http, https).
    ///   - host: Host name.
    ///   - path: Path.
    ///   - parameters: Query parameters.
    /// - Returns: Constructed URL or nil.
    init?(
        scheme: String = "https",
        host: String,
        path: String = "",
        parameters: [String: String] = [:]
    ) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.hasPrefix("/") ? path : "/\(path)"
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else { return nil }
        self = url
    }
}
