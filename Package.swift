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
            url: "https://sdk.infsoft.com/apple/location_detection.0.2.7.xcframework.zip",
            checksum: "49dee2b3e1a8b7a2bb20f37117ce5da39ee9bd6be4e7074e88d58a54ed415770"
        )
    ]
)








