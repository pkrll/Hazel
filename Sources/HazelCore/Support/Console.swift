//
// Console.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation
import Rainbow
import CommandLineKit

public typealias CommandLineOptions = (ProjectType: ProjectType, SkipMake: Bool, SkipConf: Bool)

public final class Console {

	public static func parseArguments() -> CommandLineOptions {
		let commandLine = Console.commandLine()

		let optionGenerate = EnumOption<ProjectType>(shortFlag: "t", longFlag: "type", required: true, helpMessage: "Choose language for project: [c|c++|swift|java|erlang]")
		let optionSkipMake = BoolOption(longFlag: "no-makefile", helpMessage: "Do not generate Makefile")
		let optionSkipConf = BoolOption(longFlag: "no-config", helpMessage: "Do not generate .editorconfig")
		let optionViewHelp = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Print help message and exit")
		let optionVersion = BoolOption(shortFlag: "v", longFlag: "version", helpMessage: "Print version information and exit")

		commandLine.addOptions(optionGenerate, optionSkipMake, optionSkipConf, optionViewHelp, optionVersion)

		do {
			try commandLine.parse()
		} catch {
			if optionVersion.value {
				Console.write(message: "\(Application.appName) version \(Application.version)")
			} else if optionViewHelp.value {
				commandLine.printUsage()
			} else {
				commandLine.printUsage(error)
			}

			exit(EX_USAGE)
		}

		return (optionGenerate.value!, optionSkipMake.value, optionSkipConf.value)
	}

	public static func write(message: String, ofType type: ConsoleOutputType = .standard) {
		let message = (type == .standard) ? message.blue : message.red
		print(message)
	}

	private static func commandLine() -> CommandLineKit.CommandLine {
		let commandLine = CommandLineKit.CommandLine()

		commandLine.formatOutput = { s, type in
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

		  return commandLine.defaultFormat(s: str, type: type)
		}

		return commandLine
	}

}
