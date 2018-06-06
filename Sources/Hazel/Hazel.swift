import Foundation

struct Hazel {

	let appName = "Hazel"
	let version = "1.0.0"
	let console = Console()

	init() {
		self.console.write(message: "Initializing \(self.appName)...")
		self.console.write(message: "Version: \(self.version)")
	}

	public func main(_ argc: Int32, _ argv: [String]) {
		guard argc > 1 else {
			self.exit("No arguments given. See ")
			return
		}

		let commands = self.parse(arguments: Array(argv[1...]))
		self.execute(commands)
	}

	private func parse(arguments: [String]) -> [Commands] {
		var commands = [Commands]()

		for argument in arguments {
			if let command = Commands(argument) {
				commands.append(command)
			}
		}

		return commands
	}

	private func execute(_ commands: [Commands]) {
		guard commands.count > 0 else {
			self.console.write(message: "Invalid arguments given.")
			return
		}
	}

	private func exit(_ message: String) {
		self.console.write(message: message, ofType: .error)
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
