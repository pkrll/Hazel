//
//  ConsoleIO.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

struct Completion {

	func complete(_ argument: String) {
		let arguments = Array(argument.components(separatedBy: " ").dropFirst())

		guard arguments.count > 1 else {
			if arguments[0].hasPrefix("--") {
				self.reply("--help", "--version")
			} else if arguments[0].hasPrefix("-") {
				self.reply("-h", "-v")
			} else {
				self.reply("init", "--help", "--version")
			}

			return
		}

		if arguments[0] == "init" { self.handleInit(Array(arguments[1...])) }
	}

	private func handleInit(_ arguments: [String]) {
		switch arguments[0] {
		case "--type", "-t":
			guard arguments.count < 3 else { return }

			let templates = Application.Paths.templatesPath
			if let folders = try? FileManager.default.contentsOfDirectory(atPath: templates) {
				for folder in folders where folder != "defaults" { print(folder) }
			}
		case "--help", "-h":
			return
		default:
			if arguments[0].hasPrefix("--") {
				self.reply("--type", "--help")
			} else if arguments[0].hasPrefix("-") {
				self.reply("-t", "-h")
			} else {
				self.reply("--type", "--help")
			}
		}
	}

	private func reply(_ replies: String...) {
		for string in replies {
			print(string)
		}
	}

}
