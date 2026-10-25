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
            url: "https://sdk.infsoft.com/apple/location_detection.0.2.5.xcframework.zip",
            checksum: "25d05706543547324feaf0621b86938064b59fbdc2c79768148b08f0b6a4fa85"
        )
    ]
)








