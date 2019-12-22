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
    @Published var activeSession: Bool = false

    //Singleton stuff
    static let shared = Session()
    private init() { }
    
    func clearSession() {
        self.activeSession = false
        
        if let unwrappedCookies = HTTPCookieStorage.shared.cookies {
            let sessionCookie = unwrappedCookies.first { cookie in
                cookie.name == "_deltwebsite_session"
            }
            if let cookie = sessionCookie {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            } else {
                fatalError("Could not find session cookie for an active session")
            }
        }
    }
    
    func refreshSetCookie() {
        //TODO this
    }
    
    func fillCaches() {
        
    }
    
    func emptyCaches() {
        
    }
}
