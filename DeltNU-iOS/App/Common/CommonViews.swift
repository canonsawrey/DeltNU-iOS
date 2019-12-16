//
//  ViewExtensions.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI

struct TileButton: View {
    let action: () -> ()
    let text: String
    let color: Color
    let textColor: Color
    
    
    var body: some View {
        Button(action: self.action) {
            VStack {
                Text(self.text)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(self.textColor)
                    .background(self.color)
                    .cornerRadius(appStyle.cornerRadius)
                
            }.padding()
        }
    }
    
    init(action: @escaping () -> (), text: String, color: Color, textColor: Color) {
        self.action = action
        self.text = text
        self.color = color
        self.textColor = textColor
    }
    
    init(text: String, color: Color, textColor: Color) {
        self.init(action: { }, text: text, color: color, textColor: textColor)
    }
}

struct Tile: View {
    let text: String
    let color: Color
    let textColor: Color
    var height: CGFloat = .infinity
    var width: CGFloat = .infinity
    
    var body: some View {
        Text(self.text)
            .frame(maxWidth: self.width, maxHeight: self.height)
            .foregroundColor(self.textColor)
            .background(self.color)
            .cornerRadius(appStyle.cornerRadius)
            .padding()
    }
    
    init(text: String, color: Color, textColor: Color) {
        self.text = text
        self.color = color
        self.textColor = textColor
    }
    
    init(text: String, color: Color, textColor: Color, width: CGFloat, height: CGFloat) {
        self.init(text: text, color: color, textColor: textColor)
        self.width = width
        self.height = height
    }
}

struct ClickableSpacer: View {
    
    var body: some View {
        //TODO_ANY This is a total hack bc 0 opacity unclickable
        Rectangle().opacity(0.00000000000001)
    }
}
