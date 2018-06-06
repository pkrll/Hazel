//
// Console.swift
// Created by Ardalan Samimi on 2018-06-06
//

import Rainbow

final class Console {

	func write(message: String, ofType type: ConsoleOutputType = .standard) {
		let message = (type == .standard) ? message.blue : message.red
		print(message)
	}

	func read() -> String? {
		return readLine()
	}

}
