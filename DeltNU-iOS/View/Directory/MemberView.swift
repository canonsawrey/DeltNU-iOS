//
//  MemberView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct MemberView: View {
    var member: Member
    
    var body: some View {
        VStack {
            HStack {
                Text("\(member.firstName) \(member.lastName)")
                    .padding()
                Spacer()
                Text(member.pledgeClass.rawValue)
                .padding()
            }
            Text(member.email)
            Text(member.phoneNumber)
        }
    }
    
    init(member: Member) {
        self.member = member
    }
}

struct MemberView_Previews: PreviewProvider {
    static let members: MemberDirectory = Bundle.main.decode("users.json")

    static var previews: some View {
        MemberView(member: members[0])
    }
}
