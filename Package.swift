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
            url: "https://sdk.infsoft.com/ios/location_detection.0.0.4.xcframework.zip",
            checksum: "82255e15415d3467ae5efff5eab1bb7cc06372c423700ba949ce4b907a761713"
        )
    ]
)





