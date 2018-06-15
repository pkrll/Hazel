//
//  Hazel.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import SwiftArgs

public struct Hazel {

	let console: ConsoleIO

	public init(_ console: ConsoleIO) {
		self.console = console
	}

	public func initialize(_ command: CommandOption) {
		guard command.arguments.count > 0 else {
			return
		}

		var projType: String?
		var skipConf: Bool = false

		for argument in command.arguments {
			switch argument.name {
			case "type": projType = (argument as? StringOption)?.value
			case "conf": skipConf = (argument as? BoolOption)?.value! ?? false
			default: break
			}
		}

		guard let type = projType else {
			self.console.forceQuit(withMessage: "Project type not recognized.")
			return
		}

		let generator = Generator(type)
		if skipConf { generator.skipFiles.append(".editorconfig") }

		do {
			try generator.prepare()
			try generator.run()
		} catch GeneratorError.unrecognizedProjectType(let type) {
			self.console.forceQuit(withMessage: "Could not find template for \(type).")
		} catch {
			self.console.forceQuit(withMessage: error.localizedDescription)
		}
	}

}
