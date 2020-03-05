//
//  SinglePollViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//
import Foundation
import Combine

class SinglePollViewModel: ViewModel, ObservableObject, Identifiable {
    @Published var voteStatus: Bool? = nil
    @Published var showAlert: Bool = false
    @Published var castIndex: String? = nil
    
    private let castVoteRepository: CastVoteRemote
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(repository: CastVoteRemote) {
        castVoteRepository = repository
    }
    
    func castVote(optionId: String) {
        castIndex = optionId
        castVoteRepository.castVote(optionId: optionId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        print("poll fail")
                        break
                    case .finished:
                        print("poll end")
                        break
                    }
                },
                receiveValue: { [weak self] statusCode in
                    guard let self = self else { return }
                    if statusCode == 200 {
                        self.voteStatus = true
                    } else {
                        self.voteStatus = false
                        self.castIndex = nil
                    }
            })
            .store(in: &disposables)
    }
}

enum VoteStatus {
    case voting
    case votedSuccess
    case votedFailure
    case notVoting
}
