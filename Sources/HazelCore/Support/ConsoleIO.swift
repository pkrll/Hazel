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
		let arguments = Arguments()
		let validArgs = [arguments.initialize, arguments.help, arguments.version]
		let swiftArgs = SwiftArgs(arguments: validArgs)

		do {
			try swiftArgs.parse(givenArguments)
		} catch {
			swiftArgs.printError(error)
		}

		if arguments.help.value! {
			swiftArgs.printUsage()
		} else if arguments.version.value! {
			// ...
		}

		return arguments
	}

	func write(message: String, ofType type: ConsoleOutputType = .standard) {
		guard self.silentMode == false else { return }
		print((type == .standard) ? message.blue : message.red)
	}

	static func forceQuit(withMessage message: String? = nil) {
		if let message = message {
      ConsoleIO.default.write(message: "An error occurred: \(message)".red)
		}

		exit(1)
	}

}
