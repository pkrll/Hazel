//
// HazelTests.swift
// Created by Ardalan Samimi
//
import XCTest
import SwiftArgs
@testable import HazelCore

final class HazelTests: XCTestCase {

	static var allTests = [
		("testCProjectWithMakeAndConf", testCProjectWithMakeAndConf),
		("testCProjectWithMakeNoConf", testCProjectWithMakeNoConf),
		("testSwiftProject", testSwiftProject),
		("testError", testError)
	]

	let tmpPath = "hazel_test"
	let fileManager = FileManager.default

	override func setUp() {
		fileManager.changeCurrentDirectoryPath("/tmp")
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
		let console = ConsoleIO.default
		let options = console.parse(["-q", "init", "--type", "c" ])
		let hazel = Hazel(console)

		if options.initialize.value {
			hazel.initialize(options.initialize)
		}

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertTrue(fileManager.fileExists(atPath: ".editorconfig"))
	}

	func testCProjectWithMakeNoConf() {
		let console = ConsoleIO.default
		let options = console.parse([ "init", "--type", "c", "--no-config" ])
		let hazel = Hazel(console)

		ConsoleIO.default.silentMode = true

		if options.initialize.value {
			hazel.initialize(options.initialize)
		}

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertFalse(fileManager.fileExists(atPath: ".editorconfig"))
	}

	func testSwiftProject() {
		let console = ConsoleIO.default
		let options = console.parse([ "init", "--type", "swift" ])
		let hazel = Hazel(console)

		ConsoleIO.default.silentMode = true

		if options.initialize.value {
			hazel.initialize(options.initialize)
		}

		XCTAssertTrue(fileManager.fileExists(atPath: "Sources"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Sources/\(self.tmpPath)"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Sources/\(self.tmpPath)/\(self.tmpPath).swift"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Tests/\(self.tmpPath)Tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Tests/\(self.tmpPath)Tests/\(self.tmpPath)Tests.swift"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Tests/\(self.tmpPath)Tests/XCTestManifests.swift"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Tests/LinuxMain.swift"))
	}

	func testError() {
		let generator = Generator("yahoo")

		do {
			try generator.prepare()
			XCTAssertTrue(false)
		} catch GeneratorError.unrecognizedProjectType(let type) {
			XCTAssertEqual("yahoo", type)
		} catch {
			XCTAssertTrue(false)
		}
	}

}
