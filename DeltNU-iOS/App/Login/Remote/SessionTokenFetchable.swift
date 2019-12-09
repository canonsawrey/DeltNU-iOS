//
//  CredentialsFetchable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/2/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol SessionTokenFetchable {
    func authenticate(credential: Credential) -> AnyPublisher<AuthenticationResponse, DeltNuError>
}

struct AuthenticationResponse: Codable {
    let sessionCookie: String
}
