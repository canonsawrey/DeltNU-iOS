//
//  ServiceView.swift
//  DeltNU
//
//  Created by Canon Sawrey on 1/6/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import SwiftUI


struct CommunityServiceView: View {
    //View model
    @ObservedObject var viewModel: CommunityServiceViewModel
    let filterOptions = ["My hours", "All brothers"]
    @State var selectedEvent: Int = 0
    @State var showingEvent = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Total hours")) {
                        HStack {
                            Spacer()
                            Text(viewModel.totalHours)
                        }
                    }
                    Section(header: Text("Logged events")) {
                        ForEach(viewModel.serviceEvents) { serviceEvent in
                            Button(action: {
                                self.selectedEvent = serviceEvent.id
                                self.showingEvent = true
                            }) {
                                GeometryReader { geo in
                                    HStack {
                                        Text(serviceEvent.firstName).frame(maxWidth: geo.size.width / 4, alignment: .leading)
                                        Text(serviceEvent.organization).lineLimit(1).frame(maxWidth: geo.size.width * 7 / 12, alignment: .trailing)
                                        Text(serviceEvent.hours).frame(maxWidth: geo.size.width / 6, alignment: .trailing)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Picker(selection: $viewModel.userHoursOnly, label: Text("Filter")) {
                    ForEach(0 ..< self.filterOptions.count) {
                        Text(self.filterOptions[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .sheet(isPresented: $showingEvent) {
                EventView(event: self.viewModel.serviceEvents.first { event in
                    event.id == self.selectedEvent
                }!)
            }
            .navigationBarTitle("Community Service")
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: viewModel.getHours)
    }
}


struct ServiceHoursBarView: View {
    let hoursCompleted: Double?
    let hoursNeeded: Int
    
    var hoursBarMultiplier: Double {
        if (hoursCompleted == nil) {
            return 0.0
        }
        if (hoursCompleted! < Double(hoursNeeded)) {
            return hoursCompleted! / Double(hoursNeeded)
        } else {
            return 1.0
        }
    }
    
    var body: some View {
        VStack {
            Text("Service hours")
            HStack {
                GeometryReader { geo in
                    ZStack {
                        RoundedRectangle(cornerRadius: appStyle.cornerRadius)
                            .stroke(Color("colorOnPrimary"), lineWidth: 3)
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            .foregroundColor(Color("primary"))
                            .cornerRadius(appStyle.cornerRadius)
                        HStack {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color("tertiary"))
                                    .cornerRadius(appStyle.cornerRadius)
                                    .padding(1.5)
                                Text(self.hoursCompleted != nil ? String(self.hoursCompleted!) : "Loading...").foregroundColor(Color("colorOnTertiary"))
                            }.frame(width: CGFloat(Double(geo.size.width) * self.hoursBarMultiplier), height: geo.size.height, alignment: .center)
                            Spacer()
                        }
                    }
                }
                Text(String(self.hoursNeeded))
            }
        }
    }
}

struct CommunityServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceHoursBarView(hoursCompleted: 3, hoursNeeded: 10)
    }
}
