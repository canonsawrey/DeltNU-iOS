//
//  DirectoryFetchable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

protocol DirectoryRemote: Cachable {
    func getRemoteDirectory() -> AnyPublisher<MemberDirectory, DeltNuError>
}
