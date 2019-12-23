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
    
    @Published var minutes: Minutes = []
    
    private let minutesRepository: MinutesRepository
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(repository: MinutesRepository) {
        minutesRepository = repository
        super.init()
    }
    
    func getMinutes() {
        print("VM getMinutes()")
        minutesRepository.getMinutes()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        //print("Minutes fail")
                        break
                    case .finished:
                        //print("Minutes end")
                        break
                    }
                },
                receiveValue: { [weak self] receivedMinutes in
                    guard let self = self else { return }
                    //print("Received \(receivedMinutes.count) minutes")
                    // 7
                    self.minutes = receivedMinutes
            })
            .store(in: &disposables)
    }
}
