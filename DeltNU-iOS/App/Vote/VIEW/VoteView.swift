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
    @State var selectedPoll = 0
    private var activePolls: Polls { viewModel.polls.filter { poll in
        poll.isActive
        }
    }
    private var expiredPolls: Polls { viewModel.polls.filter { poll in
        !poll.isActive
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Active")) {
                        if (activePolls.count > 0) {
                            ForEach(activePolls) { poll in
                                Button(action: {
                                    self.selectedPoll = poll.id
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
                                Button(action: {
                                    self.selectedPoll = poll.id
                                    self.showingPoll = true
                                }) {
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
                SinglePollView(poll: self.viewModel.polls.first { poll in
                    poll.id == self.selectedPoll
                    }!)
            }
            .navigationBarTitle("Vote")
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.getPolls()
                self.viewModel.refreshing = true
            }) {
                if !viewModel.refreshing {
                    Image(systemName: "goforward").foregroundColor(Color("colorOnPrimaryAccent"))
                } else {
                    EmptyView()
                }
            })
        }.onAppear(perform: viewModel.getPolls)
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
