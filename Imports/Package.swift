// swift-tools-version: 5.4

import PackageDescription

let otpProduct: Target.Dependency = .product(name: "OTP", package: "OTP")
let swiftBoostProduct: Target.Dependency = .product(name: "SwiftBoost", package: "SwiftBoost")
let keychainAccessProduct: Target.Dependency = .product(name: "KeychainAccess", package: "KeychainAccess")

let package = Package(
    name: "Imports",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "iOSAppImport",
            targets: ["iOSAppImport"]
        ),
        .library(
            name: "widgetExtensionImport",
            targets: ["widgetExtensionImport"]
        ),
        .library(
            name: "watchOSAppImport",
            targets: ["watchOSAppImport"]
        )
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "10.4.0")),
        .package(url: "https://github.com/ivanvorobei/SPDiffable", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/ivanvorobei/NativeUIKit", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/sparrowcode/SPSettingsIcons", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/sparrowcode/SafeSFSymbols", .upToNextMajor(from: "1.1.2")),
        .package(url: "https://github.com/sparrowcode/PermissionsKit", .upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/ivanvorobei/SPAlert", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/ivanvorobei/SPIndicator", .upToNextMajor(from: "1.6.4")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.2.2")),
        .package(url: "https://github.com/sparrowcode/OTP", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/svyatoynick/GAuthSwiftParser", .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", .upToNextMajor(from: "5.0.1"))
        
    ],
    targets: [
        .target(
            name: "iOSAppImport",
            dependencies: [
                .product(name: "FirebaseMessaging", package: "Firebase"),
                .product(name: "FirebaseCrashlytics", package: "Firebase"),
                .product(name: "FirebasePerformance", package: "Firebase"),
                .product(name: "FirebaseAppCheck", package: "Firebase"),
                .product(name: "SPDiffable", package: "SPDiffable"),
                swiftBoostProduct,
                .product(name: "NativeUIKit", package: "NativeUIKit"),
                .product(name: "SPSettingsIcons", package: "SPSettingsIcons"),
                .product(name: "SafeSFSymbols", package: "SafeSFSymbols"),
                .product(name: "CameraPermission", package: "PermissionsKit"),
                .product(name: "SPAlert", package: "SPAlert"),
                .product(name: "SPIndicator", package: "SPIndicator"),
                keychainAccessProduct,
                otpProduct,
                .product(name: "GAuthSwiftParser", package: "GAuthSwiftParser")
            ]
        ),
        .target(
            name: "widgetExtensionImport",
            dependencies: [
                swiftBoostProduct,
                keychainAccessProduct,
                otpProduct
            ]
        ),
        .target(
            name: "watchOSAppImport",
            dependencies: [
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                swiftBoostProduct,
                keychainAccessProduct,
                otpProduct
            ]
        )
    ]
)
