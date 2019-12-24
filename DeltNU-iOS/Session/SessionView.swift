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
        VStack {
            ZStack {
                if session.activeSession {
                    TabView(selection: $tabIndex) {
                        HomeView()
                            .tabItem {
                                Image(systemName: NavTab.dashboard.systemAsset())
                                Text("Home")
                            }
                            .tag(0)
                        MinutesView(viewModel: minutesViewModel)
                            .tabItem {
                                Image(systemName: NavTab.minutes.systemAsset())
                                Text("Minutes")
                            }
                            .tag(1)
                        VoteView(viewModel: voteViewModel)
                            .tabItem {
                                Image(systemName: NavTab.vote.systemAsset())
                                Text("Vote")
                            }
                            .tag(2)
                        DirectoryView(viewModel: directoryViewModel)
                            .tabItem {
                                Image(systemName: NavTab.directory.systemAsset())
                                Text("Directory")
                            }
                            .tag(3)
                        PreferencesView()
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
//            if !Reachability.isConnectedToNetwork() {
//                ZStack {
//                    Color("negative").edgesIgnoringSafeArea(.all)
//                    Text("Internet connection not detected")
//                        .foregroundColor(.white)
//                }
//            }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
