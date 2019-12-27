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
    //true for profile, false for settings
    @State var showProfile = true
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
            }
            .navigationBarTitle("Home")
            .navigationBarItems(
                leading: Button(action: {
                    self.showingSheet = true
                    self.showProfile = true
                }) {
                    Image(systemName: Navigation.profile.systemAsset()).foregroundColor(Color("colorCTA"))
                        .opacity(self.user == nil ? 0.0 : 1.0)
                },
                trailing: Button(action: {
                    self.showingSheet = true
                    self.showProfile = false
                }) {
                    Image(systemName: Navigation.preferences.systemAsset()).foregroundColor(Color("colorCTA"))
                }
            )
                .sheet(isPresented: $showingSheet) {
                    ZStack {
                        EmptyView()
                        if (self.showProfile) {
                            MemberView(member: self.user!, addVisible: false)
                        } else {
                            PreferencesView()
                        }
                    }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
