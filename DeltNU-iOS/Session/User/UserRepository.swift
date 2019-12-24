//
//  UserRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

protocol UserRepository {
    func getUser() -> Member?
    func setUser(user: Member) -> Bool
}
