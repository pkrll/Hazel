//
// Application.swift
// Created by Ardalan Samimi on 2018-06-06
//
import Foundation

enum Application {

	static let appName: String = "Hazel"
	static let version: String = "1.2.1"

	enum Paths {
		#if DEBUG
			static var templatesPath: String = "/tmp/hazel/templates"
		#else
			static var templatesPath: String {
				var baseDirectory: String

				if #available(macOS 10.12, *) {
					baseDirectory = FileManager.default.homeDirectoryForCurrentUser.path
				} else {
					baseDirectory = NSHomeDirectory()
				}

				return "\(baseDirectory)/.hazel/templates"
			}
		#endif
	}

}
