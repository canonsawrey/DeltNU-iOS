//
//  DashboardView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var showingSheet = false
    @State var isPreferences = true
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    UserView(member: self.viewModel.user, size: geo.size.height * 3 / 5).padding(50)
                    Spacer()
                    Button(action: {
                        self.isPreferences = false
                        self.showingSheet = true
                    }) {
                        HStack {
                            Image(systemName: self.viewModel.lastMarkedPresent != nil ? "checkmark" : "camera")
                            Text(self.viewModel.lastMarkedPresent != nil ? "Marked present \(self.viewModel.lastMarkedPresent!.getElapsedInterval())" : "Attendance")
                        }.padding()
                    }.foregroundColor(self.viewModel.lastMarkedPresent != nil ? Color("positive") : Color("CTA"))
                }
            }
            .navigationBarTitle(self.viewModel.user != nil ? "Welcome, \(self.viewModel.user!.firstName)" : "Home")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showingSheet = true
                    self.isPreferences = true
                }) {
                    Image(systemName: Navigation.preferences.systemAsset()).font(.system(size: appStyle.cornerIconSize)).foregroundColor(Color("CTA"))
                }
            )
            .sheet(isPresented: $showingSheet) {
                ZStack {
                EmptyView()
                    if (self.isPreferences) {
                        PreferencesView()
                    } else {
                        ScannerView(self.handleScan)
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle()).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.showingSheet = false
        self.viewModel.logPresent(date: Date.init())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
