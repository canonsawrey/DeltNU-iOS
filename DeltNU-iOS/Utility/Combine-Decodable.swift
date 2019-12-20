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
  //TODO change this to coder abstraction
    let decoder = JSONDecoder()
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
  decoder.dateDecodingStrategy = .formatted(formatter)

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
