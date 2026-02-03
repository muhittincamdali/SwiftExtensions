#if canImport(UIKit)
import UIKit

// MARK: - UIDevice Extensions

public extension UIDevice {
    
    // MARK: - Device Model
    
    /// Returns device model identifier.
    ///
    /// ```swift
    /// UIDevice.current.modelIdentifier    // "iPhone14,5"
    /// ```
    var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(validatingUTF8: $0) ?? "Unknown"
            }
        }
    }
    
    /// Returns human-readable model name.
    var modelName: String {
        let identifier = modelIdentifier
        
        switch identifier {
        // iPhone
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone15,4": return "iPhone 15"
        case "iPhone15,5": return "iPhone 15 Plus"
        case "iPhone16,1": return "iPhone 15 Pro"
        case "iPhone16,2": return "iPhone 15 Pro Max"
            
        // iPad
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return "iPad Pro 11-inch (3rd gen)"
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return "iPad Pro 12.9-inch (5th gen)"
        case "iPad14,3", "iPad14,4": return "iPad Pro 11-inch (4th gen)"
        case "iPad14,5", "iPad14,6": return "iPad Pro 12.9-inch (6th gen)"
            
        // Simulator
        case "i386", "x86_64", "arm64": return "Simulator"
            
        default: return identifier
        }
    }
    
    // MARK: - Device Type
    
    /// Checks if device is iPhone.
    var isPhone: Bool {
        return userInterfaceIdiom == .phone
    }
    
    /// Checks if device is iPad.
    var isPad: Bool {
        return userInterfaceIdiom == .pad
    }
    
    /// Checks if device is running in Simulator.
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    /// Checks if device has notch (Face ID).
    var hasNotch: Bool {
        guard isPhone else { return false }
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) {
            return window.safeAreaInsets.bottom > 0
        }
        return false
    }
    
    /// Checks if device has home button.
    var hasHomeButton: Bool {
        return !hasNotch
    }
    
    // MARK: - Screen
    
    /// Returns screen bounds.
    var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    /// Returns screen width.
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// Returns screen height.
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// Returns screen scale.
    var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    
    /// Checks if screen is Retina.
    var isRetina: Bool {
        return UIScreen.main.scale >= 2
    }
    
    // MARK: - System Info
    
    /// Returns OS version string.
    var osVersion: String {
        return systemVersion
    }
    
    /// Returns OS version as components.
    var osVersionComponents: (major: Int, minor: Int, patch: Int) {
        let components = systemVersion.split(separator: ".").compactMap { Int($0) }
        return (
            major: components.count > 0 ? components[0] : 0,
            minor: components.count > 1 ? components[1] : 0,
            patch: components.count > 2 ? components[2] : 0
        )
    }
    
    /// Checks if OS version is at least specified version.
    func isOS(atLeast major: Int, minor: Int = 0, patch: Int = 0) -> Bool {
        let current = osVersionComponents
        if current.major != major { return current.major > major }
        if current.minor != minor { return current.minor > minor }
        return current.patch >= patch
    }
    
    // MARK: - Battery
    
    /// Returns battery level (0-1).
    var batteryPercentage: Float {
        isBatteryMonitoringEnabled = true
        return batteryLevel
    }
    
    /// Checks if device is charging.
    var isCharging: Bool {
        isBatteryMonitoringEnabled = true
        return batteryState == .charging || batteryState == .full
    }
    
    /// Checks if device is fully charged.
    var isFullyCharged: Bool {
        isBatteryMonitoringEnabled = true
        return batteryState == .full
    }
    
    // MARK: - Storage
    
    /// Returns total disk space in bytes.
    var totalDiskSpace: Int64 {
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let space = attrs[.systemSize] as? Int64 else { return 0 }
        return space
    }
    
    /// Returns free disk space in bytes.
    var freeDiskSpace: Int64 {
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let space = attrs[.systemFreeSize] as? Int64 else { return 0 }
        return space
    }
    
    /// Returns used disk space in bytes.
    var usedDiskSpace: Int64 {
        return totalDiskSpace - freeDiskSpace
    }
    
    /// Returns formatted total disk space.
    var formattedTotalDiskSpace: String {
        return ByteCountFormatter.string(fromByteCount: totalDiskSpace, countStyle: .file)
    }
    
    /// Returns formatted free disk space.
    var formattedFreeDiskSpace: String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpace, countStyle: .file)
    }
    
    // MARK: - Memory
    
    /// Returns total RAM in bytes.
    var totalRAM: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    /// Returns formatted total RAM.
    var formattedTotalRAM: String {
        return ByteCountFormatter.string(fromByteCount: Int64(totalRAM), countStyle: .memory)
    }
}
#endif
