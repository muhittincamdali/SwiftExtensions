//
//  UIViewController+Extensions.swift
//  SwiftExtensions
//
//  Created by Muhittin Camdali
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Navigation

public extension UIViewController {
    
    /// Returns the topmost presented view controller
    var topPresentedViewController: UIViewController {
        var top = self
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
    
    /// Returns the topmost view controller in the app's key window
    static var topViewController: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let rootViewController = window.rootViewController else {
            return nil
        }
        return rootViewController.topPresentedViewController
    }
    
    /// Push a view controller with completion handler
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController?.pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
    
    /// Pop view controller with completion handler
    func popViewController(animated: Bool, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
    
    /// Pop to root view controller with completion handler
    func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
        navigationController?.popToRootViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
    
    /// Present a view controller with completion on animation end
    func present(_ viewController: UIViewController, animated: Bool, style: UIModalPresentationStyle, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = style
        present(viewController, animated: animated, completion: completion)
    }
    
    /// Dismiss all presented view controllers
    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
        var current: UIViewController? = self
        while let presenting = current?.presentingViewController {
            current = presenting
        }
        current?.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - Child View Controllers

public extension UIViewController {
    
    /// Add a child view controller
    func addChild(_ child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
    
    /// Remove a child view controller
    func removeChild(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    /// Add a child view controller with insets
    func addChild(_ child: UIViewController, to containerView: UIView, insets: UIEdgeInsets) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: insets.left),
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -insets.right),
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -insets.bottom)
        ])
        child.didMove(toParent: self)
    }
    
    /// Remove all child view controllers
    func removeAllChildren() {
        children.forEach { removeChild($0) }
    }
    
    /// Transition from one child view controller to another
    func transition(from fromVC: UIViewController, to toVC: UIViewController, duration: TimeInterval, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: ((Bool) -> Void)? = nil) {
        fromVC.willMove(toParent: nil)
        addChild(toVC)
        
        transition(from: fromVC, to: toVC, duration: duration, options: options) { finished in
            fromVC.removeFromParent()
            toVC.didMove(toParent: self)
            completion?(finished)
        }
    }
}

// MARK: - Alerts

public extension UIViewController {
    
    /// Show a simple alert with title and message
    func showAlert(title: String?, message: String?, actionTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    /// Show an alert with multiple actions
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    
    /// Show a confirmation dialog with cancel and confirm actions
    func showConfirmation(title: String?, message: String?, confirmTitle: String = "Confirm", cancelTitle: String = "Cancel", destructive: Bool = false, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            completion(false)
        })
        
        alert.addAction(UIAlertAction(title: confirmTitle, style: destructive ? .destructive : .default) { _ in
            completion(true)
        })
        
        present(alert, animated: true)
    }
    
    /// Show an action sheet
    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceView: UIView? = nil) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { actionSheet.addAction($0) }
        
        if let popover = actionSheet.popoverPresentationController {
            popover.sourceView = sourceView ?? view
            popover.sourceRect = sourceView?.bounds ?? CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        }
        
        present(actionSheet, animated: true)
    }
    
    /// Show an alert with text field
    func showTextFieldAlert(title: String?, message: String?, placeholder: String?, text: String? = nil, keyboardType: UIKeyboardType = .default, completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = text
            textField.keyboardType = keyboardType
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil)
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion(alert.textFields?.first?.text)
        })
        
        present(alert, animated: true)
    }
    
    /// Show error alert
    func showError(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    /// Show error alert with custom title
    func showError(_ error: Error, title: String) {
        showAlert(title: title, message: error.localizedDescription)
    }
}

// MARK: - Keyboard

public extension UIViewController {
    
    /// Add keyboard observers for adjusting views
    func addKeyboardObservers(willShow: @escaping (CGFloat, TimeInterval) -> Void, willHide: @escaping (TimeInterval) -> Void) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            guard let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                  let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
            willShow(keyboardFrame.height, duration)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            guard let userInfo = notification.userInfo,
                  let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
            willHide(duration)
        }
    }
    
    /// Remove keyboard observers
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Dismiss keyboard when tapping outside
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Navigation Bar

public extension UIViewController {
    
    /// Set navigation bar transparent
    func setTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    /// Reset navigation bar to default
    func resetNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    /// Set navigation bar color
    func setNavigationBarColor(_ color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    /// Hide navigation bar
    func hideNavigationBar(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// Show navigation bar
    func showNavigationBar(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /// Set back button title
    func setBackButtonTitle(_ title: String) {
        navigationItem.backButtonTitle = title
    }
    
    /// Hide back button
    func hideBackButton() {
        navigationItem.hidesBackButton = true
    }
    
    /// Add large title
    func enableLargeTitles() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    /// Disable large titles
    func disableLargeTitles() {
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - Status Bar

public extension UIViewController {
    
    /// Check if status bar is hidden
    var isStatusBarHidden: Bool {
        prefersStatusBarHidden
    }
    
    /// Get status bar height
    var statusBarHeight: CGFloat {
        view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}

// MARK: - Safe Area

public extension UIViewController {
    
    /// Get safe area insets
    var safeAreaInsets: UIEdgeInsets {
        view.safeAreaInsets
    }
    
    /// Get safe area layout guide
    var safeArea: UILayoutGuide {
        view.safeAreaLayoutGuide
    }
    
    /// Safe area top inset
    var safeAreaTop: CGFloat {
        view.safeAreaInsets.top
    }
    
    /// Safe area bottom inset
    var safeAreaBottom: CGFloat {
        view.safeAreaInsets.bottom
    }
}

// MARK: - Loading Indicator

public extension UIViewController {
    
    private static var loadingViewTag: Int { 999999 }
    
    /// Show loading indicator
    func showLoading(message: String? = nil) {
        guard view.viewWithTag(Self.loadingViewTag) == nil else { return }
        
        let loadingView = UIView()
        loadingView.tag = Self.loadingViewTag
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(activityIndicator)
        loadingView.addSubview(containerView)
        view.addSubview(loadingView)
        
        var constraints: [NSLayoutConstraint] = [
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ]
        
        if let message = message {
            let label = UILabel()
            label.text = message
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14)
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(label)
            
            constraints.append(contentsOf: [
                label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 12),
                label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            ])
        } else {
            constraints.append(contentsOf: [
                activityIndicator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
                containerView.widthAnchor.constraint(equalToConstant: 80),
                containerView.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
        
        NSLayoutConstraint.activate(constraints)
        
        loadingView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            loadingView.alpha = 1
        }
    }
    
    /// Hide loading indicator
    func hideLoading() {
        guard let loadingView = view.viewWithTag(Self.loadingViewTag) else { return }
        UIView.animate(withDuration: 0.2, animations: {
            loadingView.alpha = 0
        }) { _ in
            loadingView.removeFromSuperview()
        }
    }
    
    /// Check if loading indicator is visible
    var isLoading: Bool {
        view.viewWithTag(Self.loadingViewTag) != nil
    }
}

// MARK: - Toast Messages

public extension UIViewController {
    
    /// Show a toast message at the bottom of the screen
    func showToast(_ message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        
        let maxWidth = view.bounds.width - 40
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth - 32, height: .greatestFiniteMagnitude))
        toastLabel.frame = CGRect(
            x: (view.bounds.width - textSize.width - 32) / 2,
            y: view.bounds.height - safeAreaBottom - 100,
            width: textSize.width + 32,
            height: textSize.height + 16
        )
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
    /// Show a success toast
    func showSuccessToast(_ message: String, duration: TimeInterval = 2.0) {
        showToast("✓ " + message, duration: duration)
    }
    
    /// Show an error toast
    func showErrorToast(_ message: String, duration: TimeInterval = 2.0) {
        showToast("✗ " + message, duration: duration)
    }
}

// MARK: - Storyboard Instantiation

public extension UIViewController {
    
    /// Instantiate view controller from storyboard
    static func instantiate(storyboard: String = "Main", identifier: String? = nil, bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        let id = identifier ?? String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

// MARK: - Embed in Navigation Controller

public extension UIViewController {
    
    /// Embed in a navigation controller
    func embedInNavigationController() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }
    
    /// Embed in a navigation controller with custom appearance
    func embedInNavigationController(appearance: UINavigationBarAppearance) -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        return nav
    }
}

// MARK: - Share

public extension UIViewController {
    
    /// Present share sheet
    func share(items: [Any], sourceView: UIView? = nil, completion: UIActivityViewController.CompletionWithItemsHandler? = nil) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.completionWithItemsHandler = completion
        
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = sourceView ?? view
            popover.sourceRect = sourceView?.bounds ?? CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        }
        
        present(activityVC, animated: true)
    }
    
    /// Share text
    func shareText(_ text: String, sourceView: UIView? = nil) {
        share(items: [text], sourceView: sourceView)
    }
    
    /// Share URL
    func shareURL(_ url: URL, sourceView: UIView? = nil) {
        share(items: [url], sourceView: sourceView)
    }
    
    /// Share image
    func shareImage(_ image: UIImage, sourceView: UIView? = nil) {
        share(items: [image], sourceView: sourceView)
    }
}

// MARK: - Haptic Feedback

public extension UIViewController {
    
    /// Trigger impact feedback
    func impactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    /// Trigger notification feedback
    func notificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    /// Trigger selection feedback
    func selectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

// MARK: - Device State

public extension UIViewController {
    
    /// Check if device is in landscape orientation
    var isLandscape: Bool {
        view.bounds.width > view.bounds.height
    }
    
    /// Check if device is in portrait orientation
    var isPortrait: Bool {
        view.bounds.height > view.bounds.width
    }
    
    /// Check if running on iPad
    var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// Check if running on iPhone
    var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

#endif
