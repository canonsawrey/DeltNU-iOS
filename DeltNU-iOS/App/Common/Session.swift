//
//  Session.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI

class Session: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var sessionCookie: String? = nil
    static let mockSessionCookie = "mockSessionCookie123456789"

    //Singleton stuff
    static let shared = Session()
    private init() { }
    
    func clearSession() {
        self.loggedIn = false
        self.sessionCookie = nil
        
        if let unwrappedCookies = HTTPCookieStorage.shared.cookies {
            let sessionCookie = unwrappedCookies.first { cookie in
                cookie.name == "_deltwebsite_session"
            }
            if let cookie = sessionCookie {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
}
