//
//  VoteView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct VoteView: View {
    @Environment(\.presentationMode) var presentationMode
    let poll: Poll
    
    var body: some View {
        VStack {
            Text(poll.title)
                .font(.headline)
                .padding()
            ForEach(poll.identifiableOptions) { option in
                TileButton(
                    action: { self.presentationMode.wrappedValue.dismiss() },
                    text: option.option,
                    color: appStyle.secondary,
                    textColor: appStyle.colorOnSecondary
                )
            }
        }
    }
    
    init(poll: Poll) {
        self.poll = poll
    }
}

struct VoteView_Previews: PreviewProvider {
    static let polls: PollArray = Bundle.main.decode("questions.json")
    
    static var previews: some View {
        VoteView(poll: polls[0])
    }
}
