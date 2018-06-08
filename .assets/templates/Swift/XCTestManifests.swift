import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(__PROJECTNAME__.allTests),
	]
}
#endif
