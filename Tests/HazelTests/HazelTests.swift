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
		("testSwiftProject", testSwiftProject),
	]

	let tmpPath = "tmp"
	let fileManager = FileManager.default

	override func setUp() {
		do {
			try fileManager.createDirectory(at: URL(fileURLWithPath: tmpPath), withIntermediateDirectories: false)
		} catch {
			XCTAssertTrue(false, "Could not create temporary directory \(URL(fileURLWithPath: tmpPath).path)!")
		}

		fileManager.changeCurrentDirectoryPath(tmpPath)
	}

	override func tearDown() {
		fileManager.changeCurrentDirectoryPath("../")
		try? fileManager.removeItem(atPath: tmpPath)
	}

	func testCProjectWithMakeAndConf() {
		let console = Console.default
		let options = console.parseArguments([ "HazelTests", "--type", "c" ])
		let hazel = Hazel(withOptions: options)

		console.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertTrue(fileManager.fileExists(atPath: ".editorconfig"))
	}

	func testCProjectWithMakeNoConf() {
		let console = Console.default
		let options = console.parseArguments([ "HazelTests", "--type", "c", "--no-config" ])
		let hazel = Hazel(withOptions: options)

		console.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertFalse(fileManager.fileExists(atPath: ".editorconfig"))
	}

	func testCProjectWithNoMakeNoConf() {
		let console = Console.default
		let options = console.parseArguments([ "HazelTests", "--type", "c", "--no-makefile", "--no-config" ])
		let hazel = Hazel(withOptions: options)

		console.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertFalse(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertFalse(fileManager.fileExists(atPath: ".editorconfig"))
	}

	func testSwiftProject() {
		let console = Console.default
		let options = console.parseArguments([ "HazelTests", "--type", "swift" ])
		let hazel = Hazel(withOptions: options)

		console.silentMode = true
		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "Sources"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Sources/\(self.tmpPath)"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Sources/\(self.tmpPath)/\(self.tmpPath).swift"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests/\(self.tmpPath)Tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests/\(self.tmpPath)Tests/\(self.tmpPath)Tests.swift"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests/\(self.tmpPath)Tests/XCTestManifests.swift"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests/LinuxMain.swift"))
	}

}
