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
            url: "https://sdk.infsoft.com/ios/location_detection.0.0.3.xcframework.zip",
            checksum: "f5fb9c3c20e6de64438eb82cd4005f078353fd9fe46b0666f3f048a19411ec4a"
        )
    ]
)




