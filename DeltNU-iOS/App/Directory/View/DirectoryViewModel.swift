//
//  DirectoryViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/29/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class DirectoryViewModel: ViewModel, ObservableObject, Identifiable {
    //Published to the subscribing View
    @Published var members: MemberDirectory = []
    @Published var searchText = ""
    @Published var showCancelButton: Bool = false
    
    //Repositories
    private let directoryRepository: DirectoryRepository
    
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(repository: DirectoryRepository) {
        self.directoryRepository = repository
    }
    
    func getMembers() {
        directoryRepository.getMembers()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    print("\n||||||COMPLETION|||||\n")
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] receivedMembers in
                    guard let self = self else { return }
                    self.members = receivedMembers
            })
            .store(in: &disposables)
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
