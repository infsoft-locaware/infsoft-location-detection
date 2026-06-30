// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "infsoft location_detection",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "location_detection",
            targets: ["location_detection"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "location_detection",
            url: "https://sdk.infsoft.com/ios/location_detection.0.1.1.xcframework.zip",
            checksum: "e77a14cd1c69a0aa424cec9c0cbda9db9cb5df27898fa9ca77a8b80f657a907f"
        )
    ]
)







