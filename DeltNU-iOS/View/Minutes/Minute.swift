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
    let createdAt, updatedAt: String
    let pdfFileName: String?
    let pdfContentType: PDFContentType?
    let pdfFileSize: Int?
    let pdfUpdatedAt: String?
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
    
    var createdAtDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let sub = String(self.createdAt.prefix(19))
        print(sub)
        return formatter.date(from: sub)
    }
    
    var formattedCreatedAtDate: String {
        if let date = createdAtDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: date)
        } else {
            return "N/A"
        }
    }
}

enum PDFContentType: String, Codable {
    case applicationPDF = "application/pdf"
}

typealias Minutes = [Minute]

// MARK: - Encode/decode helpers
