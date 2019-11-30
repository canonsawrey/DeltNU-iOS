//
//  NavigationDrawer.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct NavigationDrawer: View {
    private let width = UIScreen.main.bounds.width - 100
    let isOpen: Bool
    let selectedFunction: (NavTab) -> ()
    
    var body: some View {
        HStack {
            DrawerContent(selectedFunction: self.selectedFunction)
                .frame(width: self.width)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.easeOut(duration: 0.20))
            Spacer()
        }
    }
}

struct DrawerContent: View {
    var selectedFunction: (NavTab) -> ()
    
    var body: some View {
        ZStack {
            Color("secondary").edgesIgnoringSafeArea(.all)
            VStack {
                DrawerItem(navTab: NavTab.dashboard, selectedFunction: self.selectedFunction)
                DrawerItem(navTab: NavTab.minutes, selectedFunction: self.selectedFunction)
                DrawerItem(navTab: NavTab.vote, selectedFunction: self.selectedFunction)
                DrawerItem(navTab: NavTab.directory, selectedFunction: self.selectedFunction)
                DrawerItem(navTab: NavTab.preferences, selectedFunction: self.selectedFunction)
                Spacer()
            }.padding()
        }
    }
}

struct DrawerItem: View {
    let navTab: NavTab
    let selectedFunction: (NavTab) -> ()
    
    var body: some View {
        Button(action: {
            self.selectedFunction(self.navTab)
        }) {
        HStack {
            Image(systemName: navTab.systemAsset())
                    .foregroundColor(Color("colorOnSecondary"))
                Spacer()
            Text(navTab.rawValue)
                    .foregroundColor(Color("colorOnSecondary"))
            }.padding()
                .padding(.horizontal)
        }
    }
}



struct NavigationDrawer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDrawer(isOpen: true, selectedFunction: { navTab in })
    }
}

enum NavTab: String {
    
    case dashboard = "Dashboard"
    case minutes = "Minutes"
    case vote = "Vote"
    case directory = "Directory"
    case preferences = "Preferences"
    
    func systemAsset() -> String {
        switch self {
        case .dashboard:
            return "house"
        case .minutes:
            return "text.justify"
        case .vote:
            return "pencil"
        case .directory:
            return "person.3"
        case .preferences:
            return "gear"
        }
    }
}
