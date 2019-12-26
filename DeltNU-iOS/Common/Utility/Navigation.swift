//
//  Navigation.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

enum NavTab: String {
    
    case home = "Home"
    case minutes = "Minutes"
    case vote = "Vote"
    case directory = "Directory"
    case preferences = "Preferences"
    
    func systemAsset() -> String {
        switch self {
        case .home:
            return "house"
        case .minutes:
            return "text.justify"
        case .vote:
            return "pencil"
        case .directory:
            return "person.3"
        case .preferences:
            return "gear"
        }
    }
}
