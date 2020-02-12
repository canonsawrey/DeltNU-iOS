//
//  EndpointApi.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class EndpointApi {

    //Singleton stuff
    static let shared = EndpointApi()
    private init() { }
    
    static let login = "https://www.deltnu.com/app_login"
    static let resetPassword = "https://www.deltnu.com/password_resets/new"
    static let minutesIndex =  "https://www.deltnu.com/minutes/app_index"
    static let minutesDetail =  "https://www.deltnu.com/minutes/"
    static let votePost =  "https://www.deltnu.com/questions/app_vote"
    static let voteIndex =  "https://www.deltnu.com/questions/app_index"
    static let directoryIndex =  "https://www.deltnu.com/directory/app_index"
    static let serviceHoursIndex = "https://www.deltnu.com/servicehours/app_index"
    
}
