//
//  VoteRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/26/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol VoteRepository {
    func getPolls() -> AnyPublisher<Polls, DeltNuError>
}
