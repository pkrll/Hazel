import Foundation

struct Hazel {

	let appName = "Hazel"
	let version = "1.0.0"
	let console = Console()

	let options: CommandLineOptions!

	init(withOptions options: CommandLineOptions) {
		self.options = options
		self.console.write(message: "Initializing \(self.appName) \(self.version)...")
		self.console.write(message: "Project language is set to \(options.Language.rawValue)\n")
	}

	public func run() {
		let _ = Generator(options)
	}

	private func forceQuit(_ message: String) {
		let message = "An error occurred: \(message) Terminating \(self.appName)"
		self.console.write(message: message, ofType: .error)
		exit(0)
	}

}
