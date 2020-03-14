//
//  CommunityServiceViewModel.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/10/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation


import Foundation
import Combine


class CommunityServiceViewModel: ViewModel, ObservableObject, Identifiable {
    //Published to the subscribing View
    @Published var hoursStruct: ServiceHours = ServiceHours()
    @Published var memberMap: IdMap = IdMap(members: [])
    //View related logic
    @Published var userHoursOnly = 0 //0 = true
    private var user: Member? {
        DefaultUserRepository().getUser()
    }
    var serviceEvents: [ServiceEvent] {
        hoursStruct.hours
            .filter { event in
                memberMap.map[event.userid] != nil
            }
            .filter { event in
                self.userHoursOnly == 1 || (user == nil ? true : user!.id == event.userid)
            }
            .map { hour in
                ServiceEvent(
                    id: hour.id,
                    userid: hour.userid,
                    firstName: memberMap.map[hour.userid]!.firstName,
                    lastName: memberMap.map[hour.userid]!.lastName,
                    hours: hour.hours,
                    organization: hour.organization,
                    description: hour.hourDescription
                )
        }
    }
    var totalHours: String {
        var total: Double = 0
        for event in self.serviceEvents {
            guard let dblHours = Double(event.hours) else { continue }
            total += dblHours
        }
        return String(total)
    }
    
    //Repositories
    private let communityServiceRepository: CommunityServiceRepository
    private let directoryRepository: DirectoryRepository
    
    //Other
    private var disposables = Set<AnyCancellable>()
    
    init(repository: CommunityServiceRepository, directoryRepo: DirectoryRepository) {
        self.communityServiceRepository = repository
        self.directoryRepository = directoryRepo
    }
    
    func getHours() {
        //Launch directory request
        directoryRepository.getIdMap()
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
                receiveValue: { [weak self] receivedIdMap in
                    guard let self = self else { return }
                    self.memberMap = receivedIdMap
            })
            .store(in: &disposables)
        
        //Launch hours request
        communityServiceRepository.getServiceHours()
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
                receiveValue: { [weak self] receivedHours in
                    guard let self = self else { return }
                    self.hoursStruct = receivedHours
            })
            .store(in: &disposables)
        
        
    }
    
    deinit {
        for disposable in disposables {
            disposable.cancel()
        }
    }
}
