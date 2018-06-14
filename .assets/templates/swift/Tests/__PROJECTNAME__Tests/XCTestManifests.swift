import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(__PROJECTNAME__Tests.allTests)
	]
}
#endif
