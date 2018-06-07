//
// HazelTests.swift
// Created by Ardalan Samimi
//
import XCTest
@testable import HazelCore

final class HazelTests: XCTestCase {

	func testCProject() {
		let tmpPath = "tmp"
		let fileManager = FileManager.default

		var hazel = Hazel(withOptions: (ProjectType.C, false, false))
		hazel.silentMode = true

		do {
			try fileManager.createDirectory(at: URL(fileURLWithPath: tmpPath), withIntermediateDirectories: false)
		} catch {
			XCTAssertTrue(false)
		}

		fileManager.changeCurrentDirectoryPath(tmpPath)

		hazel.run()

		XCTAssertTrue(fileManager.fileExists(atPath: "obj"))
		XCTAssertTrue(fileManager.fileExists(atPath: "bin"))
		XCTAssertTrue(fileManager.fileExists(atPath: "src"))
		XCTAssertTrue(fileManager.fileExists(atPath: "tests"))
		XCTAssertTrue(fileManager.fileExists(atPath: "Makefile"))
		XCTAssertTrue(fileManager.fileExists(atPath: ".editorconfig"))

		fileManager.changeCurrentDirectoryPath("../")

		try? fileManager.removeItem(atPath: tmpPath)
	}

	static var allTests = [
		("testCProject", testCProject),
	]

}
