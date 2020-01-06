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
    func checkStatusCode() -> Publishers.Retry<Publishers.TryMap<URLSession.DataTaskPublisher, URLSession.DataTaskPublisher.Output>> {
        
        return self
            .tryMap { (output) -> URLSession.DataTaskPublisher.Output in
            guard let httpResponse = output.response as? HTTPURLResponse else {
                throw DeltNuError.network(description: "Unable to cast URLResponse to HTTPURLResponse")
            }
            guard httpResponse.statusCode == 200 else {
                if (httpResponse.statusCode == 403) {
                    Session.shared.refreshCookie()
                    throw DeltNuError.network(description: "Auth token expired")
                } else {
                    throw DeltNuError.network(description: "Status code: \(httpResponse.statusCode) received")
                }
            }
                return output
        }.retry(1)
    }
}


extension URLSession {

    func performSynchronously(request: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        let semaphore = DispatchSemaphore(value: 0)

        var data: Data?
        var response: URLResponse?
        var error: Error?

        let task = self.dataTask(with: request) {
            data = $0
            response = $1
            error = $2
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return (data, response, error)
    }
}
