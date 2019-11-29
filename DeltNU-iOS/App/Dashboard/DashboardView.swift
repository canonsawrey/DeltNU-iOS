//
//  DashboardView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @State var showingProfile = false
    static let members: MemberDirectory = Bundle.main.decode("users.json")
    var user: Member = members.first { member -> Bool in
        member.firstName == "Canon"
    }!
    //TODO This needs to come from a new endpoint
    var serviceHours = 8
    var serviceHoursCompleted = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(user.firstName)")
                    .font(.largeTitle)
                    .frame(alignment: .top)
                    .padding()
                Text("Upcoming events")
                    .padding()
                Text("Placeholder for Google Calendar API events")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("secondary"))
                    .foregroundColor(Color("colorOnSecondary"))
                    .cornerRadius(50)
                    .padding(.bottom)
                    .padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Dashboard", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showingProfile = true
                }) {
                    Image(systemName: "person")
                        .padding()
                }
            )
            .sheet(isPresented: $showingProfile) {
                MemberView(member: self.user)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
