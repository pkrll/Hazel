import Foundation

class Hazel {

	var appName: String?
	var version: String?

	var generateMakefile: Bool = false

	public func run() {
		print("Running Hazel version 0.0.1...");
		self.setup()
	}

	private func setup() {
		self.appName = self.promptUser(withQuery: "Project name: ")
		self.version = self.promptUser(withQuery: "Version: ")

		if (self.promptUser(withQuery: "Generate Makefile? [Y/N] ", onlyYesNo: true)) {
			self.openFile(atPath: "templates/Makefile")
		}

		if (self.promptUser(withQuery: "Generate .editorconfig? [Y/N] ", onlyYesNo: true)) {
			self.openFile(atPath: "templates/.editorconfig")
		}

	}

	private func openFile(atPath filePath: String) {
		if var fileContents = try? String(contentsOfFile: filePath) {
			fileContents = fileContents.replacingOccurrences(of: "__PROJECTNAME__", with: self.appName!)
			let fileData = fileContents.data(using: .utf8)
			try? fileData?.write(to: URL(fileURLWithPath: "bin/Makefile"))
		}

	}

	private func saveFile(filePath: String) {

	}

	private func promptUser(withQuery query: String) -> String? {
		print(query, terminator: "")
		return readLine()
	}

	private func promptUser(withQuery query: String, onlyYesNo: Bool) -> Bool {
		var response = "";

		repeat {
			print(query, terminator: "")
			response = readLine() ?? ""
		} while (response != "Y" && response != "N")

		return (response == "Y")
	}



}
