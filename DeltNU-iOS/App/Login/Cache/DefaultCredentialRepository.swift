//
//  DefaultCredentialRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/5/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation


//TODO_ANY: This needs to be encyprted
class DefaultCredentialRepository: CredentialRepository {
    private let defaults = UserDefaults.standard
    private let emailKey = "key::email"
    private let passwordKey = "key::password"
    
    func getCachedCredentials() -> CredentialResponse {
        let email = defaults.string(forKey: emailKey)
        let password = defaults.string(forKey: passwordKey)
        
        if email != nil && password != nil {
            return CredentialSuccess(email: email!, password: password!)
        }
        return CredentialFailure(reason: "Email or password not found")
    }
    
    func storeCredentials(email: String, password: String) {
        defaults.set(email, forKey: emailKey)
        defaults.set(password, forKey: passwordKey)
    }
    
    func clearCredentials() {
        defaults.removeObject(forKey: emailKey)
        defaults.removeObject(forKey: passwordKey)
    }
}
