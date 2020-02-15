// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceHours = try? newJSONDecoder().decode(ServiceHours.self, from: jsonData)

import Foundation

// MARK: - ServiceHours
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceHours = try? newJSONDecoder().decode(ServiceHours.self, from: jsonData)

import Foundation

// MARK: - ServiceHours
struct ServiceHours: Codable {
    
    let hours: [Hour]
    let totalHours, hoursGoal, progress: Int
    let topUsers: [User]
    let toporgs: [Toporg]
    let hoursPerUser: [User]
    
    init() {
        hours = []
        totalHours = 0
        hoursGoal = 0
        progress = 0
        topUsers = []
        toporgs = []
        hoursPerUser = []
    }

    enum CodingKeys: String, CodingKey {
        case hours
        case totalHours = "total_hours"
        case hoursGoal = "hours_goal"
        case progress
        case topUsers = "top_users"
        case toporgs
        case hoursPerUser = "hours_per_user"
    }
}

// MARK: - Hour
struct Hour: Codable {
    let id, userid: Int
    let date, hours, organization, hourDescription: String
    let createdAt, updatedAt: String
    let semester: Int

    enum CodingKeys: String, CodingKey {
        case id, userid, date, hours, organization
        case hourDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case semester
    }
}

// MARK: - User
struct User: Codable {
    let id: String?
    let userid: Int
    let sumhours: Double
}

// MARK: - Toporg
struct Toporg: Codable {
    let id: String?
    let organization: String
    let sumhours: Double
}
