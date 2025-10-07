// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ForceUpdateKit",
    platforms: [
         .iOS(.v13)
    ],
    products: [
        .library(
            name: "ForceUpdateKit",
            targets: ["ForceUpdateKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ControlKit/ControlKitBase.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "ForceUpdateKit",
            dependencies: ["ControlKitBase"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "ForceUpdateKitTests",
            dependencies: ["ForceUpdateKit"]),
    ]
)
