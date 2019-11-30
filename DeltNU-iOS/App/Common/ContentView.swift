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
                        DashboardView().navTransition()
                    } else if self.navTab == NavTab.minutes {
                        MinutesView().navTransition()
                    } else if self.navTab == NavTab.vote {
                        PollsView().navTransition()
                    } else if self.navTab == NavTab.directory {
                        DirectoryView(viewModel: DirectoryViewModel(directoryFetcher: MockDirectoryFetcher())).navTransition()
                    } else {
                        PreferencesView().navTransition()
                    }
                }.blur(radius: self.isDrawerOpen ? 5.0 : 0.0)
                    .opacity(self.isDrawerOpen ? 0.3 : 1.0)
                    .animation(.default)
                    .navigationBarItems(
                        leading: Button(action: {
                            self.isDrawerOpen.toggle()
                        }) {
                            Image(systemName: "text.justify")
                                .padding()
                                .foregroundColor(Color("colorOnPrimary"))
                    })
            }
            
            /// Navigation Drawer part
            NavigationDrawer(isOpen: self.isDrawerOpen, selectedTab: self.navTab, selectedFunction: { navTab in
                self.navTab = navTab
                self.isDrawerOpen = false
            })
                .onTapGesture {
                    self.isDrawerOpen = false
            }
        }
    }
}

extension View {
    func navTransition() -> some View {
        return self.transition(
            .asymmetric(
                insertion: AnyTransition.opacity.combined(with: .move(edge: .trailing)).animation(.easeInOut(duration: 0.5)),
                removal: AnyTransition.opacity.combined(with: .move(edge: .leading)).animation(.easeInOut(duration: 0.5))
            )
        )
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
