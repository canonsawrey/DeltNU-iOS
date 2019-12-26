//
//  MinutesViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/30/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import Combine

class MinutesViewModel: ViewModel, ObservableObject, Identifiable {
    //Published to the subscribing View
    @Published var minutes: Minutes = []
    
    //Repositories
    private let minutesRepository: MinutesRepository
    
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(repository: MinutesRepository) {
        minutesRepository = repository
    }
    
    func getMinutes() {
        minutesRepository.getMinutes()
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
                receiveValue: { [weak self] receivedMinutes in
                    guard let self = self else { return }
                    self.minutes = receivedMinutes
            })
            .store(in: &disposables)
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
