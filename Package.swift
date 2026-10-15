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
            url: "https://sdk.infsoft.com/apple/location_detection.0.2.2.xcframework.zip",
            checksum: "8111b6370b391290306a4d9fcbd197528d4bf1340ee00ff287ae46b444e9c1e4"
        )
    ]
)








