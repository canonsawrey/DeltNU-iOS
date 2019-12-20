//
//  MinutesFetchable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/15/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol MinutesRemote {
    func getRemoteMinutes() -> AnyPublisher<Minutes, DeltNuError>
}
