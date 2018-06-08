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

}
