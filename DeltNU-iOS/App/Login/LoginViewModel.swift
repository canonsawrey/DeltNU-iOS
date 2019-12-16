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
    @Published var loggingIn = false
    
    //Local state mngmnt stuff
    private var previousRequestEmail = ""
    private var previousRequestPassword = ""
    
    //Remote stuff
    private var disposables = Set<AnyCancellable>()
    private var session = Session.shared
    private var credentialRepository: CredentialRepository
    private var sessionTokenFetchable: SessionTokenFetchable
    
    //Computed properties
    var textChangedSincePreviousRequest: Bool {
        return !(email == previousRequestEmail && password == previousRequestPassword)
    }
    
    func login() {
        self.loggingIn = true
        
        sessionTokenFetchable.authenticate(
            credential: Credential(email: self.email, password: self.password)
        )
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
                if let cookie = authResponse.sessionCookie {
                    self.credentialRepository.storeCredentials(email: self.email, password: self.password)
                    self.session.sessionCookie = cookie
                    withAnimation {
                        self.session.loggedIn = true
                    }
                } else {
                    self.badCredentials()
                }
            })
            .store(in: &disposables)
    }
    
    private func badCredentials() {
        self.previousRequestEmail = self.email
        self.previousRequestPassword = self.password
        self.error = "Sign in with these credentials failed"
        self.loggingIn = false
    }
    
    override init() {
        self.credentialRepository = DefaultCredentialRepository()
        self.sessionTokenFetchable = DefaultSessionTokenFetcher()
        let response = credentialRepository.getCachedCredentials()
        if (response is CredentialSuccess) {
            self.email = "sawrey.c@husky.neu.edu" //(response as! CredentialSuccess).email
            self.password = "deltPASS814"//(response as! CredentialSuccess).password
        }
    }
}
