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
    @Published var globalError = false
    @Published var globalErrorMessage = "Try again later."
    //For storing user object
    private let userRepository = DefaultUserRepository()
    
    //For refreshing session cookie
    private let authRemote = DefaultAuthRemote()
    private let credentialCache = DefaultCredentialCache()
    
    //For filling caches at the start of the session
    private let voteRemote: Cachable = DefaultVoteRemote()
    private let directoryRemote: Cachable = DefaultDirectoryRemote()
    private let minutesRemote: Cachable = DefaultMinutesRemote()
    //private let serviceHoursRemote: Cachable = DefaultServiceHoursRemote()
    private let directoryCache = DefaultDirectoryCache()
    
    private var disposables = Set<AnyCancellable>()
        
    func clearSession(deactivateSession: Bool = true) {
        if (deactivateSession) {
            self.activeSession = false
        }
        
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
    
    func refreshCookie() {
        clearSession(deactivateSession: false)
        let credentials = credentialCache.getCachedCredentials()
        //TODO Fix the hard cast
        guard let credentialSuccess = credentials as? CredentialSuccess else {
            self.activeSession = false
            return
        }
        let credential = Credential(email: credentialSuccess.email, password: credentialSuccess.password)
        authRemote.refreshCookie(credential: credential)
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
        //TODO implement these
    }
    
    func initSession(showApp: @escaping () -> Void) {
        guard let credentials = credentialCache.getCachedCredentials().getCredentials() else {
            showApp()
            return
        }
        
        self.authRemote.authenticate(credential: credentials)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] value in
                        guard let self = self else { return }
                        switch value {
                        case .failure:
                            showApp()
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { [weak self] authResponse in
                        guard let self = self else { return }
                        //TODO This is a terrible way to do this. We should find a way to throw a combine error if auth fails
                        if authResponse.success {
                            self.setupSession(credential: credentials, showApp: showApp)
                        } else {
                            showApp()
                        }
                })
                .store(in: &disposables)
        }
        
    private func setupSession(credential: Credential, showApp: @escaping () -> Void) {
            self.fillCaches(userEmail: credential.email)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] value in
                        guard let self = self else { return }
                        switch value {
                        //TODO handle these
                        case .failure:
                            break
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { [weak self] cacheResponse in
                        guard let self = self else { return }
                        //TODO this prrooooobably should live elsewhere and its pretty ugly
                        self.userRepository.setUser(user: self.directoryCache.getUser(email: credential.email))
                        self.activeSession = true
                        showApp()
                })
                .store(in: &disposables)
        }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}


