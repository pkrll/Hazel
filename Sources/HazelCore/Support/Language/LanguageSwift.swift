//
// LanguageSwift.swift
// Created by Ardalan Samimi on 2018-06-08
//
final class LanguageSwift: Generator {

	override init() {
		super.init()
		self.directories 	= ["Sources", "Tests", "Sources/\(self.projectName)", "Tests/\(self.projectName)Tests"]
		self.defaultFiles = ["Package.swift", ".gitignore", "README.md"]
		self.templatesPath = "\(Application.Paths.templatesPath)/Swift"
	}

	override func initProject() throws {
		try super.initProject()
		try self.generateSwiftFiles()
	}

	private func generateSwiftFiles() throws {
		let files = [
			(from: "\(templatesPath)/main.swift", to: "Sources/\(self.projectName)/\(self.projectName).swift"),
			(from: "\(templatesPath)/Tests.swift", to: "Tests/\(self.projectName)Tests/\(self.projectName)Tests.swift"),
			(from: "\(templatesPath)/XCTestManifests.swift", to: "Tests/\(self.projectName)Tests/XCTestManifests.swift"),
			(from: "\(templatesPath)/LinuxMain.swift", to: "Tests/LinuxMain.swift")
		]

		try files.forEach { try self.copy(file: $0.from, to: $0.to) }
	}

}
