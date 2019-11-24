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
            TabView {
                PollsView()
                .tabItem {
                    Image(systemName: "arkit")
                    Text("Vote")
                }
                MinutesView()
                .tabItem{
                    Image(systemName: "arkit")
                    Text("Minutes")
                }
                DirectoryView(members: members)
                .tabItem{
                    Image(systemName: "arkit")
                    Text("Directory")
                }
            }.background(appStyle.secondary.edgesIgnoringSafeArea(.all))
                .accentColor(appStyle.secondary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
