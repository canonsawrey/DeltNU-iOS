//
//  CredentialFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/2/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

class CredentialFetcher {
    
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

//extension CredentialFetcher: CredentialFetchable {
//    func authenticate(payload: Data) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
//
//
//        return session.dataTaskPublisher(for: <#T##URL#>).eraseToAnyPublisher()
//    }
//}
