//
//  ServiceHoursRepository.swift
//  DeltNU
//
//  Created by Canon Sawrey on 2/1/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol ServiceHoursRepository {
    func getServiceHours() -> AnyPublisher<ServiceHours, DeltNuError>
    func getIndividualServiceHoursCompleted(user: Member?) -> Double?
}
