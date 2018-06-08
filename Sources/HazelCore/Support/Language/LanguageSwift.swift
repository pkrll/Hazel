//
// LanguageSwift.swift
// Created by Ardalan Samimi on 2018-06-08
//
final class LanguageSwift: Generator {

	override init() {
		super.init()
		self.directories 	= ["Sources", "Tests", "Sources/\(self.projectName)", "Tests/\(self.projectName)Tests"]
		self.defaultFiles = ["Package.swift", ".editorconfig"]
	}

	override func initProject() throws {
		try super.initProject()
		self.generateSwiftFiles()
	}

	private func generateSwiftFiles() {
		self.fileManager.createFile(atPath: "Sources/\(self.projectName)/main.swift", contents: nil)
		self.fileManager.createFile(atPath: "Tests/\(self.projectName)Tests/\(self.projectName)Tests.swift", contents: nil)
		self.fileManager.createFile(atPath: "Tests/\(self.projectName)Tests/XCTestManifests.swift", contents: nil)
	}

}
