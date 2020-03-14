//
//  ServiceEvent.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/10/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation

struct ServiceEvent: Identifiable {
    let id: Int
    let userid: Int
    let firstName: String
    let lastName: String
    var name: String {
        "\(firstName) \(lastName)"
    }
    let hours: String
    let organization: String
    let description: String
}
