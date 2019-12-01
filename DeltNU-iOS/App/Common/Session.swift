//
//  Session.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation


class Session: Identifiable, ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var authToken: String? = nil
    @Published var mockedLogin: Bool = true
}
