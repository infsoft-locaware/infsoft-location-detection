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
            url: "https://sdk.infsoft.com/apple/location_detection.1.0.0.xcframework.zip",
            checksum: "9c51e08b8318a84932b596ecdbf5de21b05bf72fa97fe8095c337eef0ebca883"
        )
    ]
)








