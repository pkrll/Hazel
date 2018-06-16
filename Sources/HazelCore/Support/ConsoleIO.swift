//
//  ConsoleIO.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Rainbow
import SwiftArgs
import Foundation

public struct ConsoleIO {

	public static var `default` = ConsoleIO()

	var silentMode: Bool

	public init(silentMode: Bool = false) {
		self.silentMode = silentMode
	}

	public func parse(_ givenArguments: [String]? = nil) -> Arguments {
		self.handleTabCompletion()

		let arguments = Arguments()
		let validArgs = [arguments.initialize, arguments.help, arguments.version, arguments.quiet]
		let swiftArgs = SwiftArgs(arguments: validArgs)

		do {
			try swiftArgs.parse(givenArguments)
		} catch {
			swiftArgs.printError(error)
		}

		if arguments.help.value! {
			swiftArgs.printUsage((arguments.initialize.value) ? arguments.initialize : nil)
			exit(0)
		} else if arguments.version.value! {
			self.write(message: Application.version)
			exit(0)
		} else if arguments.quiet.value! {
			ConsoleIO.default.silentMode = true
		}

		return arguments
	}

	func write(message: String, ofType type: ConsoleOutputType = .standard) {
		guard self.silentMode == false else { return }
		print((type == .standard) ? message.blue : message.red)
	}

	func forceQuit(withMessage message: String? = nil) {
		if let message = message {
			self.write(message: "An error occurred: \(message)", ofType: .error)
		}

		exit(1)
	}

	private func handleTabCompletion() {
		guard CommandLine.argc > 1 else { return }
		let arguments = CommandLine.arguments

		if arguments[1] == "cmplt" {
			Completion().complete(Array(arguments.dropFirst(2)))
			exit(0)
		} else if arguments[1] == "--completion-path" {
			print("\(Application.Paths.configPath)/completion/init.sh")
			exit(0)
		}
	}

}
