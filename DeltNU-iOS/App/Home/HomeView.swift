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
    @State var showingSheet = false
    
    //Mock stuff
    let hoursComplete = 8
    let hoursNeeded = 10
    let events = 3
    let eventsAttended = 2
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height * 3 / 5)
                        .padding(50)
                    ServiceHoursView(hoursCompleted: self.hoursComplete, hoursNeeded: self.hoursNeeded)
                        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height / 5)
                        .padding(.top)
                        .padding(.horizontal)
                    AttendanceView()//eventsAttended: self.eventsAttended, events: self.events)
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

struct ServiceHoursView: View {
    let hoursCompleted: Int
    let hoursNeeded: Int
    
    var hoursBarMultiplier: Double {
        if (hoursCompleted < hoursNeeded) {
            return Double(hoursCompleted) / Double(hoursNeeded)
        } else {
            return 1.0
        }
    }
    
    var body: some View {
        VStack {
            Text("Service hours")
            HStack {
                GeometryReader { geo in
                    ZStack {
                        RoundedRectangle(cornerRadius: appStyle.cornerRadius)
                            .stroke(Color("colorOnPrimary"), lineWidth: 3)
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            .foregroundColor(Color("primary"))
                            .cornerRadius(appStyle.cornerRadius)
                        HStack {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color("tertiary"))
                                    .cornerRadius(appStyle.cornerRadius)
                                    .padding(1.5)
                                Text(String(self.hoursCompleted)).foregroundColor(Color("colorOnTertiary"))
                            }.frame(width: CGFloat(Double(geo.size.width) * self.hoursBarMultiplier), height: geo.size.height, alignment: .center)
                            Spacer()
                        }
                    }
                }
                Text(String(self.hoursNeeded))
            }
        }
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
