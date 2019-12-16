//
//  DefaultDirectoryFetcher.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/15/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultDirectoryFetcher: DirectoryFetchable {
    private let session: URLSession
    private let url: URL = URL(string: "https://www.deltnu.com/directory/app_index")!
    private var cancellable: AnyCancellable? = nil
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func memberDirectory() -> AnyPublisher<MemberDirectory, DeltNuError> {
        let urlRequest = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: urlRequest)
        .mapError { error in
            .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            
            decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
}
