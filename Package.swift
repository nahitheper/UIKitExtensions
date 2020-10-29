// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let package = Package(
    name: "UIKitExtensions",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UIKitExtensions",
            targets: ["UIKitExtensions"]),
    ],
    targets: [
        .target(
            name: "UIKitExtensions",
            dependencies: []),
    ]
)

