// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftBackports",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "SwiftBackports",
            targets: ["SwiftBackports"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(name: "SwiftBackports"),
        .testTarget(name: "SwiftBackportsTests", dependencies: ["SwiftBackports"])
    ],
    swiftLanguageVersions: [.v5]
)
