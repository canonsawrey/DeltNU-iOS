//
//  VoteView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct PollsView: View {

    var polls: PollArray = Bundle.main.decode("questions.json")
    @State var showingPoll = false
    @State var selectedPoll = 0
    
    var body: some View {
            VStack {
                List(polls) { poll in
                    Button(action: {
                        self.selectedPoll = poll.id
                        self.showingPoll = true
                    }) {
                        Text("\(poll.title)")
                    }.disabled(poll.isActive)
                }
        }
        .navigationBarTitle("Vote", displayMode: .inline)
        .sheet(isPresented: $showingPoll) {
            VoteView(poll: self.polls.first { poll in
                poll.id == self.selectedPoll
            }!)
        }
    }
}

struct PollsView_Previews: PreviewProvider {
    static var previews: some View {
        PollsView()
    }
}
