//
// LanguageC.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation

final class LanguageC: Generator {

	override var directories: 	[String] {
		return ["bin", "obj", "src", "tests"]
	}

	override var defaultFiles: [String] {
		return ["Makefile", ".editorconfig"]
	}

}
