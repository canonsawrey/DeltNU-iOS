//
//  EventView.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/10/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI

struct EventView: View {
    let event: ServiceEvent
    
    var body: some View {
        List {
            HStack {
                Text("Brother")
                Spacer()
                Text(event.firstName)
                Text(event.lastName)
            }
            HStack {
                Text("Hours")
                Spacer()
                Text(event.hours)
            }
            HStack {
                Text("Organization")
                Spacer()
                Text(event.organization)
            }
            HStack {
                Text(event.description)
            }
            Spacer()
        }
    }
}
