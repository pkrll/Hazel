import Foundation

public struct Hazel {

	let options: CommandLineOptions!
	var silentMode: Bool = false

	public init(withOptions options: CommandLineOptions) {
		self.options = options
	}

	public func run() {
		let generator = self.getGenerator(for: self.options.ProjectType)!

		if self.options.SkipMake { generator.skipFiles.append("Makefile") }
		if self.options.SkipConf { generator.skipFiles.append(".editorconfig") }

		do {
			try generator.initProject()
		} catch {
			self.forceQuit(error.localizedDescription)
		}
	}

	private func forceQuit(_ message: String) {
		let message = "An error occurred: \(message)"
		Console.default.write(message: message)
		exit(1)
	}

	private func getGenerator(for projectType: ProjectType) -> Generator? {
		switch projectType {
		case .C:
			return LanguageC()
		case .Swift:
			return LanguageSwift()
		default:
			self.forceQuit("No support yet added for \(projectType.rawValue) projects.")
		}

		return nil
	}

}
