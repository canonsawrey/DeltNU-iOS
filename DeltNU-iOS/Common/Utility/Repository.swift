//
//  Repository.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/16/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol Repository<T> {
    func get() -> AnyPublisher<T, DeltNuError>
}
