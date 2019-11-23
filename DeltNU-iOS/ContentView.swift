//
//  ContentView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var members: MemberDirectory = Bundle.main.decode("users.json")
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Minutes")) {
                    Text("Minutes")
                }
                NavigationLink(destination: Text("Vote")) {
                    Text("Vote")
                }
                NavigationLink(destination: DirectoryView(members: members)) {
                    Text("Member Directory")
                }
            }
            .navigationBarTitle("Welcome, \(members[0].firstName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
