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
    @Published var refreshing = false
    
    private let voteRepository: VoteRepository
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(repository: VoteRepository) {
        voteRepository = repository
    }
    
    func getPolls() {
        voteRepository.getPolls()
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
                    self.polls = receivedPolls
                    self.refreshing = false
            })
            .store(in: &disposables)
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
