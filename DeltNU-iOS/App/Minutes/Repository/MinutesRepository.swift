//
//  MinutesRepository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/16/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol MinutesRepository {
    func getMinutes() -> AnyPublisher<Minutes, DeltNuError>
}
