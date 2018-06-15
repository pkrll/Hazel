//
//  Arguments.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import SwiftArgs

public struct Arguments {

	public let help: BoolOption
	public let quiet: BoolOption
	public let version: BoolOption
	public let type: StringOption
	public let skipConf: BoolOption
	public let initialize: CommandOption

	public init() {
		self.help = BoolOption(
			name: "help",
			shortFlag: "h",
			longFlag: "help",
			description: "Print help message and exit"
		)

		self.quiet = BoolOption(
			name: "quiet",
			shortFlag: "q",
			longFlag: "quiet",
			description: "Silent mode"
		)

		self.version = BoolOption(
			name: "version",
			shortFlag: "v",
			longFlag: "version",
			description: "Print version information and exit"
		)

		self.type = StringOption(
			name: "type",
			shortFlag: "t",
			longFlag: "type",
			description: "Set language for project",
			isRequired: true
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
				self.skipConf,
				self.help
			],
			description: "Initiate a new project"
		)
	}
}
