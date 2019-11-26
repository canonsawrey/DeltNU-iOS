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
        //        ZStack {
        //            if !self.isDrawerOpen {
        //                NavigationView {
        //                    DashboardView()
        //                        .navigationBarTitle(Text("DeltNU Dashboard"))
        //                        .navigationBarItems(leading: Button(action: {
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        //                                self.isDrawerOpen.toggle()
        //                            }
        //                        }) {
        //                            Image(systemName: "sidebar.left")
        //                                .foregroundColor(appStyle.secondary)
        //                        })
        //                }
        //            }
        //            /// Navigation Drawer part
        //            NavigationDrawer(isOpen: self.isDrawerOpen)
        //         /// Other behaviors
        //        }
        //        .onTapGesture {
        //            if self.isDrawerOpen {
        //                self.isDrawerOpen.toggle()
        //            }
        //        }
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
            }
            MinutesView()
                .tabItem{
                    Image(systemName: "text.justify")
                    Text("Minutes")
            }
            PollsView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Vote")
            }
            DirectoryView()
                .tabItem{
                    Image(systemName: "person.3")
                    Text("Directory")
            }
        }
        .accentColor(Color(UIColor(named: "colorOnSecondary")!))
        .edgesIgnoringSafeArea(.top)
    }
    
    //TODO: This needs to be done in a different way once SwiftUI API is expanded
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "secondary")
        UITabBar.appearance().barTintColor = UIColor(named: "secondary")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "secondary")
        UINavigationBar.appearance().barTintColor = UIColor(named: "secondary")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "colorOnSecondary")!]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
