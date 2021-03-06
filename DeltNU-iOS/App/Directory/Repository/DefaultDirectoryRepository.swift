//
//  DefaultDirectoryRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultDirectoryRepository: DirectoryRepository {
    
    
    private let directoryCache: DirectoryCache = DefaultDirectoryCache()
    private let directoryRemote: DirectoryRemote = DefaultDirectoryRemote()
    
    func getMembers() -> AnyPublisher<MemberDirectory, DeltNuError> {
        return Publishers.Merge(
            directoryCache.getCachedDirectory(),
            directoryRemote.getRemoteDirectory()
        ).eraseToAnyPublisher()
    }
    
    func getIdMap() -> AnyPublisher<IdMap, DeltNuError> {
        return getMembers().map { members in
            IdMap(members: members)
        }
        .eraseToAnyPublisher()
    }
}
