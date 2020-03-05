//
//  VoteView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI


struct SinglePollView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SinglePollViewModel(repository: DefaultCastVoteRemote())
    
    let poll: Poll
    
    var body: some View {
        VStack {
            Text(poll.title)
                .padding()
            ForEach(poll.options, id: \.self.id) { option in
                TileButton(
                    action: {
                        self.viewModel.voteStatus = nil
                        self.viewModel.showAlert = true
                        self.viewModel.castVote(optionId: String(option.id))
                },
                    text: option.name,
                    color: String(option.id) == self.viewModel.castIndex ? Color("tertiary") : Color("CTA"),
                    textColor: Color("colorOnCTA"),
                    selected: String(option.id) == self.viewModel.castIndex
                )
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            if (viewModel.voteStatus == nil) {
                return Alert(
                    title: Text("Voting..."),
                    message: Text("Casting your vote"),
                    dismissButton: nil)
            } else {
                return Alert(
                    title: Text(viewModel.voteStatus! ? "Vote cast" : "Vote failed"),
                    message: Text(viewModel.voteStatus! ? "Your vote was cast successfully" : "Sorry, we could not cast your vote"),
                    dismissButton: .default(Text("Done"), action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }))
            }
        }
    }
    
    init(poll: Poll) {
        self.poll = poll
    }
}

struct SinglePoll_Previews: PreviewProvider {
    static let polls: Polls = Bundle.main.decode("questions.json")
    
    static var previews: some View {
        SinglePollView(poll: polls[0])
    }
}
