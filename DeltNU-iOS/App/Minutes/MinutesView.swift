//
//  MinutesView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct MinutesView: View {
    //View model
    @ObservedObject var viewModel: MinutesViewModel
    @State var selectedYear: Int = 0
    let years = [2020, 2019, 2018]
    @State var selectedSemester: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List(filterredMinutes) { min in
                    Button(action: {
                        guard let url = URL(string: "https://www.deltnu.com/minutes/\(min.id)") else { return }
                        UIApplication.shared.open(url)
                    }) {
                        HStack {
                            Text(min.createdAt.formattedDate())
                            Spacer()
                            Text(min.createdAt.getElapsedInterval())
                        }
                    }
                }
                Picker(selection: $selectedSemester, label: Text("Semester")) {
                    Text("Fall").tag(0)
                    Text("Spring").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                    .accentColor(.black)
                    .padding(.horizontal)
                Picker(selection: $selectedYear, label: Text("Year")) {
                    ForEach(0 ..< years.count) {
                        Text(String(self.years[$0])).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
            }
        .navigationBarTitle("Minutes")
        .navigationBarItems(
            trailing: Button(action: {
                guard let url = URL(string: self.viewModel.minutes[0].masterform) else { return }
                UIApplication.shared.open(url)
            }) {
            Text("Masterform")
        })
        }
    }
    
    var filterredMinutes: Minutes {
        viewModel.minutes.filter { min in
            let calendar = Calendar.current
            let year = calendar.component(.year, from: min.createdAt)
            let month = calendar.component(.month, from: min.createdAt)
            let rightSemester = selectedSemester == 0 ? month >= 6 : month <= 6
            return year == years[selectedYear] && rightSemester
        }
    }
}

struct MinutesView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesView(viewModel: MinutesViewModel(fetchable: DefaultMinutesFetcher()))
    }
}
