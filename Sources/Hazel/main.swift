//
//  main.swift
//  Hazel
//
//  Created by Ardalan Samimi on 2018-06-13.
//
import HazelCore

let consoleIO = ConsoleIO.default
let arguments = consoleIO.parse()

let app = Hazel(consoleIO)

if arguments.initialize.value {
	app.initialize(arguments.initialize)
}
