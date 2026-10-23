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
            url: "https://sdk.infsoft.com/apple/location_detection.0.2.3.xcframework.zip",
            checksum: "c98c13602c61e3a1a1544ea395371cf8809f826da15975cd2de7bba8eda0e771"
        )
    ]
)








