// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SparrowCodeExtension",
    platforms: [
        .iOS(.v15), 
        .watchOS(.v6),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SparrowCodeExtension",
            targets: ["SparrowCodeExtension"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SparrowCodeExtension",
            swiftSettings: [
                .define("SPARROWCODEEXTENSION_SPM")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
