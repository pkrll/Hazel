//
//  ConsoleIO.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

struct Completion {

	var args = [
		" ": [
			"init": "Initiate a new project",
			"--help": "Print help message and exit",
			"-h": "Print help message and exit",
			"--version": "Print version information and exit",
			"-v": "Print version information and exit",
			"--quiet": "Silent mode",
			"-q": "Silent mode"
		],
		"init": [
			"--template": "Choose project template",
			"-t": "Choose project template",
			"--help": "Print help message and exit",
			"-h": "Print help message and exit"
		]
	]

	func complete(_ arguments: [String], forBash isBash: Bool = false) {

		guard arguments.count > 1 else {
			for (key, value) in self.args[" "]! {
				print( (isBash) ? key : "\(key):\(value)")
			}

			return
		}

		guard arguments[0] != "-q" else {
			let arguments = Array(arguments.dropFirst())
			self.complete(arguments, forBash: isBash)
			return
		}

		guard arguments.count > 2 else {
			if let arg = self.args[arguments[0]] {
				for (key, value) in arg {
					print( (isBash) ? key : "\(key):\(value)")
				}
			}

			return
		}

		if arguments[0] == "init" {
			switch arguments[1] {
			case "--template", "-t":
				guard arguments.count < 4 else { return }

				let templates = Application.Paths.templatesPath
				if let folders = try? FileManager.default.contentsOfDirectory(atPath: templates) {
					for folder in folders where folder != "defaults" { print(folder) }
				}
			default:
				return
			}
		}
	}

}
