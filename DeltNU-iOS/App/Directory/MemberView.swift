//
//  MemberView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct MemberView: View {
    let pictureSize = UIScreen.main.bounds.width / 2
    var member: Member
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(maxWidth: self.pictureSize, maxHeight: self.pictureSize)
                .padding(50)
            
            Text("\(member.firstName) \(member.lastName)")
                .font(.largeTitle)
                .padding()
                
            Text(member.pledgeClass.rawValue)
                .padding()
            
            Text(member.phoneNumber)
                .padding()
        
            Text(member.email)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
