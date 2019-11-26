//
//  NavigationDrawer.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct NavigationDrawer: View {
    private let width = UIScreen.main.bounds.width - 100
    let isOpen: Bool
    
    var body: some View {
        HStack {
            DrawerContent()
                .frame(width: self.width)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.default)
            Spacer()
        }
    }
}

struct DrawerContent: View {
    var body: some View {
        ZStack {
            appStyle.secondary.edgesIgnoringSafeArea(.all)
            VStack {
                NavigationLink(destination: MinutesView()) {
                    Text("Minutes")
                        .padding()
                        .foregroundColor(appStyle.colorOnSecondary)
                }
                NavigationLink(destination: PollsView()) {
                    Text("Vote")
                        .padding()
                        .foregroundColor(appStyle.colorOnSecondary)
                }
                NavigationLink(destination: DirectoryView()) {
                    Text("Directory")
                        .padding()
                        .foregroundColor(appStyle.colorOnSecondary)
                }
                Spacer()
            }
        }
    }
}
