//
//  VoteViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/16/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class VoteViewModel: ViewModel, ObservableObject, Identifiable {
    
    @Published var polls: Polls = []
    
    private let voteFetcher: VoteRemote
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(fetchable: VoteRemote) {
        voteFetcher = fetchable
        super.init()
        getPolls()
    }
    
    func getPolls() {
        voteFetcher.getPolls()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        //print("poll fail")
                        break
                    case .finished:
                        //print("poll end")
                        break
                    }
                },
                receiveValue: { [weak self] receivedPolls in
                    guard let self = self else { return }
                    //print("Received \(receivedPolls.count) polls")
                    // 7
                    self.polls = receivedPolls
            })
            .store(in: &disposables)
    }
}
