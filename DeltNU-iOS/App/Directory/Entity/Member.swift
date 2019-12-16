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
    let pledgeClass: PledgeClass
    let gradYear: String?
    let createdAt, updatedAt: Date
    let pictureFileName: String?
    let pictureContentType: String?
    let pictureFileSize: Int?
    let pictureUpdatedAt: Date?
    let phoneNumber: String
    let address: String?
    let aptnum: String?
    let major: String?
    let clubs, nuid: String?
    let active, admin: Bool
    let latitude, longitude: Double?
    let rememberDigest, resetDigest, resetSentAt: String?
    let gradSemester: Int?


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
    }
}

enum PledgeClass: String, Codable {
    case epsilon = "Epsilon"
    case eta = "Eta"
    case gamma = "Gamma"
    case iota = "Iota"
    case kappa = "Kappa"
    case lambda = "Lambda"
    case mu = "Mu"
    case nu = "Nu"
    case theta = "Theta"
    case zeta = "Zeta"
}

enum Role: String, Codable {
    case brother = "brother"
    case newMember = "new member"
}

typealias MemberDirectory = [Member]
