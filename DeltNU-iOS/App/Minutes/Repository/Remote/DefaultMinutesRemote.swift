//
//  DefaultMinutesFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/15/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultMinutesRemote: MinutesRemote {
    
    private let session: URLSession
    private let url: URL = URL(string: EndpointApi.minutesIndex)!
    private var cancellable: AnyCancellable? = nil
    private let minutesCache = DefaultMinutesCache()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRemoteMinutes() -> AnyPublisher<Minutes, DeltNuError> {
        let urlRequest = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: urlRequest)
            //.checkStatusCode()
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .handleEvents(receiveOutput: { output in
            self.minutesCache.setCachedMinutes(minutes: output)
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
            cacheSuccess = self.minutesCache.setCachedMinutes(minutes: output)
        })
        .map{ minutes in
            CacheResponse(success: cacheSuccess)
        }
        .replaceError(with: CacheResponse(success: false))
        .eraseToAnyPublisher()
    }
}
