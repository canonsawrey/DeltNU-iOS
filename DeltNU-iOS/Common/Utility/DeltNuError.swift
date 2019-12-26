//
//  DirectoryError.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

enum DeltNuError: Error {
    case parsing(description: String)
    case network(description: String)
    case cache(description: String)
    case invalidSignIn
    case unknown(description: String)
}
