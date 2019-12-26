//
//  DirectoryCache.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol DirectoryCache {
    func getCachedDirectory() -> AnyPublisher<MemberDirectory, DeltNuError>
    
    func setCachedDirectory(directory: MemberDirectory) -> Bool
    
    func getUser(email: String) -> Member?
}
