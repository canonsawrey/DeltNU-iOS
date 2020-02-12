//
//  ServiceHoursRemote.swift
//  DeltNU
//
//  Created by Canon Sawrey on 2/1/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol ServiceHoursRemote: Cachable {
    func getRemoteServiceHours() -> AnyPublisher<ServiceHours, DeltNuError>
}
