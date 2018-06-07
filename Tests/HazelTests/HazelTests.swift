//
// HazelTests.swift
// Created by Ardalan Samimi
//
import XCTest
import CommandLineKit
@testable import HazelCore

final class HazelTests: XCTestCase {

	static var allTests = [
		("testCProjectWithMakeAndConf", testCProjectWithMakeAndConf),
		("testCProjectWithMakeNoConf", testCProjectWithMakeNoConf),
		("testCProjectWithNoMakeNoConf", testCProjectWithNoMakeNoConf),
	]

	let tmpPath = "tmp"
	let fileManager = FileManager.default

	override func setUp() {
		do {
			try fileManager.createDirectory(at: URL(fileURLWithPath: tmpPath), withIntermediateDirectories: false)
		} catch {
			XCTAssertTrue(false, "Could not create temporary directory!")
		}

		fileManager.changeCurrentDirectoryPath(tmpPath)
	}

	override func tearDown() {
		fileManager.changeCurrentDirectoryPath("../")
		try? fileManager.removeItem(atPath: tmpPath)
	}

	func parse(_ arguments: [String], withOptions options: [Option]) throws {
		let commandline = CommandLineKit.CommandLine(arguments: arguments)
		commandline.addOptions(options)

		do {
			try commandline.parse()
		} catch {
			XCTFail("Failed to parse options: \(error)")
		}
	}

	func testCProjectWithMakeAndConf() {
		let optionGenerate = EnumOption<ProjectType>(shortFlag: "t", longFlag: "type", required: true, helpMessage: "")
		let optionSkipMake = BoolOption(longFlag: "no-makefile", helpMessage: "")
		let optionSkipConf = BoolOption(longFlag: "no-config", helpMessage: "")

		do {
			try self.parse([ "HazelTests", "--type", "c" ], withOptions: [optionGenerate, optionSkipMake, optionSkipConf])
			XCTAssertEqual(optionGenerate.value, .C)
		} catch {
			XCTFail("Failed to parse --type option: \(error)")
		}

		var hazel = Hazel(withOptions: (optionGenerate.value!, false, false))
		hazel.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertTrue(fileManager.fileExists(atPath: ".editorconfig"))

	}

	func testCProjectWithMakeNoConf() {
		let optionGenerate = EnumOption<ProjectType>(shortFlag: "t", longFlag: "type", required: true, helpMessage: "")
		let optionSkipMake = BoolOption(longFlag: "no-makefile", helpMessage: "")
		let optionSkipConf = BoolOption(longFlag: "no-config", helpMessage: "")

		do {
			try self.parse([ "HazelTests", "--type", "c", "--no-config" ], withOptions: [optionGenerate, optionSkipMake, optionSkipConf])
			XCTAssertTrue(optionSkipConf.value, "Failed to parse no-config option")
		} catch {
			XCTFail("Failed to parse --type option: \(error)")
		}

		var hazel = Hazel(withOptions: (optionGenerate.value!, optionSkipMake.value, optionSkipConf.value))
		hazel.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertFalse(fileManager.fileExists(atPath: ".editorconfig"))
	}

	func testCProjectWithNoMakeNoConf() {
		let optionGenerate = EnumOption<ProjectType>(shortFlag: "t", longFlag: "type", required: true, helpMessage: "")
		let optionSkipMake = BoolOption(longFlag: "no-makefile", helpMessage: "")
		let optionSkipConf = BoolOption(longFlag: "no-config", helpMessage: "")

		do {
			try self.parse([ "HazelTests", "--type", "c", "--no-makefile", "--no-config" ], withOptions: [optionGenerate, optionSkipMake, optionSkipConf])
			XCTAssertTrue(optionSkipMake.value, "Failed to parse no-config option")
			XCTAssertTrue(optionSkipConf.value, "Failed to parse no-config option")
		} catch {
			XCTFail("Failed to parse --type option: \(error)")
		}

		var hazel = Hazel(withOptions: (optionGenerate.value!, optionSkipMake.value, optionSkipConf.value))
		hazel.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertFalse(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertFalse(fileManager.fileExists(atPath: ".editorconfig"))
	}

}
