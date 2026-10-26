// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "infsoft location_detection",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
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
            url: "https://sdk.infsoft.com/apple/location_detection.0.2.9.xcframework.zip",
            checksum: "89c2b8eaa811617099582e846d88e43e80b9f5d15a6b497846f1c2d4d48995dc"
        )
    ]
)








