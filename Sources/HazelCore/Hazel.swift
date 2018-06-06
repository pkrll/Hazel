import Foundation
import ConsoleIO

public struct Hazel {

	let options: CommandLineOptions!

	public init(withOptions options: CommandLineOptions) {
		self.options = options
	}

	public func run() {
		let generator = Generator()

		do {
			try generator.createProject(for: self.options.ProjectType)
			if self.options.SkipMake == false { try generator.generateMakefile() }
			if self.options.SkipConf == false { try generator.generateEditorconfig() }
		} catch {
			self.forceQuit(error.localizedDescription)
		}
	}

	private func forceQuit(_ message: String) {
		let message = "An error occurred: \(message)"
		Console.write(message: message, ofType: .error)
		exit(0)
	}

}
