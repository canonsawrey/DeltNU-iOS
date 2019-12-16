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
    let poll: Poll
    @State private var votedState = false
    
    var body: some View {
        VStack {
            Text(poll.title)
                .padding()
            ForEach(poll.identifiableOptions) { option in
                TileButton(
                    action: {
                        self.votedState = true
                },
                    text: option.option,
                    color: Color("secondary"),
                    textColor: Color("colorOnSecondary")
                )
            }
        }
        .alert(isPresented: $votedState) {
            Alert(title: Text("Voted"), message: Text("Success! Your vote was cast."), dismissButton: .default(Text("Done"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    init(poll: Poll) {
        self.poll = poll
    }
}

struct SinglePoll_Previews: PreviewProvider {
    static let polls: PollArray = Bundle.main.decode("questions.json")
    
    static var previews: some View {
        SinglePollView(poll: polls[0])
    }
}
