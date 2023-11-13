// swift-tools-version: 5.5

import PackageDescription

let otpProduct: Target.Dependency = .product(name: "OTP", package: "OTP")
let swiftBoostProduct: Target.Dependency = .product(name: "SwiftBoost", package: "SwiftBoost")
let sparrowCodeExtensionProduct: Target.Dependency = .product(name: "SparrowCodeExtension", package: "SparrowCodeExtension")
let swiftyJSONProduct: Target.Dependency = .product(name: "SwiftyJSON", package: "SwiftyJSON")
let keychainAccessProduct: Target.Dependency = .product(name: "KeychainAccess", package: "KeychainAccess")
let swiftUIExtensionProduct: Target.Dependency = .product(name: "SwiftUIExtension", package: "SwiftUIExtension")

let package = Package(
    name: "Imports",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15), .watchOS(.v6)
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
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "10.17.0")),
        .package(url: "https://github.com/ivanvorobei/SPDiffable", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.8")),
        .package(url: "https://github.com/ivanvorobei/NativeUIKit", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/sparrowcode/SettingsIconGenerator", .upToNextMajor(from: "1.0.2")),
        .package(url: "https://github.com/sparrowcode/SafeSFSymbols", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/sparrowcode/PermissionsKit", .upToNextMajor(from: "10.0.1")),
        .package(url: "https://github.com/sparrowcode/AlertKit", .upToNextMajor(from: "5.1.8")),
        .package(url: "https://github.com/sparrowcode/SwiftUIExtension", .upToNextMajor(from: "1.0.11")),
        .package(url: "https://github.com/ivanvorobei/SPIndicator", .upToNextMajor(from: "1.6.4")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.2.2")),
        .package(url: "https://github.com/sparrowcode/OTP", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/svyatoynick/GAuthSwiftParser", .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", .upToNextMajor(from: "5.0.1")),
        .package(path: "SparrowCodeExtension")
    ],
    targets: [
        .target(
            name: "iOSAppImport",
            dependencies: [
                swiftyJSONProduct,
                .product(name: "FirebaseMessaging", package: "Firebase"),
                .product(name: "FirebaseCrashlytics", package: "Firebase"),
                .product(name: "FirebasePerformance", package: "Firebase"),
                .product(name: "FirebaseAppCheck", package: "Firebase"),
                .product(name: "SPDiffable", package: "SPDiffable"),
                swiftBoostProduct,
                .product(name: "NativeUIKit", package: "NativeUIKit"),
                .product(name: "SettingsIconGenerator", package: "SettingsIconGenerator"),
                .product(name: "SafeSFSymbols", package: "SafeSFSymbols"),
                .product(name: "CameraPermission", package: "PermissionsKit"),
                .product(name: "AlertKit", package: "AlertKit"),
                .product(name: "SPIndicator", package: "SPIndicator"),
                keychainAccessProduct,
                otpProduct,
                .product(name: "GAuthSwiftParser", package: "GAuthSwiftParser")
            ]
        ),
        .target(
            name: "widgetExtensionImport",
            dependencies: [
                swiftyJSONProduct,
                swiftBoostProduct,
                keychainAccessProduct,
                otpProduct,
                swiftUIExtensionProduct,
                sparrowCodeExtensionProduct
            ]
        ),
        .target(
            name: "watchOSAppImport",
            dependencies: [
                swiftyJSONProduct,
                swiftBoostProduct,
                keychainAccessProduct,
                otpProduct
            ]
        )
    ]
)
