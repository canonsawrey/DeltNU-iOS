//
//  Minute.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//
import Foundation

// MARK: - Minute
struct Minute: Codable, Identifiable {
    let id: Int
    let title: String
    let createdAt, updatedAt: Date
    let pdfFileName: String?
    let pdfContentType: String?
    let pdfFileSize: Int?
    let pdfUpdatedAt: Date?
    let newmember: Bool?
    let masterform: String
    let chapterID: Int

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pdfFileName = "pdf_file_name"
        case pdfContentType = "pdf_content_type"
        case pdfFileSize = "pdf_file_size"
        case pdfUpdatedAt = "pdf_updated_at"
        case newmember, masterform
        case chapterID = "chapter_id"
    }
}

typealias Minutes = [Minute]

// MARK: - Encode/decode helpers
