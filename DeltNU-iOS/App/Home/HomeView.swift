//
//  DashboardView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    private let userRepository = DefaultUserRepository()
    private var user: Member? {
        userRepository.getUser()
    }
    private let serviceHoursRepository: ServiceHoursRepository = DefaultServiceHoursRepository()
    private var hoursCompleted: Double? {
        serviceHoursRepository.getIndividualServiceHoursCompleted(user: user)
    }
    let hoursNeeded = 10
    @State var showingSheet = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height * 3 / 5)
                        .padding(50)
                    ServiceHoursBarView(hoursCompleted: self.hoursCompleted, hoursNeeded: self.hoursNeeded)
                        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height / 5)
                        .padding()
                }
            }
            .navigationBarTitle(self.user != nil ? "Welcome, \(self.user!.firstName)" : "Home")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showingSheet = true
                }) {
                    Image(systemName: Navigation.preferences.systemAsset()).foregroundColor(Color("colorCTA"))
                }
            )
            .sheet(isPresented: $showingSheet) {
                PreferencesView()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct AttendanceView: View {
    let events = 3
    let eventsAttended = 2
    
    var body: some View {
        VStack {
            Text("Weekly attendance")
            GeometryReader { geo in
                HStack {
                    ForEach(1...self.events, id: \.self) { count in
                        ZStack {
                            RoundedRectangle(cornerRadius: appStyle.cornerRadius)
                                .stroke(Color("colorOnPrimary"), lineWidth: 3)
                                .frame(width: geo.size.width / CGFloat(self.events), height: geo.size.height)
                            RoundedRectangle(cornerRadius: appStyle.cornerRadius)
                                .foregroundColor(count <= self.eventsAttended ? Color("tertiary") : Color("primary"))
                                .frame(width: geo.size.width / CGFloat(self.events), height: geo.size.height)
                        }
                    }
                }
            }.padding(.horizontal)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
