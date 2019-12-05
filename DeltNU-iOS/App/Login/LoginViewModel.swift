//
//  LoginViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//
import SwiftUI
import Foundation

class LoginViewModel: ViewModel, ObservableObject, Identifiable {
    //Published to the subscribing View
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    @Published var loggingIn = false
    //Objects to control state of our app
    private var session: Session
    private var credentialRepository: DefaultCredentialRepository
    //Some state mngmnt stuff
    private var previousRequestEmail = ""
    private var previousRequestPassword = ""
    
    var textChangedSincePreviousRequest: Bool {
        return !(email == previousRequestEmail && password == previousRequestPassword)
    }
    
    func login() {
        Timer.scheduledTimer(timeInterval: 2.0,
                             target: self,
                             selector: #selector(evalCredentials),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc private func evalCredentials() {
        if (self.email == "MockUser" && password == "MockUser") {
            credentialRepository.storeCredentials(email: self.email, password: self.password)
            session.sessionCookie = Session.mockSessionCookie
            withAnimation {
                session.loggedIn = true
            }
        } else {
            previousRequestEmail = email
            previousRequestPassword = password
            self.error = "Login with input credentials failed"
            self.loggingIn = false
        }
    }
    
    init(session: Session) {
        self.session = session
        self.credentialRepository = DefaultCredentialRepository()
        let response = credentialRepository.getCachedCredentials()
        if (response is CredentialSuccess) {
            self.email = (response as! CredentialSuccess).email
            self.password = (response as! CredentialSuccess).password
        }
    }
}
