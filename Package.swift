// swift-tools-version:4.0
import PackageDescription

let toolname = "crop"

let package = Package(
    name: toolname,
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
        ],
    targets: [
        .target(name: toolname, dependencies: ["Utility"]),
        ]
)
