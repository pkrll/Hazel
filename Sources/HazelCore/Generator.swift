//
//  Generator.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

class Generator: Generatable {

	var directories: [String] = []
	var projectFiles: [String] = []
	var defaultFiles: [String] = [".editorconfig"]
	let templateType: String
	let fileManager: FileManager

	let projectName: String
	let authorName: String?
	let authorMail: String?

	var templates: String
	var skipFiles: [String] = [".gitkeep"]

	init(_ templateType: String, _ projectName: String?, _ authorName: String?, _ authorMail: String?) {
		self.templateType = templateType.lowercased()
		self.authorName = authorName ?? ""
		self.authorMail = authorMail ?? ""
		self.fileManager = FileManager.default

		if let projectName = projectName {
			self.projectName = projectName
		} else {
			self.projectName = URL(fileURLWithPath: fileManager.currentDirectoryPath).pathComponents.last!
		}

		self.templates = Application.Paths.templatesPath
	}

	func prepare() throws {
		let directory = "\(self.templates)/\(self.templateType)"

		guard self.fileManager.isDirectory(directory) else {
			throw GeneratorError.unrecognizedProjectType(self.templateType)
		}

		let enumerator = self.fileManager.enumerator(atPath: directory)
		while let file = enumerator?.nextObject() as? String {
			let fPath = "\(directory)/\(file)"

			self.fileManager.isDirectory(fPath)
				? self.directories.append(file)
				: self.projectFiles.append(file)
		}
	}

	func run() throws {
		try self.createDirectories()
		try self.createFiles()
	}

	func createDirectories() throws {
		for directory in self.directories {
			try self.createDirectory(atPath: directory)
		}
	}

	func createDirectory(atPath path: String) throws {
		let path = path.replacingOccurrences(of: "__PROJECTNAME__", with: self.projectName)
		let folderURL = URL(fileURLWithPath: path)
		try self.fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
		ConsoleIO.default.write(message: "Created \(path)")
	}

	func createFiles() throws {
		for file in self.projectFiles {
			if self.skipFiles.contains(file) { continue }
			try self.copy(file: "\(self.templates)/\(self.templateType)/\(file)", to: file)
		}

		for file in self.defaultFiles {
			if self.skipFiles.contains(file) { continue }
			try self.copy(file: "\(self.templates)/defaults/\(file)", to: file)
		}
	}

	func copy(file source: String, to destination: String) throws {
		var fileContents: String
		let destination = destination.replacingOccurrences(
				of: "__PROJECTNAME__",
			with: self.projectName)

		fileContents = try String(contentsOf: URL(fileURLWithPath: source))
		fileContents = self.replacePlaceholders(fileContents)

		if let fileData = fileContents.data(using: .utf8) {
			try fileData.write(to: URL(fileURLWithPath: destination))
			ConsoleIO.default.write(message: "Created \(destination)")
		} else {
			ConsoleIO.default.write(message: "Could not generate \(destination)", ofType: .error)
		}

	}

	private func replacePlaceholders(_ string: String) -> String {
		var string = string
		let values = [
			"__PROJECTNAME__": self.projectName,
			"__AUTHORNAME__": self.authorName,
			"__AUTHORMAIL__": self.authorMail,
			"__DATE__": Date().todayPrettified()
		]

		for (placeholder, value) in values {
			if let value = value {
				string = string.replacingOccurrences(of: placeholder, with: value)
			}
		}

		return string
	}

}
