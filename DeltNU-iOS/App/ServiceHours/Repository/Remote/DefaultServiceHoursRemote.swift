//
//  DefaultServiceHoursRemote.swift
//  DeltNU
//
//  Created by Canon Sawrey on 2/1/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultServiceHoursRemote: ServiceHoursRemote {
    private let session: URLSession
    private let url: URL = URL(string: EndpointApi.serviceHoursIndex)!
    private var cancellable: AnyCancellable? = nil
    private let serviceHoursCache = DefaultServiceHoursCache()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRemoteServiceHours() -> AnyPublisher<ServiceHours, DeltNuError> {
        let urlRequest = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .handleEvents(receiveOutput: { output in
            self.serviceHoursCache.setCachedServiceHours(serviceHours: output)
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
            cacheSuccess = self.serviceHoursCache.setCachedServiceHours(serviceHours: output)
        })
        .map{ minutes in
            CacheResponse(success: cacheSuccess)
        }
        .replaceError(with: CacheResponse(success: false))
        .eraseToAnyPublisher()
    }
}
