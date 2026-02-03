import Foundation

// MARK: - NotificationCenter Extensions

public extension NotificationCenter {
    
    // MARK: - Type-Safe Observation
    
    /// Adds observer for notification name with closure.
    ///
    /// - Parameters:
    ///   - name: Notification name.
    ///   - object: Object to observe (optional).
    ///   - queue: Operation queue (default: main).
    ///   - handler: Handler closure.
    /// - Returns: Observation token (store to keep observation alive).
    ///
    /// ```swift
    /// let token = NotificationCenter.default.observe(.myNotification) { notification in
    ///     print("Received: \(notification)")
    /// }
    /// ```
    @discardableResult
    func observe(
        _ name: Notification.Name,
        object: Any? = nil,
        queue: OperationQueue? = .main,
        handler: @escaping (Notification) -> Void
    ) -> NotificationToken {
        let token = addObserver(forName: name, object: object, queue: queue, using: handler)
        return NotificationToken(notificationCenter: self, token: token)
    }
    
    /// Adds observer for multiple notification names.
    ///
    /// - Parameters:
    ///   - names: Array of notification names.
    ///   - object: Object to observe.
    ///   - queue: Operation queue.
    ///   - handler: Handler closure.
    /// - Returns: Array of observation tokens.
    @discardableResult
    func observe(
        _ names: [Notification.Name],
        object: Any? = nil,
        queue: OperationQueue? = .main,
        handler: @escaping (Notification) -> Void
    ) -> [NotificationToken] {
        return names.map { observe($0, object: object, queue: queue, handler: handler) }
    }
    
    // MARK: - Post Helpers
    
    /// Posts notification with name.
    ///
    /// - Parameters:
    ///   - name: Notification name.
    ///   - object: Sender object.
    ///   - userInfo: User info dictionary.
    func post(_ name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        post(name: name, object: object, userInfo: userInfo)
    }
    
    /// Posts notification asynchronously on main queue.
    ///
    /// - Parameters:
    ///   - name: Notification name.
    ///   - object: Sender object.
    ///   - userInfo: User info dictionary.
    func postOnMain(_ name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        DispatchQueue.main.async {
            self.post(name, object: object, userInfo: userInfo)
        }
    }
    
    /// Posts notification asynchronously with delay.
    ///
    /// - Parameters:
    ///   - name: Notification name.
    ///   - delay: Delay in seconds.
    ///   - object: Sender object.
    ///   - userInfo: User info dictionary.
    func post(_ name: Notification.Name, after delay: TimeInterval, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.post(name, object: object, userInfo: userInfo)
        }
    }
    
    // MARK: - One-Time Observation
    
    /// Observes notification once and automatically removes observer.
    ///
    /// - Parameters:
    ///   - name: Notification name.
    ///   - object: Object to observe.
    ///   - queue: Operation queue.
    ///   - handler: Handler closure.
    func observeOnce(
        _ name: Notification.Name,
        object: Any? = nil,
        queue: OperationQueue? = .main,
        handler: @escaping (Notification) -> Void
    ) {
        var token: NSObjectProtocol?
        token = addObserver(forName: name, object: object, queue: queue) { [weak self] notification in
            handler(notification)
            if let token = token {
                self?.removeObserver(token)
            }
        }
    }
    
    // MARK: - Async Observation
    
    /// Waits for notification asynchronously.
    ///
    /// - Parameters:
    ///   - name: Notification name.
    ///   - object: Object to observe.
    ///   - timeout: Timeout in seconds (optional).
    /// - Returns: Received notification or nil if timeout.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func waitForNotification(
        _ name: Notification.Name,
        object: Any? = nil,
        timeout: TimeInterval? = nil
    ) async -> Notification? {
        return await withCheckedContinuation { continuation in
            var token: NSObjectProtocol?
            var timerToken: Any?
            
            token = addObserver(forName: name, object: object, queue: .main) { [weak self] notification in
                if let token = token {
                    self?.removeObserver(token)
                }
                if let timer = timerToken as? Timer {
                    timer.invalidate()
                }
                continuation.resume(returning: notification)
            }
            
            if let timeout = timeout {
                timerToken = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { [weak self] _ in
                    if let token = token {
                        self?.removeObserver(token)
                    }
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}

// MARK: - Notification Token

/// Token for managing notification observation lifetime.
public final class NotificationToken: NSObject {
    private let notificationCenter: NotificationCenter
    private let token: Any
    
    init(notificationCenter: NotificationCenter, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }
    
    deinit {
        invalidate()
    }
    
    /// Manually invalidates the observation.
    public func invalidate() {
        notificationCenter.removeObserver(token)
    }
}

// MARK: - Notification Name Helpers

public extension Notification.Name {
    
    /// Creates notification name from string.
    ///
    /// - Parameter name: Name string.
    init(_ name: String) {
        self.init(rawValue: name)
    }
    
    /// Creates notification name from type.
    ///
    /// - Parameter type: Type to use for name.
    static func named<T>(_ type: T.Type) -> Notification.Name {
        return Notification.Name(String(describing: type))
    }
}

// MARK: - Notification User Info Helpers

public extension Notification {
    
    /// Returns typed value from userInfo.
    ///
    /// - Parameter key: User info key.
    /// - Returns: Typed value or nil.
    func userInfo<T>(for key: String) -> T? {
        return userInfo?[key] as? T
    }
    
    /// Returns string from userInfo.
    func userInfoString(for key: String) -> String? {
        return userInfo(for: key)
    }
    
    /// Returns int from userInfo.
    func userInfoInt(for key: String) -> Int? {
        return userInfo(for: key)
    }
    
    /// Returns bool from userInfo.
    func userInfoBool(for key: String) -> Bool? {
        return userInfo(for: key)
    }
}
