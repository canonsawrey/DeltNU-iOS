//
//  LoginViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

class LoginViewModel: ViewModel, ObservableObject, Identifiable {
    //Published to the subscribing View
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    @Published var loggingIn = false
    var session: Session
    
    func login() {
        Timer.scheduledTimer(timeInterval: 2.0,
                             target: self,
                             selector: #selector(evalCredentials),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc private func evalCredentials() {
        if (self.email == "MockUser" && password == "MockUser") {
            session.authToken = "12345678"
            session.loggedIn = true
            session.mockedLogin = true
        } else {
            self.error = "Login failed. Try again"
            self.loggingIn = false
        }
    }
    
    init(session: Session) {
        self.session = session
    }
}
