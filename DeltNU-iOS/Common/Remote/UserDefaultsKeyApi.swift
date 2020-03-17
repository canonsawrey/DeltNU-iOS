//
//  UserDefaultsKeyApi.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

class UserDefaultsKeyApi {

    //Singleton stuff
    static let shared = UserDefaultsKeyApi()
    private init() { }
    
    static let user = "key::user"
    static let credentialEmail = "key::email"
    static let credentialPassword =  "key::password"
    static let minutes = "key::minutes"
    static let directory =  "key::directory"
    static let polls = "key::polls"
    static let serviceHours = "key::serviceHours"
    static let attendanceLastMarked = "key::attendanceLastMarked"
}
