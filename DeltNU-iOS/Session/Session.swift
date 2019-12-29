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
    
    @Published var activeSession: Bool = false
    
    //For storing user object
    private let userRepository = DefaultUserRepository()
    
    //For refreshing session cookie
    private let authRemote = DefaultAuthRemote()
    private let credentialCache = DefaultCredentialCache()
    
    //For filling caches at the start of the session
    private let voteRemote: Cachable = DefaultVoteRemote()
    private let directoryRemote: Cachable = DefaultDirectoryRemote()
    private let minutesRemote: Cachable = DefaultMinutesRemote()
    
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
    
    func fillCaches(userEmail: String) -> AnyPublisher<[CacheResponse], Never> {
        //TODO dispose of these
        let publishers = [voteRemote.fetchAndCache(), directoryRemote.fetchAndCache(), minutesRemote.fetchAndCache()]
        
        return publishers
            .publisher
            .flatMap { $0 }
            .collect()
            .eraseToAnyPublisher()
    }
    
    func emptyCaches() {
        
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
