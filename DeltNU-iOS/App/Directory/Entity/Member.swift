//
//  Member.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation


struct Member: Codable, Identifiable {
    let id: Int
    let firstName, lastName, email, passwordDigest: String
    let role: Role
    let pledgeClass: String
    let gradYear: String?
    let createdAt, updatedAt: String
    let pictureFileName: String?
    let pictureContentType: PictureContentType?
    let pictureFileSize: Int?
    let pictureUpdatedAt: String?
    let phoneNumber: String
    let address: String?
    let aptnum: String?
    let major: Major?
    let clubs, nuid: String?
    let active: Bool
    let admin: Bool?
    let latitude, longitude: Double?
    let rememberDigest, resetDigest, resetSentAt: String?
    let gradSemester: Int?
    let pictureURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case passwordDigest = "password_digest"
        case role
        case pledgeClass = "pledge_class"
        case gradYear = "grad_year"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pictureFileName = "picture_file_name"
        case pictureContentType = "picture_content_type"
        case pictureFileSize = "picture_file_size"
        case pictureUpdatedAt = "picture_updated_at"
        case phoneNumber = "phone_number"
        case address, aptnum, major, clubs, nuid, active, admin, latitude, longitude
        case rememberDigest = "remember_digest"
        case resetDigest = "reset_digest"
        case resetSentAt = "reset_sent_at"
        case gradSemester = "grad_semester"
        case pictureURL = "picture_url"
    }
}

enum Major: String, Codable {
    case bioengineering = "Bioengineering"
    case computerScience = "Computer Science"
    case empty = ""
}

enum PictureContentType: String, Codable {
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
}

enum Role: String, Codable {
    case brother = "brother"
    case newMember = "new member"
}

typealias MemberDirectory = [Member]

