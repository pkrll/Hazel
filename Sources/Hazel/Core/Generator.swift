//
// Generator.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation

struct Generator {

	let fileManager = FileManager.default

	let language: Language
	let skipMake: Bool
	let skipConf: Bool

	init(_ options: CommandLineOptions) {
		self.language = options.Language
		self.skipMake = options.SkipMake
		self.skipConf = options.SkipConf
	}

	internal func createStructure() throws {
		try self.createDirectory(atPath: "test/bajs")
	}

	private func createDirectory(atPath path: String) throws {
		let folderURL = URL(fileURLWithPath: path)
		try self.fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
	}

}
