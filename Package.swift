// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Dater",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "Dater",
            targets: ["Dater"]),
    ],
    targets: [
        .target(
            name: "Dater",
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Dater"],
            path: "Tests"),
    ]
)
