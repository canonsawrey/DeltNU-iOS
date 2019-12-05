//
//  CredentialRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/5/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

protocol CredentialRepository {
    func getCachedCredentials() -> CredentialResponse
    func storeCredentials(email: String, password: String) -> CredentialResponse
    func clearCredentials()
}

protocol CredentialResponse { }

struct CredentialFailure: CredentialResponse {
    let reason: String
}

struct CredentialSuccess: CredentialResponse {
    let email: String
    let password: String
}
