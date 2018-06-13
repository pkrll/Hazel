//
//  Generator.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

class Generator: Generatable {

	var directories: [String] = []
	var defaultFiles: [String] = []
	let fileManager: FileManager
	let projectName: String
	var templates: String
	var skipFiles: [String]

	static func forType(_ type: ProjectType) -> Generator {
		switch type {
		case .langC:
			return CGenerator()
		case .langSwift:
			return SwiftGenerator()
		}
	}

	init() {
		self.fileManager = FileManager.default
		self.projectName = URL(fileURLWithPath: fileManager.currentDirectoryPath).pathComponents.last!
		self.templates = Application.Paths.templatesPath
		self.skipFiles = []
	}

	func run() throws {
		try self.createDirectories()
		try self.createDefaultFiles()
	}

	func createDirectories() throws {
		for directory in self.directories {
			try self.createDirectory(atPath: directory)
		}
	}

	func createDirectory(atPath path: String) throws {
		let folderURL = URL(fileURLWithPath: path)
		try self.fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
		ConsoleIO.default.write(message: "Created \(path)")
	}

	func createDefaultFiles() throws {
		for file in self.defaultFiles {
			if self.skipFiles.contains(file) { continue }
			try self.copy(file: "\(templates)/\(file)", to: file)
		}
	}

	func copy(file source: String, to destination: String) throws {
		var fileContents: String

		fileContents = try String(contentsOf: URL(fileURLWithPath: source))
		fileContents = fileContents.replacingOccurrences(of: "__PROJECTNAME__", with: self.projectName)
		let fileData = fileContents.data(using: .utf8)

		try fileData!.write(to: URL(fileURLWithPath: destination))
		ConsoleIO.default.write(message: "Created \(destination)")
	}

}
