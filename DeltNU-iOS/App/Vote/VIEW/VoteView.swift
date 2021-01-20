//
//  VoteView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct VoteView: View {
    @ObservedObject var viewModel: VoteViewModel
    @State var showingPoll = false
    private var activePolls: Polls { viewModel.polls.filter { poll in
        poll.isActive }
    }
    private var expiredPolls: Polls { viewModel.polls.filter { poll in
        !poll.isActive }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Active")) {
                        if (activePolls.count > 0) {
                            ForEach(activePolls) { poll in
                                Button(action: {
                                    self.viewModel.activatePoll(pollId: poll.id)
                                    self.showingPoll = true
                                }) {
                                    Text("\(poll.title)")
                                }
                            }
                        } else {
                            Text("-")
                        }
                    }
                    Section(header: Text("Expired")) {
                        if (expiredPolls.count > 0) {
                            ForEach(expiredPolls) { poll in
                                Button(action: {}) {
                                    Text("\(poll.title)")
                                }.disabled(true)
                            }
                        } else {
                            Text("-")
                        }
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $showingPoll) {
                if let vote = self.viewModel.activePoll {
                    SinglePollView(poll: vote)
                }
            }
            .navigationBarTitle("Vote")
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.getPolls()
                self.viewModel.refreshing = true
            }) {
                if !viewModel.refreshing {
                    HStack {
                        Text("Refresh")
                        Image(systemName: "arrow.clockwise")
                    }.foregroundColor(Color("CTA"))
                } else {
                    EmptyView()
                }
            })
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: viewModel.getPolls)
    }
    
    init(viewModel: VoteViewModel) {
        self.viewModel = viewModel
        viewModel.getPolls()
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView(viewModel: VoteViewModel(repository: DefaultVoteRepository()))
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
