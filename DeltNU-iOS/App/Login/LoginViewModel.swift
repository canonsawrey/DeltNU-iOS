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
    //Environment object to control session state of our app
    private var session: Session
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
                             repeats: true)
    }
    
    @objc private func evalCredentials() {
        if (self.email == "MockUser" && password == "MockUser") {
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
    }
}
