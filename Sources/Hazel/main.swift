//
// main.swift
// Created by Ardalan Samimi
//
import HazelCore

let arg = Console.default.parseArguments()
let app = Hazel(withOptions: arg)

app.run()
