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
    var availableMasterform: Bool {
        return self.viewModel.minutes.count > 0 && self.viewModel.minutes[0].masterform != ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if (viewModel.minutes.count > 0) {
                    List(viewModel.minutes) { min in
                        NavigationLink(destination:
                            UrlWebView(url: "\(EndpointApi.minutesDetail)\(min.id)"),
                                       label: {
                            HStack {
                                Text(min.createdAt.formattedDate())
                                Spacer()
                                Text(min.createdAt.getElapsedInterval())
                            }
                        })
                    }
                } else {
                    Text("No minutes to display").frame(maxHeight: .infinity)
                }
            }
            .navigationBarTitle("Minutes")
            .navigationBarItems(
                trailing: Button(action: {
                    if self.viewModel.minutes.count > 0 {
                        guard let url = URL(string: self.viewModel.minutes[0].masterform) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }
                    
                }) {
                    HStack {
                        if availableMasterform {
                            Text("\(self.viewModel.minutes[0].createdAt.monthAndDay()) Master Form")
                        }
                        Image(systemName: "arrow.up.right")
                    }
                    .opacity(availableMasterform ? 1.0 : 0.0)
                    .foregroundColor(Color("CTA"))
            })
            }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: viewModel.getMinutes)
    }
    
    init(viewModel: MinutesViewModel) {
        self.viewModel = viewModel
        viewModel.getMinutes()
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel(repository: DefaultMinutesRepository()))
    }
}
