//
//  CredentialFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/2/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultSessionTokenFetcher: SessionTokenFetchable {
    private let session: URLSession
    private let url: URL = URL(string: "https://www.deltnu.com/app_login")!
    private var cancellable: AnyCancellable? = nil
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    func authenticate(credential: Credential) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
        //TODO: What we have is fine, would be nice if we could use encoding/decoding APIs though
        //let encoder = JSONEncoder()
        //let jsonData = try! encoder.encode(credential)
        
        var urlRequest = URLRequest(url: url)

        let bodyData = "email=\(credential.email)&password=\(credential.password)"
        
        urlRequest.httpBody = bodyData.data(using: String.Encoding.utf8)
        urlRequest.httpMethod = "POST"
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
              .network(description: error.localizedDescription)
            }
            .flatMap() { output in
                self.getSessionCookie(output.response as! HTTPURLResponse, url: self.url)
            }
            .eraseToAnyPublisher()
    }
}

extension DefaultSessionTokenFetcher {
    func getSessionCookie(_ response: HTTPURLResponse, url: URL) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
        var sessionCookie: HTTPCookie? = nil
        if let unwrappedCookies = HTTPCookieStorage.shared.cookies {
            sessionCookie = unwrappedCookies.first { cookie in
                cookie.name == "_deltwebsite_session"
            }
        }
        
        var authResponse = AuthenticationResponse(sessionCookie: nil)
        if let unwrappedSessionCookie = sessionCookie {
            authResponse = AuthenticationResponse(sessionCookie: unwrappedSessionCookie.value)
        }
        
        return Just(authResponse)
            .mapError { error in
                .network(description: "HTTPURLResponse did not contain a relevenat cookie")
            }
            .eraseToAnyPublisher()
    }
}
