#if canImport(UIKit)
import UIKit

extension UIView {

    /// Rounds all corners with the given radius.
    ///
    /// - Parameter radius: Corner radius in points.
    public func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    /// Adds a shadow to the view.
    ///
    /// - Parameters:
    ///   - color: Shadow color. Defaults to `.black`.
    ///   - opacity: Shadow opacity (0.0 to 1.0). Defaults to `0.3`.
    ///   - offset: Shadow offset. Defaults to `(0, 2)`.
    ///   - radius: Shadow blur radius. Defaults to `4`.
    public func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.3,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }

    /// Adds a border to the view.
    ///
    /// - Parameters:
    ///   - color: Border color.
    ///   - width: Border width in points.
    public func addBorder(color: UIColor, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    /// Fades the view in with an animation.
    ///
    /// - Parameters:
    ///   - duration: Animation duration in seconds.
    ///   - completion: Called when the animation finishes.
    public func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration, animations: { self.alpha = 1 }) { _ in
            completion?()
        }
    }

    /// Fades the view out with an animation.
    ///
    /// - Parameters:
    ///   - duration: Animation duration in seconds.
    ///   - completion: Called when the animation finishes.
    public func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { self.alpha = 0 }) { _ in
            self.isHidden = true
            completion?()
        }
    }

    /// Pins the view to its superview's edges with optional padding.
    ///
    /// - Parameter padding: Inset from each edge. Defaults to `0`.
    public func pinToSuperview(padding: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
    }

    /// Makes the view circular by setting the corner radius to half its width.
    public func makeCircular() {
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }

    /// Removes all subviews from the view.
    public func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
#endif
