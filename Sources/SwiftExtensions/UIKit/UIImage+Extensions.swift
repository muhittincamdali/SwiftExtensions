#if canImport(UIKit)
import UIKit

// MARK: - UIImage Extensions

public extension UIImage {
    
    // MARK: - Resizing
    
    /// Resizes image to target size.
    ///
    /// - Parameter size: Target size.
    /// - Returns: Resized image.
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Resizes image to fit within max dimension.
    ///
    /// - Parameter maxDimension: Maximum width or height.
    /// - Returns: Resized image.
    func resized(maxDimension: CGFloat) -> UIImage? {
        let aspectRatio = size.width / size.height
        var newSize: CGSize
        
        if size.width > size.height {
            newSize = CGSize(width: maxDimension, height: maxDimension / aspectRatio)
        } else {
            newSize = CGSize(width: maxDimension * aspectRatio, height: maxDimension)
        }
        
        return resized(to: newSize)
    }
    
    /// Resizes image by scale factor.
    ///
    /// - Parameter scale: Scale factor.
    /// - Returns: Scaled image.
    func scaled(by scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        return resized(to: newSize)
    }
    
    /// Resizes to fill target size (may crop).
    ///
    /// - Parameter size: Target size.
    /// - Returns: Resized image.
    func resizedToFill(_ size: CGSize) -> UIImage? {
        let aspectRatio = self.size.width / self.size.height
        let targetRatio = size.width / size.height
        
        var drawSize: CGSize
        
        if aspectRatio > targetRatio {
            drawSize = CGSize(width: size.height * aspectRatio, height: size.height)
        } else {
            drawSize = CGSize(width: size.width, height: size.width / aspectRatio)
        }
        
        let origin = CGPoint(
            x: (size.width - drawSize.width) / 2,
            y: (size.height - drawSize.height) / 2
        )
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: origin, size: drawSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - Cropping
    
    /// Crops image to rect.
    ///
    /// - Parameter rect: Crop rect.
    /// - Returns: Cropped image.
    func cropped(to rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
    }
    
    /// Crops image to square from center.
    var squareCropped: UIImage? {
        let side = min(size.width, size.height)
        let x = (size.width - side) / 2
        let y = (size.height - side) / 2
        return cropped(to: CGRect(x: x, y: y, width: side, height: side))
    }
    
    /// Crops image to circle.
    var circleCropped: UIImage? {
        guard let squared = squareCropped else { return nil }
        
        let size = squared.size
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        let path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size))
        path.addClip()
        squared.draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - Rotation
    
    /// Rotates image by degrees.
    ///
    /// - Parameter degrees: Rotation angle in degrees.
    /// - Returns: Rotated image.
    func rotated(by degrees: CGFloat) -> UIImage? {
        let radians = degrees * .pi / 180
        
        var newSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        
        draw(in: CGRect(
            x: -size.width / 2,
            y: -size.height / 2,
            width: size.width,
            height: size.height
        ))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Flips image horizontally.
    var flippedHorizontally: UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: size.width, y: 0)
        context.scaleBy(x: -1, y: 1)
        draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Flips image vertically.
    var flippedVertically: UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - Color Operations
    
    /// Tints image with color.
    ///
    /// - Parameter color: Tint color.
    /// - Returns: Tinted image.
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext(),
              let cgImage = cgImage else { return nil }
        
        color.setFill()
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        
        context.setBlendMode(.normal)
        let rect = CGRect(origin: .zero, size: size)
        context.draw(cgImage, in: rect)
        
        context.setBlendMode(.sourceIn)
        context.addRect(rect)
        context.drawPath(using: .fill)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Returns grayscale version of image.
    var grayscale: UIImage? {
        guard let cgImage = cgImage else { return nil }
        
        let context = CIContext()
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let filter = CIFilter(name: "CIPhotoEffectMono") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage,
              let cgOutput = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgOutput, scale: scale, orientation: imageOrientation)
    }
    
    /// Adjusts image brightness.
    ///
    /// - Parameter amount: Brightness adjustment (-1 to 1).
    /// - Returns: Adjusted image.
    func brightness(_ amount: CGFloat) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        
        let context = CIContext()
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let filter = CIFilter(name: "CIColorControls") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(amount, forKey: kCIInputBrightnessKey)
        
        guard let outputImage = filter.outputImage,
              let cgOutput = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgOutput, scale: scale, orientation: imageOrientation)
    }
    
    // MARK: - Data Conversion
    
    /// Returns PNG data representation.
    var pngData: Data? {
        return pngData()
    }
    
    /// Returns JPEG data with quality.
    ///
    /// - Parameter quality: Compression quality (0-1).
    /// - Returns: JPEG data.
    func jpegData(quality: CGFloat = 0.8) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    /// Returns base64 encoded PNG string.
    var base64PNG: String? {
        return pngData?.base64EncodedString()
    }
    
    /// Returns base64 encoded JPEG string.
    ///
    /// - Parameter quality: Compression quality.
    /// - Returns: Base64 string.
    func base64JPEG(quality: CGFloat = 0.8) -> String? {
        return jpegData(quality: quality)?.base64EncodedString()
    }
    
    // MARK: - Image Creation
    
    /// Creates solid color image.
    ///
    /// - Parameters:
    ///   - color: Fill color.
    ///   - size: Image size.
    /// - Returns: Solid color image.
    static func solidColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Creates image from base64 string.
    ///
    /// - Parameter base64: Base64 encoded string.
    convenience init?(base64: String) {
        guard let data = Data(base64Encoded: base64) else { return nil }
        self.init(data: data)
    }
}
#endif
