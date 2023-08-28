// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ExamplePollingCenter",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "ExamplePollingCenter",
            targets: ["AppModule"],
            bundleIdentifier: "com.kt.ExamplePollingCenter",
            teamIdentifier: "V5A3CLRKRX",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .cloud),
            accentColor: .presetColor(.purple),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/mobile-app-frontier/ktSwiftComponent.git", .branch("main"))
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "PollingCenter", package: "ktswiftcomponent")
            ],
            path: "."
        )
    ]
)