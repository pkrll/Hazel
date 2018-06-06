//
// Application.swift
// Created by Ardalan Samimi on 2018-06-06
//

internal enum Application {

	static let appName: String = "Hazel"
	static let version: String = "1.0.0"

	enum Paths {
		#if DEBUG
			static let templates: String = "Public/Git/Hazel/templates"
		#else
			static let templates: String = ".hazel/templates"
		#endif
	}

}
