//
//  CGenerator.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

final class CGenerator: Generator {

  override init() {
		super.init()
		self.directories = ["bin", "obj", "src", "tests"]
		self.defaultFiles = ["Makefile", ".editorconfig"]
	}

}
