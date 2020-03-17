//
//  DefaultAttendanceRepository.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/14/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation

class DefaultAttendanceRepository : AttendanceRepository {
    
    private let userDefaults = UserDefaults.standard
    private let key = UserDefaultsKeyApi.attendanceLastMarked
    
    func markedPresent(date: Date) {
        userDefaults.set(date, forKey: key)
    }
    
    func lastMarkedPresent() -> Date? {
        let obj = userDefaults.object(forKey: key)
        guard let date = obj as? Date else {
            return nil
        }
        return date
    }
}
