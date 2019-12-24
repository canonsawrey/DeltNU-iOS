//
//  Session.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Session: ObservableObject {
    @Published var activeSession: Bool = false
    let authRemote = DefaultAuthRemote()
    let credentialCache = DefaultCredentialCache()

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
    
    func refreshCookie() -> AnyPublisher<AuthenticationResponse, DeltNuError> {
        let credentials = credentialCache.getCachedCredentials()
        //TODO Fix the hard cast
        let credentialSuccess = credentials as! CredentialSuccess
        let credential = Credential(email: credentialSuccess.email, password: credentialSuccess.password)
        return authRemote.authenticate(credential: credential)
    }
    
    func fillCaches() {
        
    }
    
    func emptyCaches() {
        
    }
}
