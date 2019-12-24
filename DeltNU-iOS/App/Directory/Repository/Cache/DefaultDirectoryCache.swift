//
//  DefaultDirectoryCache.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultDirectoryCache: DirectoryCache {
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    private let cacheKey = UserDefaultsKeyApi.directory
    
    func getCachedDirectory() -> AnyPublisher<MemberDirectory, DeltNuError> {
        return Just(userDefaults.data(forKey: cacheKey))
            .map { wrappedData -> MemberDirectory in
                if let data = wrappedData {
                    return try! coder.decoder.decode(MemberDirectory.self, from: data)
                } else {
                    return []
                }
            }
            .mapError { error in
                .cache(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    
    func setCachedDirectory(directory: MemberDirectory) -> Bool {
        do {
            try userDefaults.set(coder.encoder.encode(directory), forKey: cacheKey)
            return true
        } catch {
            return false
        }
    }
}
