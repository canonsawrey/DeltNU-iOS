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

func decodePolls(_ data: Data) -> AnyPublisher<Polls, DeltNuError> {
    let coder = Coder()

  return Just(data)
    .decode(type: Polls.self, decoder: coder.decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

extension URLSession.DataTaskPublisher {
//    func catch302() -> AnyPublisher<Int, DeltNuError> {
//        return self
//            .mapError { error in
//                .network(description: error.localizedDescription)
//            }
//            .flatMap { pair in
//            guard let httpResponse = pair.response as? HTTPURLResponse else {
//                fatalError("Catch 302 should only be used on HTTP requests")
//            }
//            if httpResponse.statusCode == 302 {
//                return 1
//            } else {
//                return 2
//            }
//        }.eraseToAnyPublisher()
//    }
}

