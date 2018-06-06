// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Hazel",
	dependencies: [
		.package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
		.package(url: "https://github.com/pdesantis/CommandLine", .branch("swift4")),
	],
	targets: [
		.target(
			name: "Hazel",
			dependencies: ["HazelCore"]
		),
		.target(
			name: "HazelCore",
			dependencies: ["Rainbow", "CommandLine"]
		),
		.testTarget(
			name: "HazelTests",
			dependencies: ["HazelCore"]
		)
	]
)
