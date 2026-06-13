// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "SwiftExtensions", targets: ["SwiftExtensions"]),
    ],
    targets: [
        .target(
            name: "SwiftExtensions",
            path: "Sources/SwiftExtensions",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "SwiftExtensionsTests",
            dependencies: ["SwiftExtensions"]
        )
    ]
)
