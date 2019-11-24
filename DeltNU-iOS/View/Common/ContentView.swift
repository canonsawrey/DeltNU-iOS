//
//  ContentView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isDrawerOpen: Bool = false
    
    var body: some View {
        ZStack {
            if !self.isDrawerOpen {
                NavigationView {
                    DashboardView()
                        .navigationBarTitle(Text("DeltNU Dashboard"))
                        .navigationBarItems(leading: Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.isDrawerOpen.toggle()
                            }
                        }) {
                            Image(systemName: "sidebar.left")
                                .foregroundColor(appStyle.secondary)
                        })
                }
            }
            /// Navigation Drawer part
            NavigationDrawer(isOpen: self.isDrawerOpen)
         /// Other behaviors
        }
        .onTapGesture {
            if self.isDrawerOpen {
                self.isDrawerOpen.toggle()
            }
        }
//            TabView {
//                PollsView()
//                .tabItem {
//                    Image(systemName: "arkit")
//                    Text("Vote")
//                }
//                MinutesView()
//                .tabItem{
//                    Image(systemName: "arkit")
//                    Text("Minutes")
//                }
//                DirectoryView(members: members)
//                .tabItem{
//                    Image(systemName: "arkit")
//                    Text("Directory")
//                }
//            }.background(appStyle.secondary.edgesIgnoringSafeArea(.all))
//                .accentColor(appStyle.secondary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
