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
                ScrollView {
                    ForEach(minutes) { min in
                        VStack {
                            Text(min.createdAt.formattedDate())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            HStack {
                                NavigationLink(destination: Text("Minutes unavailable"), label: {
                                    Tile(
                                        text: "Minutes",
                                        color: Color(UIColor(named: "secondary")!),
                                        textColor: Color(UIColor(named: "colorOnSecondary")!),
                                        height: .infinity,
                                        width: .infinity
                                    )
                                }
                                ).padding()
                                NavigationLink(destination: MasterformWebView(minutes: min), label: {
                                    Tile(
                                        text: "Masterform",
                                        color: Color(UIColor(named: "secondary")!),
                                        textColor: Color(UIColor(named: "colorOnSecondary")!),
                                        height: .infinity,
                                        width: .infinity
                                )
                                }).padding()
                            }.frame(minHeight: 150)
                        }
                    }
                }
            }
            .navigationBarTitle("Minutes", displayMode: .inline)
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView()
    }
}
