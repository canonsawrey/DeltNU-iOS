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
    @State var isDrawerOpen = false
    @State var navTab: NavTab = NavTab.dashboard
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if self.navTab == NavTab.dashboard {
                        DashboardView()
                    } else if self.navTab == NavTab.minutes {
                        MinutesView()
                    } else if self.navTab == NavTab.vote {
                        PollsView()
                    } else if self.navTab == NavTab.directory {
                        DirectoryView(viewModel: DirectoryViewModel(directoryFetcher: MockDirectoryFetcher()))
                    } else {
                        PreferencesView()
                    }
                }.opacity(self.isDrawerOpen ? 0.3 : 1.0)
                    /// Other behaviors
                .navigationBarItems(
                    leading: Button(action: {
                        print("toggled")
                        self.isDrawerOpen.toggle()
                    }) {
                        Image(systemName: "text.justify")
                            .padding()
                            .foregroundColor(Color("colorOnPrimary"))
                })
            }
            
            /// Navigation Drawer part
            NavigationDrawer(isOpen: self.isDrawerOpen, selectedFunction: { navTab in
                self.navTab = navTab
                self.isDrawerOpen = false
            })
                .onTapGesture {
                    self.isDrawerOpen = false
            }
        }
    }
}

class DrawerState: ObservableObject {
    @Published var isDrawerOpen = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
