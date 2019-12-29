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
    @State var navTab: Navigation = Navigation.home
    @State var tabIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                if !session.globalError {
                    if session.activeSession {
                        TabView(selection: $tabIndex) {
                            HomeView()
                                .tabItem {
                                    Image(systemName: Navigation.home.systemAsset())
                                    Text("Home")
                                }
                                .tag(0)
                            
                            MinutesView(viewModel: MinutesViewModel(repository: DefaultMinutesRepository()))
                                .tabItem {
                                    Image(systemName: Navigation.minutes.systemAsset())
                                    Text("Minutes")
                                }
                                .tag(1)
                            
                            VoteView(viewModel: VoteViewModel(repository: DefaultVoteRepository()))
                                .tabItem {
                                    Image(systemName: Navigation.vote.systemAsset())
                                    Text("Vote")
                                }
                                .tag(2)
                            
                            DirectoryView(viewModel: DirectoryViewModel(repository: DefaultDirectoryRepository()))
                                .tabItem {
                                    Image(systemName: Navigation.directory.systemAsset())
                                    Text("Directory")
                                }
                                .tag(3)
                        }.onAppear(perform: {self.tabIndex = 0})
                        .edgesIgnoringSafeArea(.top)
                        .accentColor(Color("secondary"))
                    } else {
                        LoginView(viewModel: LoginViewModel())
                            .transition(AnyTransition.move(edge: .top))
                    }
                } else {
                    Text("ERROR\n\(session.globalErrorMessage)")
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
