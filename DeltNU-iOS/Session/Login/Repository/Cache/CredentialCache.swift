//
//  CredentialRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/5/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

protocol CredentialCache {
    func getCachedCredentials() -> CredentialResponse
    func storeCredentials(email: String, password: String)
    func clearCredentials()
}

protocol CredentialResponse {
    func getCredentials() -> Credential?
}

struct CredentialFailure: CredentialResponse {
    func getCredentials() -> Credential? {
        return nil
    }
    let reason: String
}

struct CredentialSuccess: CredentialResponse {
    func getCredentials() -> Credential? {
        return Credential(email: email, password: password)
    }
    let email: String
    let password: String
}
