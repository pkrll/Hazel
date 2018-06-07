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

	func testCProjectWithMakeAndConf() {
		let options = Console.parseArguments([ "HazelTests", "--type", "c" ])

		var hazel = Hazel(withOptions: options)
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
		let options = Console.parseArguments([ "HazelTests", "--type", "c", "--no-config" ])

		var hazel = Hazel(withOptions: options)
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
		let options = Console.parseArguments([ "HazelTests", "--type", "c", "--no-makefile", "--no-config" ])

		var hazel = Hazel(withOptions: options)
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
