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
    //Singleton stuff
    static let shared = Session()
    private init() { }
    
    private let directoryRepository = DefaultDirectoryRepository()
    private let userRepository = DefaultUserRepository()
    
    @Published var activeSession: Bool = false
    private let authRemote = DefaultAuthRemote()
    private let credentialCache = DefaultCredentialCache()
    
    private var disposables = Set<AnyCancellable>()
    
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
    
    func fillCaches(userEmail: String) -> Bool {
        //Fill directory cache + set user object
        let directoryStream = directoryRepository.getMembers()
        var result: Bool = false
        directoryStream.sink(
          receiveCompletion: { [weak self] value in },
          receiveValue: { [weak self] members in
            guard let self = self else { return }
            guard let user = members.first(where: { member in
                member.email == userEmail
            }) else {
                return
            }
            result = self.userRepository.setUser(user: user)
        })
        .store(in: &disposables)
        
        return result
    }
    
    func emptyCaches() {
        
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
