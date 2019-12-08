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
    
    var body: some View {
            ZStack(alignment: .bottom) {
                List(viewModel.minutes) { min in
                            Button(action: {
                            }) {
                                HStack {
                                    Text(min.createdAt.formattedDate())
                                    Spacer()
                                    Text(min.createdAt.getElapsedInterval())
                                }
                            }
                        }
                
                Button(action: {
                    //TODO_ANY Masterform modal
                }) {
                    HStack {
                    Spacer()
                    Text("Latest masterform: \(viewModel.minutes[0].createdAt.getElapsedInterval())").padding()
                        .foregroundColor(Color("colorOnSecondary"))
                    Spacer()
                        }.background(Color("secondary")).cornerRadius(appStyle.cornerRadius).padding(.horizontal)
                }
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel())
    }
}
