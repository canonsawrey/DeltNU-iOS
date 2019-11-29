//
//  Preferences.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("App Version:")
                        Spacer()
                        Text("1.0.0.0")
                    }
                }
                .padding()
                
            }.frame(maxHeight: .infinity, alignment: .top)
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
