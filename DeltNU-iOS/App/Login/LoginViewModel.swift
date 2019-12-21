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
    
    //Remote stuff
    private var disposables = Set<AnyCancellable>()
    private var session = Session.shared
    private var credentialRepository: CredentialRepository
    private var authRemote: AuthRemote
    
    func login() {
        self.signingIn = true
        
        authRemote.authenticate(
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
                if authResponse.success {
                    self.credentialRepository.storeCredentials(email: self.email, password: self.password)
                    withAnimation {
                        self.session.activeSession = true
                    }
                    //session.loadAppData()
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
    
    override init() {
        self.credentialRepository = DefaultCredentialRepository()
        self.authRemote = DefaultAuthRemote()
        let response = credentialRepository.getCachedCredentials()
        super.init()
        if (response is CredentialSuccess) {
            self.email = (response as! CredentialSuccess).email
            self.password = (response as! CredentialSuccess).password
            self.login()
        }
    }
}
