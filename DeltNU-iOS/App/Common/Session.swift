//
//  Session.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI

class Session: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var sessionCookie: String? = nil
    
    static let mockSessionCookie = "mockSessionCookie123456789"
}
