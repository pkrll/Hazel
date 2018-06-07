//
// LanguageSwift.swift
// Created by Ardalan Samimi on 2018-06-08
//
final class LanguageSwift: Generator {

	override var directories: 	[String] {
		return ["Sources", "Tests"]
	}
	override var defaultFiles: [String] {
		return ["Package.swift", ".editorconfig"]
	}

}
