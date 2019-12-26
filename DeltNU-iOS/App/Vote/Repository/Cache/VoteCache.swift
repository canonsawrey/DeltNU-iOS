//
//  VoteCache.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/26/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol VoteCache {
    func getCachedPolls() -> AnyPublisher<Polls, DeltNuError>
    
    func setCachedPolls(polls: Polls) -> Bool
}
