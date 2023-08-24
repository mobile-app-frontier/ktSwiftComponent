// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ExampleIndexedScrollView",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "ExampleIndexedScrollView",
            targets: ["AppModule"],
            bundleIdentifier: "com.kt.ExampleIndexedScrollView",
            teamIdentifier: "V5A3CLRKRX",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bunny),
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
                .product(name: "IndexedScrollView", package: "ktswiftcomponent")
            ],
            path: "."
        )
    ]
)