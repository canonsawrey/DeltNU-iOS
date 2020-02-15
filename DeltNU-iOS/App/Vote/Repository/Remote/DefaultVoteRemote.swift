//
//  DefaultMinutesRemote.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/16/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultVoteRemote: VoteRemote {
    
    private let session: URLSession
    private let url: URL = URL(string: EndpointApi.voteIndex)!
    private var cancellable: AnyCancellable? = nil
    private let voteCache = DefaultVoteCache()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRemotePolls() -> AnyPublisher<Polls, DeltNuError> {
        let urlRequest = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: urlRequest)
            .checkStatusCode()
            .mapError { error in
                if error is DeltNuError {
                    return error as! DeltNuError
                } else {
                    return DeltNuError.unknown(description: error.localizedDescription)
                }
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .handleEvents(receiveOutput: { output in
                self.voteCache.setCachedPolls(polls: output)
            })
            .eraseToAnyPublisher()
    }
    
    func fetchAndCache() -> AnyPublisher<CacheResponse, Never> {
        let urlRequest = URLRequest(url: url)
        var cacheSuccess = false
        
        return session.dataTaskPublisher(for: urlRequest)
        .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .handleEvents(receiveOutput: { output in
            cacheSuccess = self.voteCache.setCachedPolls(polls: output)
        })
        .map{ polls in
            CacheResponse(success: cacheSuccess)
        }
        .replaceError(with: CacheResponse(success: false))
        .eraseToAnyPublisher()
    }
}
