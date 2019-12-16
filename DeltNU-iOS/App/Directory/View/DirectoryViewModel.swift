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
    @Published var dataState: DataState = .loading
    @Published var searchText = ""
    @Published var showCancelButton: Bool = false
    
    //Repositories
    private let directoryFetcher: DirectoryFetchable
    
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(directoryFetcher: DirectoryFetchable) {
        self.directoryFetcher = directoryFetcher
        super.init()
        getMembers()
    }
    
    func getMembers() {
        directoryFetcher.memberDirectory()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataState = .error
                    case .finished:
                        self.dataState = .loaded
                    }
                },
                receiveValue: { [weak self] receivedMembers in
                    guard let self = self else { return }
                    print("Received \(receivedMembers.count) members")
                    // 7
                    self.members = receivedMembers
            })
            .store(in: &disposables)
    }
}

enum DataState {
    case loading
    case loaded
    case error
}
