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
            VStack {
                ScrollView {
                    ForEach(viewModel.minutes) { min in
                        VStack {
                            Text(min.createdAt.formattedDate())
                                .padding()
                            HStack {
                                NavigationLink(destination: Text("Minutes unavailable"), label: {
                                    Text("Minutes").foregroundColor(Color("secondary")).padding()
                                })
                                NavigationLink(destination: MasterformWebView(minutes: min), label: {
                                    Text("Masterform").foregroundColor(Color("secondary")).padding()
                                })
                            }
                        }.padding()
                    }.animation(nil)
                }
            }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel())
    }
}
