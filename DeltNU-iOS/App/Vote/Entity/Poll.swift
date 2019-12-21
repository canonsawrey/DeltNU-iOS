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
    let question: String?
    let createdBy: Int
    let expires, createdAt, updatedAt: Date
    let abstain, linkedQuestion: String?
    let options: [Option]

    enum CodingKeys: String, CodingKey {
        case id, title, question
        case createdBy = "created_by"
        case expires
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case abstain
        case linkedQuestion = "linked_question"
        case options
    }
    
    var isActive: Bool {
        return Date() < expires
    }
    
}
typealias Polls = [Poll]

struct Option: Codable {
    let id: Int
    let name: String
    let questionid: Int
    let createdAt, updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id, name, questionid
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
