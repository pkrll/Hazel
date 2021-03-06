//
//  Application.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import Foundation

public enum Application {

	public static let appName: String = "Hazel"
	public static let version: String = "1.1.2"

	public enum Paths {
		#if DEBUG
			public static var configPath: String = "/tmp/hazel"
			public static var templatesPath: String = "/tmp/hazel/templates"
		#else
			public static var configPath: String {
				var baseDirectory: String

				if #available(macOS 10.12, *) {
					baseDirectory = FileManager.default.homeDirectoryForCurrentUser.path
				} else {
					baseDirectory = NSHomeDirectory()
				}

				return "\(baseDirectory)/.hazel"
			}

			public static var templatesPath: String {
				return "\(Application.Paths.configPath)/templates"
			}
		#endif
	}

}
