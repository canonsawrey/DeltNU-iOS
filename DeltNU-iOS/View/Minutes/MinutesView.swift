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
    
    var body: some View {
        NavigationView {
            VStack {
                List(minutes) { min in
                    VStack {
                        Text(min.formattedCreatedAtDate)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        NavigationLink(destination: Text("Minutes for \(min.formattedCreatedAtDate) unavailable"), label: { Text("Minutes") })
                            .padding()
                        NavigationLink(destination: MasterformWebView(minutes: min), label: { Text("Masterform") })
                        .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarTitle("Minutes")
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView()
    }
}
