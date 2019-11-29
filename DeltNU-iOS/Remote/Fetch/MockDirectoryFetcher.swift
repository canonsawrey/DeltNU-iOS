//
//  MockDirectoryFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class MockDirectoryFetcher: DirectoryFetchable {
    
    func memberDirectory() -> AnyPublisher<MemberDirectory, DirectoryError> {
        var data = Data()
        let path = Bundle.main.path(forResource: "users", ofType: "json")!
        let fileUrl = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
        } catch {
            
        }
        
        return decode(data)
    }
}
