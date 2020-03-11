//
//  DirectoryRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol DirectoryRepository {
    func getMembers() -> AnyPublisher<MemberDirectory, DeltNuError>
    
    func getIdMap() -> AnyPublisher<IdMap, DeltNuError>
}
