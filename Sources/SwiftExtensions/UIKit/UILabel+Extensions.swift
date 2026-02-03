//
//  UILabel+Extensions.swift
//  SwiftExtensions
//
//  Created by Muhittin Camdali
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Text Styling

public extension UILabel {
    
    /// Set text with line height
    func setText(_ text: String, lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font as Any,
            .foregroundColor: textColor as Any
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Set text with letter spacing
    func setText(_ text: String, letterSpacing: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: letterSpacing,
            .font: font as Any,
            .foregroundColor: textColor as Any
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Set text with line height and letter spacing
    func setText(_ text: String, lineHeight: CGFloat, letterSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .kern: letterSpacing,
            .font: font as Any,
            .foregroundColor: textColor as Any
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Set strikethrough text
    func setStrikethrough(_ text: String, color: UIColor? = nil) {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: color ?? textColor as Any,
            .font: font as Any,
            .foregroundColor: textColor as Any
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Set underlined text
    func setUnderline(_ text: String, style: NSUnderlineStyle = .single, color: UIColor? = nil) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: style.rawValue,
            .underlineColor: color ?? textColor as Any,
            .font: font as Any,
            .foregroundColor: textColor as Any
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}

// MARK: - Attributed Text Helpers

public extension UILabel {
    
    /// Highlight substring with color
    func highlight(_ substring: String, color: UIColor) {
        guard let text = text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: substring)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        attributedText = attributedString
    }
    
    /// Highlight substring with font and color
    func highlight(_ substring: String, font: UIFont, color: UIColor? = nil) {
        guard let text = text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: substring)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(.font, value: font, range: range)
            if let color = color {
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        
        attributedText = attributedString
    }
    
    /// Highlight all occurrences of substring
    func highlightAll(_ substring: String, color: UIColor) {
        guard let text = text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        var searchRange = NSRange(location: 0, length: text.count)
        
        while searchRange.location < text.count {
            let range = (text as NSString).range(of: substring, options: [], range: searchRange)
            
            if range.location != NSNotFound {
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
                searchRange.location = range.location + range.length
                searchRange.length = text.count - searchRange.location
            } else {
                break
            }
        }
        
        attributedText = attributedString
    }
    
    /// Set attributed text with multiple styles
    func setAttributedText(parts: [(text: String, font: UIFont, color: UIColor)]) {
        let attributedString = NSMutableAttributedString()
        
        for part in parts {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: part.font,
                .foregroundColor: part.color
            ]
            let partString = NSAttributedString(string: part.text, attributes: attributes)
            attributedString.append(partString)
        }
        
        attributedText = attributedString
    }
    
    /// Add image at the beginning of text
    func addImagePrefix(_ image: UIImage, bounds: CGRect? = nil) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        if let bounds = bounds {
            attachment.bounds = bounds
        } else {
            let ratio = image.size.width / image.size.height
            let height = font.lineHeight
            attachment.bounds = CGRect(x: 0, y: (font.capHeight - height) / 2, width: height * ratio, height: height)
        }
        
        let imageString = NSAttributedString(attachment: attachment)
        let fullString = NSMutableAttributedString(attributedString: imageString)
        fullString.append(NSAttributedString(string: " \(text ?? "")"))
        
        attributedText = fullString
    }
    
    /// Add image at the end of text
    func addImageSuffix(_ image: UIImage, bounds: CGRect? = nil) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        if let bounds = bounds {
            attachment.bounds = bounds
        } else {
            let ratio = image.size.width / image.size.height
            let height = font.lineHeight
            attachment.bounds = CGRect(x: 0, y: (font.capHeight - height) / 2, width: height * ratio, height: height)
        }
        
        let fullString = NSMutableAttributedString(string: "\(text ?? "") ")
        fullString.append(NSAttributedString(attachment: attachment))
        
        attributedText = fullString
    }
}

// MARK: - Size Calculation

public extension UILabel {
    
    /// Calculate required height for given width
    func requiredHeight(forWidth width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// Calculate required width for given height
    func requiredWidth(forHeight height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: .greatestFiniteMagnitude, height: height))
        label.numberOfLines = numberOfLines
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width
    }
    
    /// Check if text is truncated
    var isTruncated: Bool {
        guard let text = text else { return false }
        
        let labelSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let textSize = (text as NSString).boundingRect(
            with: labelSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil
        ).size
        
        return textSize.height > bounds.height
    }
    
    /// Get number of visible lines
    var visibleLines: Int {
        guard let text = text, !text.isEmpty else { return 0 }
        
        let textSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let textHeight = (text as NSString).boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil
        ).height
        
        return Int(ceil(textHeight / font.lineHeight))
    }
}

// MARK: - Animation

public extension UILabel {
    
    /// Animate text change
    func setTextAnimated(_ text: String, duration: TimeInterval = 0.3) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.text = text
        }
    }
    
    /// Animate attributed text change
    func setAttributedTextAnimated(_ attributedText: NSAttributedString, duration: TimeInterval = 0.3) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.attributedText = attributedText
        }
    }
    
    /// Typewriter effect
    func typewrite(_ text: String, characterDelay: TimeInterval = 0.05, completion: (() -> Void)? = nil) {
        self.text = ""
        
        var characterIndex = 0
        let characters = Array(text)
        
        Timer.scheduledTimer(withTimeInterval: characterDelay, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if characterIndex < characters.count {
                self.text?.append(characters[characterIndex])
                characterIndex += 1
            } else {
                timer.invalidate()
                completion?()
            }
        }
    }
    
    /// Count animation for numbers
    func countAnimation(from: Int, to: Int, duration: TimeInterval = 1.0, format: String = "%d") {
        let startTime = Date()
        let difference = to - from
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            let elapsed = Date().timeIntervalSince(startTime)
            let progress = min(elapsed / duration, 1.0)
            
            let currentValue = from + Int(Double(difference) * progress)
            self.text = String(format: format, currentValue)
            
            if progress >= 1.0 {
                timer.invalidate()
                self.text = String(format: format, to)
            }
        }
        
        RunLoop.current.add(timer, forMode: .common)
    }
    
    /// Fade in animation
    func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }) { _ in
            completion?()
        }
    }
    
    /// Fade out animation
    func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) { _ in
            completion?()
        }
    }
}

// MARK: - Gradient Text

public extension UILabel {
    
    /// Apply gradient to text
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        guard let text = text, !text.isEmpty else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.alignmentMode = textAlignment.caTextLayerAlignment
        textLayer.frame = bounds
        textLayer.contentsScale = UIScreen.main.scale
        
        gradientLayer.mask = textLayer
        
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        layer.addSublayer(gradientLayer)
        
        textColor = .clear
    }
}

// MARK: - Link Detection

public extension UILabel {
    
    /// Make label tappable for URL detection
    func enableURLDetection(linkColor: UIColor = .systemBlue, action: @escaping (URL) -> Void) {
        isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleURLTap(_:)))
        addGestureRecognizer(tap)
        
        objc_setAssociatedObject(self, &AssociatedKeys.urlAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.linkColor, linkColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        highlightURLs(color: linkColor)
    }
    
    private struct AssociatedKeys {
        static var urlAction = "urlAction"
        static var linkColor = "linkColor"
    }
    
    private func highlightURLs(color: UIColor) {
        guard let text = text else { return }
        
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector?.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) ?? []
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: font as Any,
            .foregroundColor: textColor as Any
        ])
        
        for match in matches {
            attributedString.addAttribute(.foregroundColor, value: color, range: match.range)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: match.range)
        }
        
        attributedText = attributedString
    }
    
    @objc private func handleURLTap(_ gesture: UITapGestureRecognizer) {
        guard let text = text,
              let action = objc_getAssociatedObject(self, &AssociatedKeys.urlAction) as? (URL) -> Void else { return }
        
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector?.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) ?? []
        
        let tapLocation = gesture.location(in: self)
        
        for match in matches {
            if let range = Range(match.range, in: text),
               let url = match.url {
                let textStorage = NSTextStorage(attributedString: attributedText ?? NSAttributedString(string: text))
                let layoutManager = NSLayoutManager()
                let textContainer = NSTextContainer(size: bounds.size)
                
                textStorage.addLayoutManager(layoutManager)
                layoutManager.addTextContainer(textContainer)
                
                textContainer.lineFragmentPadding = 0
                textContainer.maximumNumberOfLines = numberOfLines
                textContainer.lineBreakMode = lineBreakMode
                
                let glyphRange = layoutManager.glyphRange(forCharacterRange: match.range, actualCharacterRange: nil)
                let rect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
                
                if rect.contains(tapLocation) {
                    action(url)
                    return
                }
            }
        }
    }
}

// MARK: - Convenience Initializers

public extension UILabel {
    
    /// Create label with text and font
    convenience init(text: String, font: UIFont = .systemFont(ofSize: 17), color: UIColor = .label) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
    }
    
    /// Create multiline label
    convenience init(text: String, font: UIFont = .systemFont(ofSize: 17), color: UIColor = .label, alignment: NSTextAlignment = .left, lines: Int = 0) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
}

// MARK: - Copy to Clipboard

public extension UILabel {
    
    /// Enable long press to copy
    func enableCopyOnLongPress() {
        isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        becomeFirstResponder()
        
        let menuController = UIMenuController.shared
        menuController.showMenu(from: self, rect: bounds)
    }
    
    open override var canBecomeFirstResponder: Bool {
        true
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        action == #selector(copy(_:))
    }
    
    open override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
}

// MARK: - Helpers

private extension NSTextAlignment {
    
    var caTextLayerAlignment: CATextLayerAlignmentMode {
        switch self {
        case .left: return .left
        case .right: return .right
        case .center: return .center
        case .justified: return .justified
        case .natural: return .natural
        @unknown default: return .natural
        }
    }
}

#endif
