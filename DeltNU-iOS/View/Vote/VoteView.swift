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
                .padding()
            ForEach(poll.identifiableOptions) { option in
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    VStack {
                        Text(option.option)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(appStyle.colorOnSecondary)
                            .background(appStyle.secondary)
                            .cornerRadius(10)
                    }.padding()
                }
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
