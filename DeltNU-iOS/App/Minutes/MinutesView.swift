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
    @State private var showingMasterform = false
    @State private var masterform = true
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List(viewModel.minutes) { min in
                    Button(action: {
                        self.masterform = false
                        self.showingMasterform = true
                    }) {
                        HStack {
                            Text(min.createdAt.formattedDate())
                            Spacer()
                            Text(min.createdAt.getElapsedInterval())
                        }
                    }
                }
                
                Button(action: {
                    self.masterform = true
                    self.showingMasterform = true
                }) {
                    HStack {
                        Spacer()
                        Text("Latest masterform: \(viewModel.minutes[0].createdAt.getElapsedInterval())").padding()
                            .foregroundColor(Color("colorOnSecondary"))
                        Spacer()
                    }.background(Color("secondary")).cornerRadius(appStyle.cornerRadius).padding(.horizontal)
                }
            }
            .sheet(isPresented: $showingMasterform) {
                Group {
                    if self.masterform {
                        MasterformWebView(minutes: self.viewModel.minutes[1])
                    } else {
                        MinutesWebView()
                    }
                }
            }
        .navigationBarTitle("Minutes")
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel())
    }
}
