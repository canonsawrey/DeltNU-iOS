//
//  DefaultMinutesRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/16/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultMinutesRepository: MinutesRepository {
    
    private let minutesCache: MinutesCache = DefaultMinutesCache()
    private let minutesRemote: MinutesRemote = DefaultMinutesRemote()
    
    func getMinutes() -> AnyPublisher<Minutes, DeltNuError> {
        return Publishers.Merge(
            minutesCache.getCachedMinutes(),
            minutesRemote.getRemoteMinutes()
        ).eraseToAnyPublisher()
    }
}

