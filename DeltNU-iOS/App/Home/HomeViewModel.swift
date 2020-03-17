//
//  HomeViewModel.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/14/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation

class HomeViewModel: ViewModel, ObservableObject, Identifiable {
    private let attendanceRepository = DefaultAttendanceRepository()
    var lastMarkedPresent: Date? {
        guard let date = attendanceRepository.lastMarkedPresent() else { return nil }
        let interval = Calendar.current.dateComponents([.hour], from: date, to: Date())
        if (interval.hour != nil) { return nil }
        return date
    }
    private let userRepository = DefaultUserRepository()
    var user: Member? {
        userRepository.getUser()
    }
    
    func logPresent(date: Date) {
        attendanceRepository.markedPresent(date: date)
    }
}
