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
	public let template: StringOption
	public let skipConf: BoolOption
	public let author: StringOption
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

		self.template = StringOption(
			name: "template",
			shortFlag: "t",
			longFlag: "template",
			description: "Choose project template",
			isRequired: true
		)

		self.skipConf = BoolOption(
			name: "skipConf",
			longFlag: "no-config",
			description: "Do not generate .editorconfig"
		)

		self.author = StringOption(
			name: "author",
			shortFlag: "a",
			longFlag: "author",
			description: "Set author name"
		)

		self.initialize = CommandOption(
			"init",
			withArguments: [
				self.template,
				self.skipConf,
				self.help,
				self.author
			],
			description: "Initiate a new project"
		)
	}
}
