//
//  DashboardView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    //TODO_ANY This needs to come from an endpoint
    var serviceHours = 8
    var serviceHoursCompleted = false
    
    var body: some View {
        NavigationView {
            VStack {
                Tile(
                    text: "Welcome, Canon",
                    color: Color("primary"),
                    textColor: Color("colorOnPrimary"),
                    width: .infinity,
                    height: .infinity)
                Tile(
                    text: "Welcome, Canon",
                    color: Color("secondary"),
                    textColor: Color("colorOnSecondary"),
                    width: .infinity,
                    height: .infinity)
                Tile(
                    text: "Welcome, Canon",
                    color: Color("secondary"),
                    textColor: Color("colorOnSecondary"),
                    width: .infinity,
                    height: .infinity)
                Tile(
                    text: "Welcome, Canon",
                    color: Color("secondary"),
                    textColor: Color("colorOnSecondary"),
                    width: .infinity,
                    height: .infinity)
            }
            .navigationBarTitle("Home")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
