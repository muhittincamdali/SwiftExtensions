//
//  UIButton+Extensions.swift
//  SwiftExtensions
//
//  Created by Muhittin Camdali
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Title & Image

public extension UIButton {
    
    /// Set title for all states
    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .disabled)
        setTitle(title, for: .selected)
    }
    
    /// Set title color for all states
    func setTitleColor(_ color: UIColor?) {
        setTitleColor(color, for: .normal)
        setTitleColor(color?.withAlphaComponent(0.5), for: .highlighted)
        setTitleColor(color?.withAlphaComponent(0.3), for: .disabled)
    }
    
    /// Set image for all states
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .selected)
    }
    
    /// Set background image for all states
    func setBackgroundImage(_ image: UIImage?) {
        setBackgroundImage(image, for: .normal)
        setBackgroundImage(image, for: .highlighted)
        setBackgroundImage(image, for: .selected)
    }
    
    /// Set SF Symbol image
    @available(iOS 13.0, *)
    func setSystemImage(_ systemName: String, pointSize: CGFloat = 17, weight: UIImage.SymbolWeight = .regular) {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        let image = UIImage(systemName: systemName, withConfiguration: config)
        setImage(image, for: .normal)
    }
    
    /// Set attributed title for all states
    func setAttributedTitle(_ title: NSAttributedString?) {
        setAttributedTitle(title, for: .normal)
        setAttributedTitle(title, for: .highlighted)
        setAttributedTitle(title, for: .selected)
    }
}

// MARK: - Image Position

public extension UIButton {
    
    /// Position for image relative to title
    enum ImagePosition {
        case top
        case bottom
        case left
        case right
    }
    
    /// Set image position relative to title with spacing
    func setImagePosition(_ position: ImagePosition, spacing: CGFloat = 8) {
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        let imageSize = imageView.intrinsicContentSize
        let titleSize = titleLabel.intrinsicContentSize
        
        switch position {
        case .top:
            titleEdgeInsets = UIEdgeInsets(
                top: imageSize.height + spacing,
                left: -imageSize.width,
                bottom: 0,
                right: 0
            )
            imageEdgeInsets = UIEdgeInsets(
                top: -(titleSize.height + spacing),
                left: 0,
                bottom: 0,
                right: -titleSize.width
            )
            
        case .bottom:
            titleEdgeInsets = UIEdgeInsets(
                top: -(imageSize.height + spacing),
                left: -imageSize.width,
                bottom: 0,
                right: 0
            )
            imageEdgeInsets = UIEdgeInsets(
                top: titleSize.height + spacing,
                left: 0,
                bottom: 0,
                right: -titleSize.width
            )
            
        case .left:
            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: spacing / 2,
                bottom: 0,
                right: -spacing / 2
            )
            imageEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -spacing / 2,
                bottom: 0,
                right: spacing / 2
            )
            
        case .right:
            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -(imageSize.width + spacing / 2),
                bottom: 0,
                right: imageSize.width + spacing / 2
            )
            imageEdgeInsets = UIEdgeInsets(
                top: 0,
                left: titleSize.width + spacing / 2,
                bottom: 0,
                right: -(titleSize.width + spacing / 2)
            )
        }
    }
    
    /// Center image and title vertically with spacing
    func centerImageAndTitle(spacing: CGFloat = 8) {
        setImagePosition(.top, spacing: spacing)
    }
}

// MARK: - Styling

public extension UIButton {
    
    /// Apply rounded corners
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    /// Make button circular
    func makeCircular() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        clipsToBounds = true
    }
    
    /// Add border
    func addBorder(color: UIColor, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    /// Remove border
    func removeBorder() {
        layer.borderColor = nil
        layer.borderWidth = 0
    }
    
    /// Apply shadow
    func addShadow(color: UIColor = .black, opacity: Float = 0.2, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    /// Set background color for state
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let image = UIImage.from(color: color)
        setBackgroundImage(image, for: state)
    }
    
    /// Style as primary button
    func stylePrimary(backgroundColor: UIColor, titleColor: UIColor = .white, cornerRadius: CGFloat = 8) {
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor)
        roundCorners(radius: cornerRadius)
    }
    
    /// Style as secondary/outlined button
    func styleOutlined(borderColor: UIColor, titleColor: UIColor, cornerRadius: CGFloat = 8, borderWidth: CGFloat = 1) {
        backgroundColor = .clear
        setTitleColor(titleColor)
        addBorder(color: borderColor, width: borderWidth)
        roundCorners(radius: cornerRadius)
    }
    
    /// Style as text button
    func styleText(titleColor: UIColor) {
        backgroundColor = .clear
        setTitleColor(titleColor)
        removeBorder()
    }
    
    /// Apply gradient background
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Animation

public extension UIButton {
    
    /// Add tap animation
    func addTapAnimation(scale: CGFloat = 0.95, duration: TimeInterval = 0.1) {
        addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        addTarget(self, action: #selector(animateTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func animateTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func animateTouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
    
    /// Bounce animation
    func bounce(scale: CGFloat = 1.2, duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration / 2, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: duration / 2) {
                self.transform = .identity
            }
        }
    }
    
    /// Shake animation
    func shake(duration: TimeInterval = 0.5, intensity: CGFloat = 10) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.values = [-intensity, intensity, -intensity * 0.8, intensity * 0.8, -intensity * 0.5, intensity * 0.5, 0]
        layer.add(animation, forKey: "shake")
    }
    
    /// Pulse animation
    func pulse(scale: CGFloat = 1.1, duration: TimeInterval = 0.8, repeatCount: Float = .infinity) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.fromValue = 1.0
        animation.toValue = scale
        animation.autoreverses = true
        animation.repeatCount = repeatCount
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(animation, forKey: "pulse")
    }
    
    /// Stop pulse animation
    func stopPulse() {
        layer.removeAnimation(forKey: "pulse")
    }
}

// MARK: - Loading State

public extension UIButton {
    
    private struct AssociatedKeys {
        static var activityIndicator = "activityIndicator"
        static var originalTitle = "originalTitle"
        static var originalImage = "originalImage"
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.activityIndicator) as? UIActivityIndicatorView }
        set { objc_setAssociatedObject(self, &AssociatedKeys.activityIndicator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var originalTitle: String? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.originalTitle) as? String }
        set { objc_setAssociatedObject(self, &AssociatedKeys.originalTitle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var originalImage: UIImage? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.originalImage) as? UIImage }
        set { objc_setAssociatedObject(self, &AssociatedKeys.originalImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// Show loading state
    func showLoading(color: UIColor? = nil) {
        isUserInteractionEnabled = false
        originalTitle = title(for: .normal)
        originalImage = image(for: .normal)
        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)
        
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = color ?? titleColor(for: .normal)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        indicator.startAnimating()
        activityIndicator = indicator
    }
    
    /// Hide loading state
    func hideLoading() {
        isUserInteractionEnabled = true
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
        setTitle(originalTitle, for: .normal)
        setImage(originalImage, for: .normal)
    }
    
    /// Check if button is loading
    var isLoading: Bool {
        activityIndicator != nil
    }
}

// MARK: - Hit Area

public extension UIButton {
    
    private struct AssociatedKeysHit {
        static var hitTestInsets = "hitTestInsets"
    }
    
    /// Expanded hit test insets (negative values expand the hit area)
    var hitTestInsets: UIEdgeInsets {
        get { objc_getAssociatedObject(self, &AssociatedKeysHit.hitTestInsets) as? UIEdgeInsets ?? .zero }
        set { objc_setAssociatedObject(self, &AssociatedKeysHit.hitTestInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// Expand hit area by a uniform amount
    func expandHitArea(by amount: CGFloat) {
        hitTestInsets = UIEdgeInsets(top: -amount, left: -amount, bottom: -amount, right: -amount)
    }
    
    /// Set minimum hit area size (44x44 recommended for accessibility)
    func setMinimumHitArea(_ size: CGSize = CGSize(width: 44, height: 44)) {
        let widthDiff = max(0, size.width - bounds.width)
        let heightDiff = max(0, size.height - bounds.height)
        hitTestInsets = UIEdgeInsets(
            top: -heightDiff / 2,
            left: -widthDiff / 2,
            bottom: -heightDiff / 2,
            right: -widthDiff / 2
        )
    }
}

// MARK: - Action Closure

public extension UIButton {
    
    private struct AssociatedKeysAction {
        static var actionHandler = "actionHandler"
    }
    
    private var actionHandler: (() -> Void)? {
        get { objc_getAssociatedObject(self, &AssociatedKeysAction.actionHandler) as? () -> Void }
        set { objc_setAssociatedObject(self, &AssociatedKeysAction.actionHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// Add tap action with closure
    func onTap(_ action: @escaping () -> Void) {
        actionHandler = action
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        actionHandler?()
    }
    
    /// Remove tap action
    func removeTapAction() {
        actionHandler = nil
        removeTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
}

// MARK: - Badge

public extension UIButton {
    
    private struct AssociatedKeysBadge {
        static var badgeLabel = "badgeLabel"
    }
    
    private var badgeLabel: UILabel? {
        get { objc_getAssociatedObject(self, &AssociatedKeysBadge.badgeLabel) as? UILabel }
        set { objc_setAssociatedObject(self, &AssociatedKeysBadge.badgeLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /// Show badge with count
    func showBadge(count: Int, backgroundColor: UIColor = .red, textColor: UIColor = .white) {
        hideBadge()
        
        guard count > 0 else { return }
        
        let label = UILabel()
        label.text = count > 99 ? "99+" : "\(count)"
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        let size: CGFloat = count > 9 ? 20 : 18
        label.layer.cornerRadius = size / 2
        label.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: -4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            label.heightAnchor.constraint(equalToConstant: size),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: size)
        ])
        
        badgeLabel = label
    }
    
    /// Show dot badge
    func showDotBadge(color: UIColor = .red, size: CGFloat = 8) {
        hideBadge()
        
        let dot = UIView()
        dot.backgroundColor = color
        dot.layer.cornerRadius = size / 2
        dot.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dot)
        
        NSLayoutConstraint.activate([
            dot.topAnchor.constraint(equalTo: topAnchor, constant: -2),
            dot.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            dot.heightAnchor.constraint(equalToConstant: size),
            dot.widthAnchor.constraint(equalToConstant: size)
        ])
        
        let label = UILabel()
        label.isHidden = true
        addSubview(label)
        badgeLabel = label
    }
    
    /// Hide badge
    func hideBadge() {
        badgeLabel?.removeFromSuperview()
        badgeLabel = nil
        subviews.filter { $0.layer.cornerRadius > 0 && $0.bounds.width < 25 }.forEach { $0.removeFromSuperview() }
    }
    
    /// Update badge count
    func updateBadge(count: Int) {
        if let label = badgeLabel {
            label.text = count > 99 ? "99+" : "\(count)"
            label.isHidden = count <= 0
        } else {
            showBadge(count: count)
        }
    }
}

// MARK: - Countdown

public extension UIButton {
    
    /// Start countdown timer
    func startCountdown(seconds: Int, format: String = "%d s", completion: (() -> Void)? = nil) {
        isUserInteractionEnabled = false
        var remainingSeconds = seconds
        let originalTitle = title(for: .normal)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            remainingSeconds -= 1
            
            if remainingSeconds <= 0 {
                timer.invalidate()
                self.setTitle(originalTitle, for: .normal)
                self.isUserInteractionEnabled = true
                completion?()
            } else {
                self.setTitle(String(format: format, remainingSeconds), for: .normal)
            }
        }
        
        RunLoop.current.add(timer, forMode: .common)
        setTitle(String(format: format, remainingSeconds), for: .normal)
    }
}

// MARK: - Convenience Initializers

public extension UIButton {
    
    /// Create button with title
    convenience init(title: String, titleColor: UIColor = .systemBlue, font: UIFont = .systemFont(ofSize: 17)) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
    }
    
    /// Create button with SF Symbol
    @available(iOS 13.0, *)
    convenience init(systemName: String, pointSize: CGFloat = 17, weight: UIImage.SymbolWeight = .regular, tintColor: UIColor = .systemBlue) {
        self.init(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        let image = UIImage(systemName: systemName, withConfiguration: config)
        setImage(image, for: .normal)
        self.tintColor = tintColor
    }
    
    /// Create button with image
    convenience init(image: UIImage?, tintColor: UIColor? = nil) {
        self.init(type: .system)
        setImage(image, for: .normal)
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
    }
}

// MARK: - Helper

private extension UIImage {
    
    static func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

#endif
