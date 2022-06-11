// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CurrencyKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CurrencyKit",
            targets: ["CurrencyKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CurrencyKit",
            dependencies: [],
            resources: [
                .process("Resources/Assets.xcassets")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
