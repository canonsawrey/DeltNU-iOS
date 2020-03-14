//
//  IdMap.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/10/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation

struct IdMap {
    var map: Dictionary<Int, Member>
    
    init(members: MemberDirectory) {
        map = Dictionary()
        for member in members {
            map[member.id] = member
        }
    }
}
