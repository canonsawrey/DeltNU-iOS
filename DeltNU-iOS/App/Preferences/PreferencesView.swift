//
//  Preferences.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    
    @State var showingLogout = false
    
    var body: some View {
            VStack {
                List {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.0.0")
                    }
                    Button(action: {
                        self.showingLogout = true
                    }) {
                        Text("Logout")
                    }
                }
                .padding()
                
            }.frame(maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showingLogout) {
                LogoutSheet()
            }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
