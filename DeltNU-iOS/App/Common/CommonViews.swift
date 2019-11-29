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
                    .cornerRadius(10)
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
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        Text(self.text)
            .frame(maxWidth: self.width, maxHeight: self.height)
            .foregroundColor(self.textColor)
            .background(self.color)
            .cornerRadius(10)
            .padding()
    }
    
    init(text: String, color: Color, textColor: Color, height: CGFloat, width: CGFloat) {
        self.text = text
        self.color = color
        self.textColor = textColor
        self.width = width
        self.height = height
    }
}

