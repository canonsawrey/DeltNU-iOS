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
    
    private let minutesFetcher: MinutesFetchable
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(fetchable: MinutesFetchable) {
        minutesFetcher = fetchable
        super.init()
        getMinutes()
    }
    
    func getMinutes() {
        minutesFetcher.getMinutes()
            .receive(on: DispatchQueue.main)
            .breakpointOnError()
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        print("fail")
                    case .finished:
                        print("end")
                    }
                },
                receiveValue: { [weak self] receivedMinutes in
                    guard let self = self else { return }
                    print("Received \(receivedMinutes.count) minutes")
                    // 7
                    self.minutes = receivedMinutes
            })
            .store(in: &disposables)
    }
}
