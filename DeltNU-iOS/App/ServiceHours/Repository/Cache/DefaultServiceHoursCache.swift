//
//  DefaultServiceHoursCache.swift
//  DeltNU
//
//  Created by Canon Sawrey on 2/1/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//
import Foundation
import Combine

class DefaultServiceHoursCache: ServiceHoursCache {
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    private let cacheKey = UserDefaultsKeyApi.serviceHours

    func getCachedServiceHours() -> AnyPublisher<ServiceHours, DeltNuError> {
        return Just(userDefaults.data(forKey: cacheKey))
            .map { wrappedData -> ServiceHours in
                if let data = wrappedData {
                    return try! coder.decoder.decode(ServiceHours.self, from: data)
                } else {
                    return ServiceHours()
                }
            }
            .mapError { error in
                .cache(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    func setCachedServiceHours(serviceHours: ServiceHours) -> Bool {
        do {
            try userDefaults.set(coder.encoder.encode(serviceHours), forKey: cacheKey)
            return true
        } catch {
            return false
        }
    }
}
