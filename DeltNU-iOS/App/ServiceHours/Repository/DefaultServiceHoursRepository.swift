//
//  DefaultServiceHoursRepository.swift
//  DeltNU
//
//  Created by Canon Sawrey on 2/1/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultCommunityServiceRepository: CommunityServiceRepository {
    
    private let serviceHoursCache: CommunityServiceCache = DefaultCommunityServiceCache()
    private let serviceHoursRemote: CommunityServiceRemote = DefaultCommunityServiceRemote()
    private let cacheKey = UserDefaultsKeyApi.serviceHours
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    
    func getServiceHours() -> AnyPublisher<ServiceHours, DeltNuError> {
        return Publishers.Merge(
            serviceHoursCache.getCachedServiceHours(),
            serviceHoursRemote.getRemoteServiceHours()
        ).eraseToAnyPublisher()
    }
}
