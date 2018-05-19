import Foundation

struct CLang: Lang {

	let appName: String
	let version: String

	let generateMakefile: Bool = false;
	let generateEditorconfig: Bool = false;

	init(appName: String, version: String) {
		self.appName = appName
		self.version = version
		self.generate
	}



}
