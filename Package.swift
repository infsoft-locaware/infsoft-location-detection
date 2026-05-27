// swift-tools-version: 6.2
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
            url: "https://sdk.infsoft.com/ios/location_detection.0.0.1.xcframework.zip",
            checksum: "5feb2ecd85b7105cd367259bd6b73c1585358326a21664df38b79b067ea46559"
        )
    ]
)


