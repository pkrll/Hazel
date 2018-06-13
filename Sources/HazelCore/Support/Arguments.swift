//
//  Arguments.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import SwiftArgs

public struct Arguments {

	public let help: BoolOption
	public let version: BoolOption
	public let type: EnumOption<ProjectType>
	public let skipMake: BoolOption
	public let skipConf: BoolOption
	public let initialize: CommandOption

	public init() {
		self.help = BoolOption(
			name: "help",
			shortFlag: "h",
			longFlag: "help",
			description: "Print help message and exit"
		)

		self.version = BoolOption(
			name: "version",
			shortFlag: "v",
			longFlag: "version",
			description: "Print version information and exit"
		)

		self.type = EnumOption<ProjectType>(
			name: "type",
			shortFlag: "t",
			longFlag: "type",
			description: "Set language for project: [c|swift]",
			isRequired: true
		)

		self.skipMake = BoolOption(
			name: "make",
			longFlag: "no-makefile",
			description: "Do not generate Makefile"
		)

		self.skipConf = BoolOption(
			name: "conf",
			longFlag: "no-config",
			description: "Do not generate .editorconfig"
		)

		self.initialize = CommandOption(
			"init",
			withArguments: [
				self.type,
				self.skipMake,
				self.skipConf,
				self.help
			],
			description: "Initiate a new project"
		)
	}
}
