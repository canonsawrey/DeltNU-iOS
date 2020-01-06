//
//  CredentialFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/2/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultAuthRemote: AuthRemote {
    private let session: URLSession
    private let url: URL = URL(string: EndpointApi.login)!
    private var cancellable: AnyCancellable? = nil
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    func authenticate(credential: Credential) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
        let request = self.buildRequest(credential: credential)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw DeltNuError.network(description: "Failed cast to HTTPURLResponse")
                }
                guard self.containsSetCookie(response: httpResponse) else {
                    throw DeltNuError.invalidSignIn
                }
                return AuthenticationResponse(success: true, response: httpResponse)
            }
            .mapError { error in
                guard error is DeltNuError else {
                    return DeltNuError.unknown(description: error.localizedDescription)
                }
                return error as! DeltNuError
            }
            .first()
            .eraseToAnyPublisher()
    }
    
    func refreshCookie(credential: Credential) {
        let request = self.buildRequest(credential: credential)
        let result = session.performSynchronously(request: request)
        
        guard let httpResponse = result.response as? HTTPURLResponse else {
            Session.shared.activeSession = false
            return
        }
        guard result.error == nil && self.containsSetCookie(response: httpResponse) else {
            Session.shared.activeSession = false
            return
        }
    }
    
    
    private func containsSetCookie(response: HTTPURLResponse) -> Bool {
        if (response.allHeaderFields.contains(where: { header in
            header.key is String && header.key as! String == "Set-Cookie"
        })) {
            return true
        } else {
            return false
        }
    }
    
    private func buildRequest(credential: Credential) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        let bodyData = "email=\(credential.email)&password=\(credential.password)"
        urlRequest.httpBody = bodyData.data(using: String.Encoding.utf8)
        urlRequest.httpMethod = "POST"
        
        return urlRequest
    }
}
