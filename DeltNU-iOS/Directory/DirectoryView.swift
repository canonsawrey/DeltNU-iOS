//
//  DirectoryView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct DirectoryView: View {
    var members: MemberDirectory
    
    var body: some View {
        List(members) { member in
            NavigationLink(destination: Text("Detail View")) {
                HStack {
                    Text("\(member.firstName) \(member.lastName)")
                }
            }
        }
    }
    
    init(members: MemberDirectory) {
        self.members = members
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static let members: MemberDirectory = Bundle.main.decode("users.json")
    
    static var previews: some View {
        DirectoryView(members: members)
    }
}
