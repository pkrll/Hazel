//
// Generator.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation
import ConsoleIO
import HazelSupport

struct Generator {

	let fileManager: FileManager
	let projectName: String

	init() {
		self.fileManager = FileManager.default
		self.projectName = URL(fileURLWithPath: fileManager.currentDirectoryPath).pathComponents.last!
	}

	internal func createProject(for projectType: ProjectType) throws {
		let directories = self.getLanguage(from: projectType).directories

		for directory in directories {
			try self.createDirectory(atPath: directory)
		}
	}

	internal func generateMakefile() throws {
		try self.generateFile("Makefile")
	}

	internal func generateEditorconfig() throws {
		try self.generateFile(".editorconfig")
	}

	private func createDirectory(atPath path: String) throws {
		let folderURL = URL(fileURLWithPath: path)
		try self.fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
		Console.write(message: "Created \(path)")
	}

	private func generateFile(_ file: String) throws {
		var directory: String

		if #available(macOS 10.12, *) {
			directory = self.fileManager.homeDirectoryForCurrentUser.path
		} else {
			directory = NSHomeDirectory()
		}

		directory += "/\(Application.Paths.templates)"

		try self.copy(file: "\(directory)/\(file)", to: file)
	}

	private func copy(file source: String, to destination: String) throws {
		var fileContents: String

		fileContents = try String(contentsOf: URL(fileURLWithPath: source))
		fileContents = fileContents.replacingOccurrences(of: "__PROJECTNAME__", with: self.projectName)
		let fileData = fileContents.data(using: .utf8)

		try fileData!.write(to: URL(fileURLWithPath: destination))
		Console.write(message: "Created \(destination)")
	}

	private func getLanguage(from: ProjectType) -> Language {
		switch from {
		case .C:
			return LanguageC()
		default:
			return LanguageC()
		}
	}

}
