//
//  Combine-Decode.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, DeltNuError> {
    let coder = Coder()

  return Just(data)
    .decode(type: T.self, decoder: coder.decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

extension URLSession.DataTaskPublisher {
    func checkStatusCode() -> Publishers.TryMap<URLSession.DataTaskPublisher, URLSession.DataTaskPublisher.Output> {
        var refreshSent = false
        
        return self
            .tryMap { (output) -> URLSession.DataTaskPublisher.Output in
            guard let httpResponse = output.response as? HTTPURLResponse else {
                throw DeltNuError.network(description: "Unable to cast URLResponse to HTTPURLResponse")
            }
            guard httpResponse.statusCode == 400 else {
                if (httpResponse.statusCode == 302) {
                    if !refreshSent {
                        Session.shared.refreshCookie()
                        refreshSent = true
                    }
                    throw DeltNuError.network(description: "Auth token expired")
                } else {
                    throw DeltNuError.network(description: "Status code: \(httpResponse.statusCode) received")
                }
            }
            return output
        }
    }
}

