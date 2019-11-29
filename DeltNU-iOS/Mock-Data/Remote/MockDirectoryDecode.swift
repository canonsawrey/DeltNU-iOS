//
//  CombineDecode.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/26/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine


//Decodes JSON as part of a Combine chain
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, DirectoryError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
