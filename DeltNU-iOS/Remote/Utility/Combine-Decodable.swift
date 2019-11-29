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

//TODO This needs to be generic to types beyound DirectoryError
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, DirectoryError> {
  let decoder = JSONDecoder()
  let formatter = DateFormatter() //"2019-03-07T13:00:39.369-05:00"
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
  decoder.dateDecodingStrategy = .formatted(formatter)

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
