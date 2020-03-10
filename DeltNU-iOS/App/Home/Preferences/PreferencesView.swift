//
//  Preferences.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingLogout = false
    
    private let credentialRepository = DefaultCredentialCache()
    private let session = Session.shared
    private let version: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(version == nil ? "1.0" : version!)
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
                    self.presentationMode.wrappedValue.dismiss()
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
