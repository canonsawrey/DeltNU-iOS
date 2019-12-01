//
//  MinutesView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct MinutesView: View {
    
    //View model
    @ObservedObject var viewModel: MinutesViewModel
    @State private var minutesShowing: Bool = true
    private var masterformShowing: Bool {
        !minutesShowing
    }
    
    var body: some View {
            VStack {
                    List(viewModel.minutes) { min in
                            Button(action: { }) {
                                HStack {
                                    Text(min.createdAt.formattedDate())
                                    Spacer()
                                    Text(min.createdAt.getElapsedInterval())
                                }
                            }
                        }.padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.minutesShowing = true
                    }) {
                        Text("Minutes").padding()
                            .foregroundColor(Color("colorOnPrimary"))
                                .overlay(self.minutesShowing ? RoundedRectangle(cornerRadius: appStyle.cornerRadius)
                                    .stroke(Color("secondary"), lineWidth: 1) : RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color("primary"), lineWidth: 10))
                            .animation(.default)
                    }
                    Spacer()
                    Button(action: {
                        self.minutesShowing = false
                    }) {
                        Text("Masterform").padding()
                        .foregroundColor(Color("colorOnPrimary"))
                            .overlay(!self.minutesShowing ? RoundedRectangle(cornerRadius: appStyle.cornerRadius)
                                .stroke(Color("secondary"), lineWidth: 1) : RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color("primary"), lineWidth: 10))
                                    .animation(.default)
                    }
                    Spacer()
                }
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel())
    }
}
