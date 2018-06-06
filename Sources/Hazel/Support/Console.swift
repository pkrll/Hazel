//
// Console.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation
import Rainbow
import CommandLineKit

internal typealias CommandLineOptions = (ProjectType: ProjectType, SkipMake: Bool, SkipConf: Bool)

final class Console {

	internal static func parseArguments() -> CommandLineOptions {
		let commandline = CommandLineKit.CommandLine()

		let optionGenerate = EnumOption<ProjectType>(shortFlag: "n", longFlag: "new", required: true, helpMessage: "Creates an application skeleton: [c|c++|swift|java|erlang]")
		let optionSkipMake = BoolOption(longFlag: "no-makefile", helpMessage: "Do not generate Makefile")
		let optionSkipConf = BoolOption(longFlag: "no-config", helpMessage: "Do not generate .editorconfig")
		let optionViewHelp = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message")

		commandline.addOptions(optionGenerate, optionSkipMake, optionSkipConf, optionViewHelp)

		commandline.formatOutput = { s, type in
		  var str: String

		  switch(type) {
		  case .error:
		    str = s.red.bold
		  case .optionFlag:
		    str = s.green
		  case .optionHelp:
		    str = s.blue
		  default:
		    str = s
		  }

		  return commandline.defaultFormat(s: str, type: type)
		}

		do {
			try commandline.parse()
		} catch {
			commandline.printUsage(error)
			exit(EX_USAGE)
		}

		return (optionGenerate.value!, optionSkipMake.value, optionSkipConf.value)
	}

	internal static func write(message: String, ofType type: ConsoleOutputType = .standard) {
		let message = (type == .standard) ? message.blue : message.red
		print(message)
	}

}
