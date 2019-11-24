//
//  Poll.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

// MARK: - PollElement
struct Poll: Codable, Identifiable {
    let id: Int
    let title: String
    let question: JSONNull?
    let createdBy: Int
    let expires, createdAt, updatedAt: String
    let abstain, linkedQuestion: JSONNull?
    let options: [String]
    let poll: Bool?
    let eventid: JSONNull?
    let chapterID: Int

    enum CodingKeys: String, CodingKey {
        case id, title, question
        case createdBy = "created_by"
        case expires
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case abstain
        case linkedQuestion = "linked_question"
        case options, poll, eventid
        case chapterID = "chapter_id"
    }
    
    var isActive: Bool {
        return true
    }
    
    var identifiableOptions: [Option] {
        var optionsArray = [Option]()
        for opt in self.options {
            optionsArray.append(Option(option: opt))
        }
        return optionsArray
    }
}
typealias PollArray = [Poll]

// MARK: - Encode/decode helpers

class Option: Identifiable {
    var option: String
    
    init(option: String) {
        self.option = option
    }
    
    var id: Int {
        return option.hashValue
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
