//
//  GetSessionCookie.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/6/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

func sessionCookieeee(_ response: URLResponse, url: URL) -> AnyPublisher<AuthenticationResponse, DeltNuError> {
    let http = response as! HTTPURLResponse
//    let headers = (response as! HTTPURLResponse).allHeaderFields as! [String: String]
//    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
//    print(cookies.count)
    print(http.statusCode)
    print(http.allHeaderFields)
    for cookie in HTTPCookieStorage.shared.cookies(for: url)! as [HTTPCookie] {
        print("Extracted cookie: \(cookie)")
    }
    
    let authResponse = AuthenticationResponse(sessionCookie: "1234")
    
  return Just(authResponse)
    .mapError { error in
        .network(description: "HTTPURLResponse did not contain a relevenat cookie")
    }
    .eraseToAnyPublisher()
}
