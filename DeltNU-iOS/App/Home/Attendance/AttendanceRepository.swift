//
//  AttendanceRepository.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/14/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation

protocol AttendanceRepository {
    func markedPresent(date: Date)
    
    func lastMarkedPresent() -> Date?
}
