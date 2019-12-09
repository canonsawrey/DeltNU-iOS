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
        sessionTokenFetchable.authenticate(
            credential: Credential(email: self.email, password: self.password)
        )
            .receive(on: DispatchQueue.main)
            .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.previousRequestEmail = self.email
                    self.previousRequestPassword = self.password
                    self.error = "Login with these credentials failed"
                    self.loggingIn = false
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] authResponse in
                guard let self = self else { return }
                self.credentialRepository.storeCredentials(email: self.email, password: self.password)
                self.session.sessionCookie = authResponse.sessionCookie
                withAnimation {
                    self.session.loggedIn = true
                }
            })
            .store(in: &disposables)
    }
//
//        Timer.scheduledTimer(timeInterval: 2.0,
//                             target: self,
//                             selector: #selector(evalCredentials),
//                             userInfo: nil,
//                             repeats: false)
//    }
//
//    @objc private func evalCredentials() {
//        if (self.email == "MockUser" && password == "MockUser") {
//            credentialRepository.storeCredentials(email: self.email, password: self.password)
//            session.sessionCookie = Session.mockSessionCookie
//            withAnimation {
//                session.loggedIn = true
//            }
//        } else {
//            previousRequestEmail = email
//            previousRequestPassword = password
//            self.error = "Login with input credentials failed"
//            self.loggingIn = false
//        }
//    }
    
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
