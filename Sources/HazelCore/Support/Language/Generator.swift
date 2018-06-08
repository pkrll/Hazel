import Foundation

class Generator: Language {

	var directories: 	[String] = []
	var defaultFiles: [String] = []

	let fileManager: FileManager
	let projectName: String

	var templatesPath: String
	var skipFiles: [String] = []

	init() {
		self.fileManager = FileManager.default
		self.projectName = URL(fileURLWithPath: fileManager.currentDirectoryPath).pathComponents.last!
		self.templatesPath = Application.Paths.templatesPath
	}

	func initProject() throws {
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
		Console.default.write(message: "Created \(path)")
	}

	func createDefaultFiles() throws {
		for file in self.defaultFiles {
			if self.skipFiles.contains(file) { continue }
			try self.copy(file: "\(templatesPath)/\(file)", to: file)
		}
	}

	func copy(file source: String, to destination: String) throws {
		var fileContents: String

		fileContents = try String(contentsOf: URL(fileURLWithPath: source))
		fileContents = fileContents.replacingOccurrences(of: "__PROJECTNAME__", with: self.projectName)
		let fileData = fileContents.data(using: .utf8)

		try fileData!.write(to: URL(fileURLWithPath: destination))
		Console.default.write(message: "Created \(destination)")
	}

}
