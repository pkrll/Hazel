import Foundation

struct Hazel {

	var appName: String?
	var version: String?

	public func run() {
		print("Running hazel version 0.0.1...")
	}

}
//
// class Hazels {
//
// 	var appName: String?
// 	var version: String?
//
// 	var generateMakefile: Bool = false
//
// 	public func run() {
// 		print("Running Hazel version 0.0.1...");
// 		self.setup()
// 	}
//
// 	private func setup() {
// 		self.appName = self.promptUser(withQuery: "Project name: ")
// 		self.version = self.promptUser(withQuery: "Version: ")
//
// 		if (self.promptUser(withQuery: "Generate Makefile? [Y/N] ", onlyYesNo: true)) {
// 			self.generateFile(atPath: "bin/Makefile", withTemplate: "Makefile")
// 		}
//
// 		if (self.promptUser(withQuery: "Generate .editorconfig? [Y/N] ", onlyYesNo: true)) {
// 			self.generateFile(atPath: "bin/.editorconfig", withTemplate: ".editorconfig")
// 		}
//
// 	}
//
// 	private func generateFile(atPath filePath: String, withTemplate templateFile: String) {
// 		if var fileContents = try? String(contentsOfFile: "templates/\(templateFile)") {
// 			fileContents = fileContents.replacingOccurrences(of: "__PROJECTNAME__", with: self.appName!)
// 			let fileData = fileContents.data(using: .utf8)
//
// 			try? fileData?.write(to: URL(fileURLWithPath: filePath))
// 		}
// 	}
//
// 	private func promptUser(withQuery query: String) -> String? {
// 		print(query, terminator: "")
// 		return readLine()
// 	}
//
// 	private func promptUser(withQuery query: String, onlyYesNo: Bool) -> Bool {
// 		var response = "";
//
// 		repeat {
// 			print(query, terminator: "")
// 			response = readLine() ?? ""
// 		} while (response != "Y" && response != "N")
//
// 		return (response == "Y")
// 	}
//
//
//
// }
