import Foundation

struct SwiftLang: Lang {

	let appName: String
	let version: String
	let generateMakefile: Bool
	let generateEditorconfig: Bool

	func generateProject(atPath path: String) {
		if (self.generateMakefile) {

		}
	}



}
