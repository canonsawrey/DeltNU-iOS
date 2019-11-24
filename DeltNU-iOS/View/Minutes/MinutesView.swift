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
        ZStack {
            Background(color: appStyle.secondary)
            VStack {
                HeaderView(text: "Minutes")
                List(minutes) { min in
                    Button(action: {
                        //Launch into URL VC
                    }) {
                        HStack {
                            Text("Minutes for:")
                                .padding()
                            min.createdAtDate.map({ Text($0.description) })
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView()
    }
}
