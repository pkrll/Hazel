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

		var projType: ProjectType?
		var skipMake: Bool = false
		var skipConf: Bool = false

		for argument in command.arguments {
			switch argument.name {
			case "type": projType = (argument as! EnumOption<ProjectType>).value!
			case "make": skipMake = (argument as! BoolOption).value!
			case "conf": skipConf = (argument as! BoolOption).value!
			default:
				break
			}
		}

    guard let type = projType else {
      ConsoleIO.forceQuit(withMessage: "Project type not recognized.")
      return
    }
    
		let generator = Generator.forType(type)

		if skipMake { generator.skipFiles.append("Makefile") }
		if skipConf { generator.skipFiles.append(".editorconfig") }

		do {
			try generator.run()
		} catch {
      ConsoleIO.forceQuit(withMessage: error.localizedDescription)
		}
	}

}
