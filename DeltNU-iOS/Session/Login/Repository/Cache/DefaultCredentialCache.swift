//
//  DefaultCredentialRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/5/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

class DefaultCredentialCache: CredentialCache {
    private let defaults = UserDefaults.standard
    private let emailKey = UserDefaultsKeyApi.credentialEmail
    private let passwordKey = UserDefaultsKeyApi.credentialPassword
    private let saltCache = SaltCache()
    
    func getCachedCredentials() -> CredentialResponse {
        let email = defaults.string(forKey: emailKey)
        let password = defaults.string(forKey: passwordKey)
        
        if email != nil && password != nil {
            return CredentialSuccess(email: saltCache.quickDecrypt(email!),
                                     password: saltCache.quickDecrypt(password!))
        }
        return CredentialFailure(reason: "Email or password not found")
    }
    
    func storeCredentials(email: String, password: String) {
        defaults.set(saltCache.quickEncrypt(email), forKey: emailKey)
        defaults.set(saltCache.quickEncrypt(password), forKey: passwordKey)
    }
    
    func clearCredentials() {
        defaults.removeObject(forKey: emailKey)
        defaults.removeObject(forKey: passwordKey)
    }
}
