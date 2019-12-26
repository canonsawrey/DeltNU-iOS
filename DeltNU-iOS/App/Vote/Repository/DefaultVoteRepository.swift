//
//  DefaultVoteRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/26/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultVoteRepository: VoteRepository {
    
    private let voteCache: VoteCache = DefaultVoteCache()
    private let voteRemote: VoteRemote = DefaultVoteRemote()
    
    
    func getPolls() -> AnyPublisher<Polls, DeltNuError> {
        return Publishers.Merge(
            voteCache.getCachedPolls(),
            voteRemote.getRemotePolls()
        ).eraseToAnyPublisher()
    }
}
