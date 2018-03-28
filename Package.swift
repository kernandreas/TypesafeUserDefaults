// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "TypesafeUserDefaults",
    products: [
        .library(
            name: "TypesafeUserDefaults",
            targets: ["TypesafeUserDefaults"]),
    ],
    targets: [
        .target(
            name: "TypesafeUserDefaults",
            dependencies: []),
        .testTarget(
            name: "TypesafeUserDefaultsTests",
            dependencies: ["TypesafeUserDefaults"]),
    ]
)
