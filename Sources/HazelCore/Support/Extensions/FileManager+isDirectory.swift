//
//  FileManager+isDirectory.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-14.
//
import Foundation

extension FileManager {

	func isDirectory(_ path: String) -> Bool {
		var isDirectory: ObjCBool = false

		if self.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue {
			return true
		}

		return false
	}

}
