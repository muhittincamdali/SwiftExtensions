#if canImport(UIKit)
import UIKit

// MARK: - UIView Extensions

public extension UIView {
    
    // MARK: - Corner Radius
    
    /// Sets corner radius.
    ///
    /// - Parameter radius: Corner radius value.
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /// Sets corner radius for specific corners.
    ///
    /// - Parameters:
    ///   - corners: Corners to round.
    ///   - radius: Corner radius value.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// Makes view circular.
    func makeCircular() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
    /// Corner radius (IBInspectable).
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    // MARK: - Border
    
    /// Sets border.
    ///
    /// - Parameters:
    ///   - width: Border width.
    ///   - color: Border color.
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// Border width (IBInspectable).
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    /// Border color (IBInspectable).
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    // MARK: - Shadow
    
    /// Adds shadow to view.
    ///
    /// - Parameters:
    ///   - color: Shadow color.
    ///   - radius: Shadow blur radius.
    ///   - offset: Shadow offset.
    ///   - opacity: Shadow opacity (0-1).
    func addShadow(
        color: UIColor = .black,
        radius: CGFloat = 4,
        offset: CGSize = CGSize(width: 0, height: 2),
        opacity: Float = 0.2
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /// Removes shadow from view.
    func removeShadow() {
        layer.shadowColor = nil
        layer.shadowRadius = 0
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0
    }
    
    /// Shadow color (IBInspectable).
    @IBInspectable var shadowColor: UIColor? {
        get { return layer.shadowColor.map { UIColor(cgColor: $0) } }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    /// Shadow opacity (IBInspectable).
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    /// Shadow offset (IBInspectable).
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    /// Shadow radius (IBInspectable).
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    // MARK: - Frame Shortcuts
    
    /// View's x origin.
    var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    /// View's y origin.
    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    /// View's width.
    var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }
    
    /// View's height.
    var height: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue }
    }
    
    /// View's size.
    var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    
    /// View's origin.
    var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    // MARK: - Hierarchy
    
    /// Removes all subviews.
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// Returns all subviews of specific type.
    func subviews<T: UIView>(ofType type: T.Type) -> [T] {
        return subviews.compactMap { $0 as? T }
    }
    
    /// Returns all descendant views.
    var allSubviews: [UIView] {
        var views: [UIView] = []
        for subview in subviews {
            views.append(subview)
            views.append(contentsOf: subview.allSubviews)
        }
        return views
    }
    
    /// Returns parent view controller.
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            if let vc = next as? UIViewController {
                return vc
            }
            responder = next
        }
        return nil
    }
    
    // MARK: - Visibility
    
    /// Shows view (alpha = 1, isHidden = false).
    func show() {
        alpha = 1
        isHidden = false
    }
    
    /// Hides view (alpha = 0, isHidden = true).
    func hide() {
        alpha = 0
        isHidden = true
    }
    
    /// Fades in view.
    ///
    /// - Parameters:
    ///   - duration: Animation duration.
    ///   - completion: Completion handler.
    func fadeIn(duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// Fades out view.
    ///
    /// - Parameters:
    ///   - duration: Animation duration.
    ///   - completion: Completion handler.
    func fadeOut(duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.isHidden = true
            completion?(finished)
        })
    }
    
    // MARK: - Gestures
    
    /// Adds tap gesture recognizer.
    ///
    /// - Parameter action: Action closure.
    /// - Returns: The gesture recognizer.
    @discardableResult
    func addTapGesture(action: @escaping () -> Void) -> UITapGestureRecognizer {
        isUserInteractionEnabled = true
        let tap = TapGestureRecognizer(action: action)
        addGestureRecognizer(tap)
        return tap
    }
    
    // MARK: - Snapshot
    
    /// Creates snapshot image of view.
    ///
    /// - Parameter scale: Image scale.
    /// - Returns: Snapshot image.
    func snapshot(scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - Loading Indicator
    
    /// Shows activity indicator.
    ///
    /// - Parameter style: Indicator style.
    /// - Returns: The activity indicator view.
    @discardableResult
    func showActivityIndicator(style: UIActivityIndicatorView.Style = .medium) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.center = center
        indicator.tag = 999
        indicator.startAnimating()
        addSubview(indicator)
        return indicator
    }
    
    /// Hides activity indicator.
    func hideActivityIndicator() {
        subviews.first { $0.tag == 999 && $0 is UIActivityIndicatorView }?.removeFromSuperview()
    }
}

// MARK: - Tap Gesture Helper

private class TapGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(execute))
    }
    
    @objc private func execute() {
        action()
    }
}
#endif
