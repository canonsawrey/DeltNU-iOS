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

struct SessionView: View {
    @ObservedObject var session = Session.shared
//    @State var isDrawerOpen = false
    @State var navTab: NavTab = NavTab.dashboard
    @State var tabIndex = 0
    
    var directoryViewModel = DirectoryViewModel(directoryFetcher: DefaultDirectoryFetcher())
    var minutesViewModel = MinutesViewModel(repository: DefaultMinutesRepository())
    var voteViewModel = VoteViewModel(fetchable: DefaultVoteRemote())
    
    var body: some View {
        ZStack {
            if session.activeSession {
                //Old side nav
//                VStack {
//                    ZStack {
//                        Button(action: {
//                            self.isDrawerOpen.toggle()
//                        }) {
//                            Image(systemName: "triangle")
//                                .padding()
//                                .foregroundColor(Color("colorOnPrimaryAccent"))
//                                .rotationEffect(self.isDrawerOpen ? .degrees(270) : .degrees(0))
//                                .animation(.default)
//                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                        Text(navTab.rawValue)
//                            .font(.title)
//                            .opacity(self.isDrawerOpen ? 0.3 : 1.0)
//                            .blur(radius: self.isDrawerOpen ? 5.0 : 0.0)
//                            .padding(.horizontal)
//                            .foregroundColor(Color("colorOnPrimary"))
//                            .animation(.default)
//                    }
//                    ZStack {
//                        ZStack {
//                            if self.navTab == NavTab.dashboard {
//                                HomeView().navTransition()
//                            } else if self.navTab == NavTab.minutes {
//                                MinutesView(viewModel: self.minutesViewModel).navTransition()
//                            } else if self.navTab == NavTab.vote {
//                                PollsView().navTransition()
//                            } else if self.navTab == NavTab.directory {
//                                DirectoryView(viewModel: self.directoryViewModel).navTransition()
//                            } else {
//                                PreferencesView().navTransition()
//                            }
//                        }.blur(radius: self.isDrawerOpen ? 5.0 : 0.0)
//                            .opacity(self.isDrawerOpen ? 0.3 : 1.0)
//                            .animation(.default)
//
//                        /// Navigation Drawer part
//                        NavigationDrawer(isOpen: self.isDrawerOpen, selectedTab: self.navTab, selectedFunction: { navTab in
//                            self.navTab = navTab
//                            self.isDrawerOpen = false
//                        })
//                            .onTapGesture {
//                                self.isDrawerOpen = false
//                        }
//                    }
//                }
                TabView(selection: $tabIndex) {
                    HomeView()
                    .transition(.slide)
                        .tabItem {
                            Image(systemName: NavTab.dashboard.systemAsset())
                            Text("Home")
                        }
                        .tag(0)
                    MinutesView(viewModel: minutesViewModel)
                    .transition(.slide)
                        .tabItem {
                            Image(systemName: NavTab.minutes.systemAsset())
                            Text("Minutes")
                        }
                        .tag(1)
                    VoteView(viewModel: voteViewModel)
                    .transition(.slide)
                        .tabItem {
                            Image(systemName: NavTab.vote.systemAsset())
                            Text("Vote")
                        }
                        .tag(2)
                    DirectoryView(viewModel: directoryViewModel)
                        .transition(.slide)
                        .tabItem {
                            Image(systemName: NavTab.directory.systemAsset())
                            Text("Directory")
                        }
                        .tag(3)
                    PreferencesView()
                        .transition(.slide)
                        .tabItem {
                            Image(systemName: NavTab.preferences.systemAsset())
                            Text("Preferences")
                        }
                        .tag(4)
                }.edgesIgnoringSafeArea(.top)
                .accentColor(Color("colorOnPrimaryAccent"))
            } else {
                LoginView(viewModel: LoginViewModel())
                    .transition(AnyTransition.move(edge: .top))
            }
        }
    }
}

extension View {
    func navTransition() -> some View {
        return self.transition(
            .asymmetric(
                insertion: AnyTransition.opacity.combined(with: .move(edge: .trailing)).animation(.easeInOut(duration: 0.25)),
                removal: AnyTransition.opacity.combined(with: .move(edge: .leading)).animation(.easeInOut(duration: 0.25))
            )
        )
    }
}
//
//class DrawerState: ObservableObject {
//    @Published var isDrawerOpen = false
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
