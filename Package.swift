// swift-tools-version:5.3
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
            url: "https://sdk.infsoft.com/ios/location_detection.0.0.2.xcframework.zip",
            checksum: "bdad842a5e0c2aff8ea98f021d1d509c1995e6f2d6ef322a79d97a8d72d9adaf"
        )
    ]
)



