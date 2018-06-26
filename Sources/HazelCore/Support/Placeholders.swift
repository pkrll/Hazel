//
//  Placeholders.swift
//  HazelCore
//
//  Created by Ardalan Samimi on 2018-06-26.
//
import Foundation

public struct Placeholders: Codable {

	public let placeholders: [String: String]

	public init(from coder: Decoder) throws {
		let singleValueContainer  = try coder.singleValueContainer()
		let placeholderDictionary = try singleValueContainer.decode([String: String].self)

		self.placeholders = placeholderDictionary
	}

	public static func load() -> Placeholders? {
		let jsonURL = URL(fileURLWithPath: "\(Application.Paths.configPath)/placeholders.json")
		let decoder = JSONDecoder()

		if let jsonData = try? Data(contentsOf: jsonURL) {
			 return try? decoder.decode(Placeholders.self, from: jsonData)
		}

		return nil
	}

}
