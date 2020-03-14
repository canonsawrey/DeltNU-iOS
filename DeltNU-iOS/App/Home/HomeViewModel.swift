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
    var lastMarkedPresent: Date? = nil
    private let userRepository = DefaultUserRepository()
    var user: Member? {
        userRepository.getUser()
    }
    
}
