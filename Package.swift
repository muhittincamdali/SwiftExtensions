// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2)
    ],
    products: [
        .library(name: "SwiftExtensions", targets: ["SwiftExtensions"])
    ],
    targets: [
        .target(
            name: "SwiftExtensions",
            path: "Sources/SwiftExtensions"
        ),
        .testTarget(
            name: "SwiftExtensionsTests",
            dependencies: ["SwiftExtensions"],
            path: "Tests/SwiftExtensionsTests"
        )
    ]
)
