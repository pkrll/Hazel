//
// LanguageC.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation

final class LanguageC: Generator {

	override init() {
		super.init()
		self.directories 	= ["bin", "obj", "src", "tests"]
		self.defaultFiles = ["Makefile", ".editorconfig"]
	}

}
