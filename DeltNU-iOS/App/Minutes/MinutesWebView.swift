//
//  MinutesWebView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/8/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct MinutesWebView: View {
    var body: some View {
        VStack {
            Text(Date().formattedDate()).font(.largeTitle).padding()
            Text("Chapter notes").padding()
            Text("As it so contrasted oh estimating instrument. Size like body some one had. Are conduct viewing boy minutes warrant expense. Tolerably behaviour may admitting daughters offending her ask own. Praise effect wishes change way and any wanted. Lively use looked latter regard had. Do he it part more last in. Merits ye if mr narrow points. Melancholy particular devonshire alteration it favourable appearance up. ").padding()
        }.frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

struct MinutesWebView_Previews: PreviewProvider {
    static var previews: some View {
        MinutesWebView()
    }
}
