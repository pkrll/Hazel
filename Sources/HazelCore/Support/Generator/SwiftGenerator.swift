//
//  SwiftGenerator.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

class SwiftGenerator: Generator {

	override init() {
		super.init()
		self.directories 	= ["Sources", "Tests", "Sources/\(self.projectName)", "Tests/\(self.projectName)Tests"]
		self.defaultFiles = ["Package.swift", ".gitignore", "README.md"]
		self.templates = "\(Application.Paths.templatesPath)/Swift"
	}

	override func run() throws {
		try super.run()
		try self.generateSwiftFiles()
	}

	private func generateSwiftFiles() throws {
		let files = [
			(from: "\(self.templates)/main.swift", to: "Sources/\(self.projectName)/\(self.projectName).swift"),
			(from: "\(self.templates)/Tests.swift", to: "Tests/\(self.projectName)Tests/\(self.projectName)Tests.swift"),
			(from: "\(self.templates)/XCTestManifests.swift", to: "Tests/\(self.projectName)Tests/XCTestManifests.swift"),
			(from: "\(self.templates)/LinuxMain.swift", to: "Tests/LinuxMain.swift")
		]

		try files.forEach { try self.copy(file: $0.from, to: $0.to) }
	}


}
