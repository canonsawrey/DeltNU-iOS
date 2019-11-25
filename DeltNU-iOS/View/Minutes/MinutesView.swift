//
//  MinutesView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct MinutesView: View {
    var minutes: Minutes = Bundle.main.decode("minutes.json")
    @State var showingMinutes = false
    @State var selectedMinutes = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List(minutes) { min in
                    Button(action: {
                        self.selectedMinutes = min.id
                        self.showingMinutes = true
                    }) {
                        Text(min.formattedCreatedAtDate).padding()
                    }
                }
            }
            .navigationBarTitle("Minutes")
            .sheet(isPresented: $showingMinutes) {
                MinutesModal(minutes: self.minutes.first { minute in
                    minute.id == self.selectedMinutes
                }!)
            }
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView()
    }
}
