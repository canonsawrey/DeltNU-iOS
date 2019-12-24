//
//  CredentialsFetchable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/2/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol AuthRemote {
    func authenticate(credential: Credential) -> AnyPublisher<AuthenticationResponse, DeltNuError>
}

struct AuthenticationResponse {
    let success: Bool
    let response: HTTPURLResponse?
}
