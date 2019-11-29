//
//  ContentView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

struct ContentView: View {
    @State var isDrawerOpen: Bool = false
    @State var navTab: NavTab = NavTab.dashboard
    var body: some View {
        
        ZStack {
            /// Navigation Bar Title part
            ZStack {
                if self.navTab == NavTab.dashboard {
                    DashboardView()
                } else {
                    MinutesView()
                }
            }.opacity(self.isDrawerOpen ? 0.3 : 1.0)
            /// Navigation Drawer part
            NavigationDrawer(isOpen: self.isDrawerOpen, selectedFunction: { navTab in
                self.navTab = navTab
                self.isDrawerOpen = false
                print(self.navTab.rawValue)
            })
            /// Other behaviors
        }
        .onTapGesture {
            if self.isDrawerOpen {
                self.isDrawerOpen.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
