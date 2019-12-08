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
        //let encoder = JSONEncoder()
        
        //TODO_LUKE: You might have a more idiomatic way to write this
        //let jsonData = try! encoder.encode(credential)
//        catch {
//            let error = DeltNuError.parsing(description: "Unable to encode credentials")
//            return Fail(error: error).eraseToAnyPublisher()
//        }
        
        var urlRequest = URLRequest(url: url)
        
        //BAD-----------
        let params = ["email": "sawrey.c@husky.neu.edu", "password": "deltPASS814"]
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        //END BAD-------
        
        urlRequest.httpMethod = "POST"
        //urlRequest.httpBody = jsonData
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
              .network(description: error.localizedDescription)
            }
            .flatMap() { output in
                self.sessionCookie(output.response, url: self.url)
            }
        .eraseToAnyPublisher()
    }
}

extension DefaultSessionTokenFetcher {
    func sessionCookie(_ response: URLResponse, url: URL) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
        let http = response as! HTTPURLResponse
        let headers = (response as! HTTPURLResponse).allHeaderFields as! [String: String]
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
        
        print(http.statusCode)
        print("Headers")
        for header in http.allHeaderFields {
            print(header)
        }
        print("Stored cookies")
        for cookie in HTTPCookieStorage.shared.cookies(for: url)! as [HTTPCookie] {
            print("Extracted cookie: \(cookie)")
        }
        print("Other cookies")
        print(cookies)
        
        let authResponse = AuthenticationResponse(sessionCookie: "1234")
        
        return Just(authResponse)
            .mapError { error in
                .network(description: "HTTPURLResponse did not contain a relevenat cookie")
        }
        .eraseToAnyPublisher()
    }
}
