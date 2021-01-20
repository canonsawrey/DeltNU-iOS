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
    @Published var selectedMember: Member?
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
                    if (self.members.count != receivedMembers.count) {
                        self.members = receivedMembers
                    }
            })
            .store(in: &disposables)
    }
    
    func selectMember(memberId: Int) {
        self.selectedMember = members.first { member in
            member.id == memberId
        }
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
