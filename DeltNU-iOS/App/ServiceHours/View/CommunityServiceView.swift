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

struct CommunityServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceHoursBarView(hoursCompleted: 3, hoursNeeded: 10)
    }
}
