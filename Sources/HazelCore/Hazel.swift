import Foundation

public struct Hazel {

	let options: CommandLineOptions!
	var silentMode: Bool = false

	public init(withOptions options: CommandLineOptions) {
		self.options = options
	}

	public func run() {
		let generator = Generator(silentMode: self.silentMode)

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
