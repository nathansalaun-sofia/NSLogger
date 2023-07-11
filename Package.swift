// swift-tools-version:5.7

import PackageDescription
import Darwin.C

let package = Package(
	name: "NSLogger",
	products: [
		.library(name: "NSLogger", targets: ["NSLogger"])
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "NSLogger",
			dependencies: ["NSLoggerLibObjC"],
			path: "Client/iOS",
			sources: ["NSLogger.swift"],
            swiftSettings: [SwiftSetting.define("SPMBuild")]
		),
		.target(
			name: "NSLoggerLibObjC",
			dependencies: [],
			path: "Client/iOS",
			sources: ["LoggerClient.m"],
            publicHeadersPath: "PublicHeaders",
            cSettings: [
                .define("NSLOGGER_WAS_HERE", to: "1"),
                .define("NSLOGGER_BUILD_USERNAME", to: String(cString: getenv("USER"))),
                .unsafeFlags(["-fno-objc-arc"])
            ]
		),
        .testTarget(
            name: "NSLoggerTests",
            dependencies: ["NSLogger"],
            path: "SPMTests"
        )
	],
	swiftLanguageVersions: [.v5]
)
