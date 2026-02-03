// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftExtensions",
            targets: ["SwiftExtensions"]
        )
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
