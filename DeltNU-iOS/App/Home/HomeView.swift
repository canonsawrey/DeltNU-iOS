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
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    UserView(member: self.user, size: geo.size.height * 3 / 5).padding(50)
                    Spacer()
                }
            }
            .navigationBarTitle(self.user != nil ? "Welcome, \(self.user!.firstName)" : "Home")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showingSheet = true
                }) {
                    HStack {
                        Text("Settings")
                        Image(systemName: Navigation.preferences.systemAsset())
                    }.foregroundColor(Color("CTA"))
                    
                }
            )
            .sheet(isPresented: $showingSheet) {
                PreferencesView()
            }
        }.navigationViewStyle(StackNavigationViewStyle()).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
