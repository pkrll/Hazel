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
			"-t": "Set the project name (leave empty to use the current directory name)",
			"--name": "Set the project name (leave empty to use the current directory name)",
			"-n": "Choose project template",
			"--help": "Print help message and exit",
			"-h": "Print help message and exit",
			"--author": "Set author name",
			"-a": "Set author name",
			"--email": "Set author e-mail",
			"-e": "Set author e-mail"
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
			let lastArgument = arguments[arguments.count - 2]

			switch lastArgument {
			case "--template", "-t":
				let templates = Application.Paths.templatesPath
				if let folders = try? FileManager.default.contentsOfDirectory(atPath: templates) {
					for folder in folders where folder != "defaults" { print(folder) }
				}
			case "--author", "-a":
				if let placeholders = Placeholders.load()?.placeholders, let authorName = placeholders["__AUTHORNAME__"] {
					print("\"\(authorName)\"")
				} else {
					print("\"\"")
				}
			case "--email", "-e":
				if let placeholders = Placeholders.load()?.placeholders, let authorMail = placeholders["__AUTHORMAIL__"] {
					print("\"\(authorMail)\"")
				} else {
					print("\"\"")
				}
			default:
				for (key, value) in self.args[arguments[0]]! where argument(key, isUnusedIn: arguments) {
					print( (isBash) ? key : "\(key):\(value)")
				}
			}
		}
	}

	func argument(_ argument: String, isUnusedIn arguments: [String]) -> Bool {
		switch argument {
		case "--template", "-t":
			return !arguments.contains("--template") && !arguments.contains("-t")
		case "--name", "-n":
			return !arguments.contains("--name") && !arguments.contains("-n")
		case "--author", "-a":
			return !arguments.contains("--author") && !arguments.contains("-a")
		case "--email", "-e":
			return !arguments.contains("--email") && !arguments.contains("-e")
		default:
			return true
		}
	}

}
