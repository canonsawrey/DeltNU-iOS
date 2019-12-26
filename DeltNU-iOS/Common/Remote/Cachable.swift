//
//  Cachable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/26/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol Cachable {
    func fetchAndCache() -> AnyPublisher<CacheResponse, Never>
}

struct CacheResponse {
    let success: Bool
}
