//
//  DefaultCastVoteRemote.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DefaultCastVoteRemote: CastVoteRemote {
    private let session: URLSession
    private let url: URL = URL(string: EndpointApi.votePost)!
    private var cancellable: AnyCancellable? = nil
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func castVote(optionId: String) -> AnyPublisher<Int, DeltNuError> {
        let request = buildRequest(optionId: optionId)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw DeltNuError.network(description: "Failed cast to HTTPURLResponse")
                }
                return httpResponse.statusCode
        }
        .mapError { error in
            guard error is DeltNuError else {
                return DeltNuError.unknown(description: error.localizedDescription)
            }
            return error as! DeltNuError
        }
        .eraseToAnyPublisher()
        
    }
    
    private func buildRequest(optionId: String) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        let bodyData = "option_id=\(optionId)"
        urlRequest.httpBody = bodyData.data(using: String.Encoding.utf8)
        urlRequest.httpMethod = "POST"
        
        return urlRequest
    }
    
}
