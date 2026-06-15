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
            url: "https://sdk.infsoft.com/ios/location_detection.0.1.0.xcframework.zip",
            checksum: "55bcfada2e44a786f53da732898c9b98b34418a6f66aa03240177fdd442c3d21"
        )
    ]
)






