import XCTest

import HazelTests

var tests = [XCTestCaseEntry]()
tests += HazelTests.allTests()
XCTMain(tests)
