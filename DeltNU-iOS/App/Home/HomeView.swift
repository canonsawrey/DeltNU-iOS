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
    @State var showingUser = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
            }
            .navigationBarTitle("Home")
            .navigationBarItems(trailing:
                ZStack {
                    if (user == nil) {
                        Text("Welcome")
                    } else {
                        Button(action: {
                            self.showingUser = true
                        }) {
                            HStack {
                                Text("Welcome, \(user!.firstName)")
                            }.foregroundColor(Color("colorOnPrimaryAccent"))
                        }
                    }
                }
            )
            .sheet(isPresented: $showingUser) {
                MemberView(member: self.user!, addVisible: false)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
