//
//  MinutesViewModel.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/30/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

class MinutesViewModel: ViewModel, ObservableObject, Identifiable {
    @Published var minutes: Minutes = Bundle.main.decode("minutes.json")
}
