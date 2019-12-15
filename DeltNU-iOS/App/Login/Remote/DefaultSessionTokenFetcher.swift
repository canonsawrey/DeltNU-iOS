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
        let encoder = JSONEncoder()
        
        //TODO_LUKE: You might have a more idiomatic way to write this
        let jsonData = try! encoder.encode(credential)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpBody = Data(base64Encoded: "utf8=%E2%9C%93&authenticity_token=32yFmHJPskc%2BdYkYHbQT9P8Zyc28bA5PU5pTrLUl5lfRQ2AFDY4F75Nlfv2NSJqXYAu%2B5AkplJdQweKNB65i8A%3D%3D&session%5Bemail%5D=sawrey.c%40husky.neu.edu&session%5Bpassword%5D=deltPASS814&commit=LOG+IN&session%5Bremember_me%5D=0")//jsonData
        urlRequest.httpMethod = "POST"
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
              .network(description: error.localizedDescription)
            }
            .flatMap() { output in
                self.sessionCookie(output.response as! HTTPURLResponse, url: self.url)
            }
        .eraseToAnyPublisher()
    }
}

extension DefaultSessionTokenFetcher {
    func sessionCookie(_ response: HTTPURLResponse, url: URL) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
//        let headers = (response as! HTTPURLResponse).allHeaderFields as! [String: String]
//        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
        
        print(response.statusCode)
        print(response.allHeaderFields.count)
//        print("Stored cookies")
            let httpCookeis = HTTPCookie.cookies(withResponseHeaderFields: response.allHeaderFields as! [String:String], for: url)
        print(httpCookeis.count)
//        let cookies = HTTPCookieStorage.
//        if let unwrappedCookies = cookies {
//            for cookie in unwrappedCookies {
//                print("Extracted cookie: \(cookie)")
//            }
//        }
        
        let authResponse = AuthenticationResponse(sessionCookie: "1234")
        
        return Just(authResponse)
            .mapError { error in
                .network(description: "HTTPURLResponse did not contain a relevenat cookie")
        }
        .eraseToAnyPublisher()
    }
}
