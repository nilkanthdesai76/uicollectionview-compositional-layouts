// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CompositionalLayouts",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .macCatalyst(.v14)
    ],
    products: [
        .library(
            name: "CompositionalLayouts",
            targets: ["CompositionalLayouts"]
        )
    ],
    targets: [
        .target(
            name: "CompositionalLayouts",
            dependencies: []
        ),
        .testTarget(
            name: "CompositionalLayoutsTests",
            dependencies: ["CompositionalLayouts"]
        )
    ]
)
