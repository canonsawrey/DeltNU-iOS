//
//  ViewExtensions.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(appStyle.colorOnSecondary)
    }
    
    init(text: String) {
        self.text = text
    }
}

struct Background: View {
    let color: Color
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(color.edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
    }
    
    init(color: Color) {
        self.color = color
    }
}
