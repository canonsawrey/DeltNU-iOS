//
//  DefaultVoteCache.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/26/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultVoteCache: VoteCache {
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    private let cacheKey = UserDefaultsKeyApi.polls
    
    func getCachedPolls() -> AnyPublisher<Polls, DeltNuError> {
        return Just(userDefaults.data(forKey: cacheKey))
            .map { wrappedData -> Polls in
                if let data = wrappedData {
                    return try! coder.decoder.decode(Polls.self, from: data)
                } else {
                    return []
                }
            }
            .mapError { error in
                .cache(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    func setCachedPolls(polls: Polls) -> Bool {
        do {
            try userDefaults.set(coder.encoder.encode(polls), forKey: cacheKey)
            return true
        } catch {
            return false
        }
    }
}
