//
//  Mock.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/8/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI

class Mock {
//    static func mockHistoryItems() -> Content {
//
//    }
}
//
struct MockHistoryItem: View {
    
    var index: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(randomTitle()).padding().frame(alignment: Alignment.leading)
                Spacer()
                Text(getDate(index: self.index).formattedDate()).padding()
            }
            HStack {
                Text(randomSubTitle()).padding().frame(alignment: Alignment.leading)
                Spacer()
            }
            
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color("colorOnSecondary"))
            .background(Color("secondary"))
            .cornerRadius(appStyle.cornerRadius)
            .padding()
    }
    
    private func randomTitle() -> String {
        let titles: [String] = [
            "Chapter",
            "E-Board Transitions",
            "Composites",
            "A-Board",
            "Study Hours",
            "New member retreat",
            "Honor Board hearings",
            "Elections"
        ]
        return titles.shuffled()[0]
    }
    
    private func randomSubTitle() -> String {
        let titles: [String] = [
            "Weekly meeting",
            "Get annual photos taken",
            "Weekly study block",
            "Vote for new positions",
            "VP and A-Board meet",
            "Bonding trip to western Mass."
        ]
        return titles.shuffled()[0]
    }
    
    private func getDate(index: Int) -> Date {
        return Date(timeIntervalSinceNow: -100000.0 * Double(index))
    }
}
