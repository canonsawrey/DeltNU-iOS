//
//  ServiceView.swift
//  DeltNU
//
//  Created by Canon Sawrey on 1/6/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import SwiftUI



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

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceHoursBarView(hoursCompleted: 3, hoursNeeded: 10)
    }
}
