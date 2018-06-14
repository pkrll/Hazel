//
//  Application.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

public enum Application {

	public static let appName: String = "Hazel"
	public static let version: String = "1.0.0"

	public enum Paths {
		#if DEBUG
			public static var templatesPath: String = "/tmp/hazel/templates"
		#else
			public static var templatesPath: String {
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
