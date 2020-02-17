//
//  LoginViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//
import SwiftUI
import Foundation
import Combine

class LoginViewModel: ViewModel, ObservableObject, Identifiable {
    //Published to the subscribing View
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    @Published var signingIn = false
    @Published var signedIn = false
    
    //Remote stuff
    private var disposables = Set<AnyCancellable>()
    private var session = Session.shared
    private var credentialRepository: CredentialCache
    private var userRepository: UserRepository
    private var directoryCache: DirectoryCache
    private var authRemote: AuthRemote
    
    func login() {
        self.signingIn = true
        print("\n\n\nLOGIN CALLED\n\n\n")
        
        authRemote.authenticate(credential: Credential(email: self.email, password: self.password))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.badCredentials()
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] authResponse in
                    guard let self = self else { return }
                    //TODO This is a terrible way to do this. We should find a way to throw a combine error if auth fails
                    if authResponse.success {
                        self.credentialRepository.storeCredentials(email: self.email, password: self.password)
                        self.signingIn = false
                        self.signedIn = true
                        self.setupSession()
                    } else {
                        self.badCredentials()
                    }
            })
            .store(in: &disposables)
    }
    
    private func badCredentials() {
        self.error = "Sign in with these credentials failed"
        self.signingIn = false
    }
    
    private func setupSession() {
        self.session.fillCaches(userEmail: self.email)
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
                    self.userRepository.setUser(user: self.directoryCache.getUser(email: self.email))
                    withAnimation {
                        self.session.activeSession = true
                    }
            })
            .store(in: &disposables)
    }
    
    override init() {
        self.credentialRepository = DefaultCredentialCache()
        self.authRemote = DefaultAuthRemote()
        self.directoryCache = DefaultDirectoryCache()
        self.userRepository = DefaultUserRepository()
        let response = credentialRepository.getCachedCredentials()
        super.init()
        if (response is CredentialSuccess) {
            self.email = (response as! CredentialSuccess).email
            self.password = (response as! CredentialSuccess).password
            self.login()
        }
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
