//
//  UserRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultUserRepository: UserRepository {
    
    private let directoryRepository = DefaultDirectoryRepository()
    private let userDefaults = UserDefaults.standard
    private let coder = Coder()
    private let cacheKey = UserDefaultsKeyApi.user
    
    func getUser() -> Member? {
        guard let data = userDefaults.data(forKey: cacheKey) else {
            return nil
        }
        do {
            return try coder.decoder.decode(Member.self, from: data)
        } catch {
            return nil
        }
    }
    
    func setUser(user: Member) -> Bool {
        do {
            try userDefaults.set(coder.encoder.encode(user), forKey: cacheKey)
            return true
        } catch {
            return false
        }
    }
}
