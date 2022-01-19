// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ValueRow",
    platforms: [.iOS(.v14), .macOS(.v11), .macCatalyst(.v14), .tvOS(.v14), .watchOS(.v7)],
    products: [
        .library(name: "ValueRow", targets: ["ValueRow"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "ValueRow", dependencies: []),
        .testTarget(name: "ValueRowTests", dependencies: ["ValueRow"]),
    ]
)
