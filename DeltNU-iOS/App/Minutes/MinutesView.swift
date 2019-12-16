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
        NavigationView {
            ZStack(alignment: .bottom) {
                List(viewModel.minutes) { min in
                    Button(action: {
                        guard let url = URL(string: "https://www.deltnu.com/minutes/\(min.id)") else { return }
                        UIApplication.shared.open(url)
                    }) {
                        HStack {
                            Text(min.createdAt.formattedDate())
                            Spacer()
                            Text(min.createdAt.getElapsedInterval())
                        }
                    }
                }
            }
        .navigationBarTitle("Minutes")
        .navigationBarItems(
            trailing: Button(action: {
                guard let url = URL(string: self.viewModel.minutes[0].masterform) else { return }
                UIApplication.shared.open(url)
            }) {
            Text("Masterform")
        })
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel(fetchable: DefaultMinutesFetcher()))
    }
}
