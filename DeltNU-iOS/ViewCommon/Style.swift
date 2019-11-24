//
//  Style.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

let appStyle = Style()

class Style {
    var theme: Theme = .light
    
    var primary: Color {
        switch self.theme {
        case .light:
            return Color.white
        case .dark:
            return Color.black
        }
    }
    
    var secondary: Color {
        switch self.theme {
        case .light:
            return Color(red: 75 / 255.0, green: 0 / 255.0, blue: 130 / 255.0)
        case .dark:
            return Color.black
        }
    }
    
    var colorOnPrimary: Color {
        switch self.theme {
        case .light:
            return Color.black
        case .dark:
            return Color.black
        }
    }
    
    var colorOnSecondary: Color {
        switch self.theme {
        case .light:
            return Color.white
        case .dark:
            return Color.black
        }
    }
}

enum Theme {
    case light
    case dark
}


