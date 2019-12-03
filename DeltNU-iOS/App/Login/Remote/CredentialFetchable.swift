//
//  CredentialsFetchable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/2/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol CredentialFetchable {
    func authenticate(payload: Data) -> AnyPublisher<AuthenticationResponse, DeltNuError>
}
