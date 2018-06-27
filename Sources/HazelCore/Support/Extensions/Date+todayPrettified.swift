//
//  Date+todayPrettified.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-16.
//
import Foundation

extension Date {

	func todayPrettified() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"

		return formatter.string(from: self)
	}

}
