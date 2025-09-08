// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "device_info_ce",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "device_info_ce", targets: ["device_info_ce"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "device_info_ce",
            dependencies: [],
            path: "Classes"
        )
    ]
)