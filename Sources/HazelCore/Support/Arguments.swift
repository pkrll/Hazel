//
//  Arguments.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import SwiftArgs

public struct Arguments {

	public let help = BoolOption(
		name: "help",
		shortFlag: "h",
		longFlag: "help",
		description: "Print help message and exit"
	)

	public let quiet = BoolOption(
		name: "quiet",
		shortFlag: "q",
		longFlag: "quiet",
		description: "Silent mode"
	)

	public let version = BoolOption(
		name: "version",
		shortFlag: "v",
		longFlag: "version",
		description: "Print version information and exit"
	)

	public let template = StringOption(
		name: "template",
		shortFlag: "t",
		longFlag: "template",
		description: "Choose project template (required)",
		isRequired: true
	)

	public let name = StringOption(
		name: "name",
		shortFlag: "n",
		longFlag: "name",
		description: "Set the project name (leave empty to use the current directory name)"
	)

	public let skipConf = BoolOption(
		name: "skipConf",
		longFlag: "no-config",
		description: "Do not generate .editorconfig"
	)

	public let author = StringOption(
		name: "author",
		shortFlag: "a",
		longFlag: "author",
		description: "Set author name"
	)

	public let email = StringOption(
		name: "e-mail",
		shortFlag: "e",
		longFlag: "email",
		description: "Set e-mail"
	)

	public let initialize: CommandOption

	public init() {
		self.initialize = CommandOption(
			"init",
			withArguments: [
				self.template,
				self.name,
				self.author,
				self.email,
				self.skipConf,
				self.help
			],
			description: "Initiate a new project"
		)
	}
}
