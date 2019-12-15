//
//  DashboardView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var showingProfile = false
    
    //MOCK DATA
    static let members: MemberDirectory = Bundle.main.decode("users.json")
    var user: Member = members.first { member -> Bool in
        member.firstName == "Canon"
    }!
    
    //TODO_ANY This needs to come from an endpoint
    var serviceHours = 8
    var serviceHoursCompleted = false
    
    var body: some View {
            VStack {
                HStack {
                    Text("Upcoming events")
                        .padding(.horizontal)
                }
                ScrollView {
                    MockHistoryItem(index: 1)
                    MockHistoryItem(index: 2)
                    MockHistoryItem(index: 3)
                    MockHistoryItem(index: 4)
                    MockHistoryItem(index: 5)
                    MockHistoryItem(index: 6)
                    MockHistoryItem(index: 7)
                    MockHistoryItem(index: 8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
