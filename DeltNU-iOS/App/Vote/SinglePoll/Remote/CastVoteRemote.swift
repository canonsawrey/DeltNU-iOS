//
//  CastVoteRemote.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol CastVoteRemote {
    func castVote(optionId: String) -> AnyPublisher<Int, DeltNuError>
}
