//
//  String+lastPathComponent.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-14.
//
import Foundation

public extension String {

	public var lastPathComponent: String {
		return URL(fileURLWithPath: self).lastPathComponent
	}

}
