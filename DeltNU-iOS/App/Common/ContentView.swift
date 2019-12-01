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
    
    var directoryViewModel = DirectoryViewModel(directoryFetcher: MockDirectoryFetcher())
    var minutesViewModel = MinutesViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                        self.isDrawerOpen.toggle()
                    }) {
                        Image(systemName: "triangle")
                            .padding()
                            .foregroundColor(Color("colorOnPrimaryAccent"))
                            .rotationEffect(self.isDrawerOpen ? .degrees(270) : .degrees(0))
                            .animation(.default)
                            .cornerRadius(appStyle.cornerRadius)
                }
                Spacer()
            }
            ZStack {
                ZStack {
                    if self.navTab == NavTab.dashboard {
                        DashboardView().navTransition()
                    } else if self.navTab == NavTab.minutes {
                        MinutesView(viewModel: self.minutesViewModel).navTransition()
                    } else if self.navTab == NavTab.vote {
                        PollsView().navTransition()
                    } else if self.navTab == NavTab.directory {
                        DirectoryView(viewModel: self.directoryViewModel).navTransition()
                    } else {
                        PreferencesView().navTransition()
                    }
                }.blur(radius: self.isDrawerOpen ? 5.0 : 0.0)
                    .opacity(self.isDrawerOpen ? 0.3 : 1.0)
                    .animation(.default)
            
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
