//
//  DefaultServiceHoursRepository.swift
//  DeltNU
//
//  Created by Canon Sawrey on 2/1/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultServiceHoursRepository: ServiceHoursRepository {
    
    private let serviceHoursCache: ServiceHoursCache = DefaultServiceHoursCache()
    private let serviceHoursRemote: ServiceHoursRemote = DefaultServiceHoursRemote()
    private let cacheKey = UserDefaultsKeyApi.serviceHours
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    
    func getServiceHours() -> AnyPublisher<ServiceHours, DeltNuError> {
        return Publishers.Merge(
            serviceHoursCache.getCachedServiceHours(),
            serviceHoursRemote.getRemoteServiceHours()
        ).eraseToAnyPublisher()
    }
    
    func getIndividualServiceHoursCompleted(user: Member?) -> Double? {
        guard let uUser = user else {
            return nil
        }
        guard let data = userDefaults.data(forKey: cacheKey) else {
            return nil
        }
        do {
            let hours = try coder.decoder.decode(ServiceHours.self, from: data)
            guard let match = hours.hoursPerUser.first(where: { usr in
                guard let unwrapped = usr.id else {
                    return false
                }
                return Int(unwrapped) == uUser.id
            }) else {
                return nil
            }
            return match.sumhours
        } catch {
            return nil
        }
    }
}
