//
//  DefaultMinutesCache.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/16/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultMinutesCache: MinutesCache {
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    private let cacheKey = "key::minutes_cache"
    
    func getCachedMinutes() -> AnyPublisher<Minutes, DeltNuError> {
        return Just(userDefaults.data(forKey: cacheKey))
            .map { wrappedData -> Minutes in
                if let data = wrappedData {
                    return try! coder.decoder.decode(Minutes.self, from: data)
                } else {
                    return []
                }
            }
            .mapError { error in
                .cache(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    
    func setCachedMinutes(minutes: Minutes) -> Bool {
        do {
            try userDefaults.set(coder.encoder.encode(minutes), forKey: cacheKey)
            return true
        } catch {
            return false
        }
    }
}
