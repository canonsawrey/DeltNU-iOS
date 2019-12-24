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
    
    private let credentialRepository = DefaultCredentialCache()
    private let session = Session.shared
    
    var body: some View {
        NavigationView {
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
            }.frame(maxHeight: .infinity, alignment: .top)
            .alert(isPresented: $showingLogout) {
            Alert(
                title: Text("Logout?"),
                message: Text("Are you sure you want to logout of DeltNU?"),
                primaryButton: .destructive(Text("Logout")) {
                    withAnimation {
                        self.session.clearSession()
                    }
                    self.credentialRepository.clearCredentials()

                }, secondaryButton: .cancel())
            }.navigationBarTitle("Preferences")
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
