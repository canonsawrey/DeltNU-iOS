//
//  DefaultDirectoryFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/15/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultDirectoryRemote: DirectoryRemote {
    private let session: URLSession
    private let url: URL = URL(string: EndpointApi.directoryIndex)!
    private var cancellable: AnyCancellable? = nil
    private let directoryCache = DefaultDirectoryCache()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRemoteDirectory() -> AnyPublisher<MemberDirectory, DeltNuError> {
        let urlRequest = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }.handleEvents(receiveOutput: { output in
            self.directoryCache.setCachedDirectory(directory: output)
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
            cacheSuccess = self.directoryCache.setCachedDirectory(directory: output)
        })
        .map{ polls in
            CacheResponse(success: cacheSuccess)
        }
        .replaceError(with: CacheResponse(success: false))
        .eraseToAnyPublisher()
    }
}
