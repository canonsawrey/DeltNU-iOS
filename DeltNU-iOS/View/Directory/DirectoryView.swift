//
//  DirectoryView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct DirectoryView: View {
    var members: MemberDirectory = Bundle.main.decode("users.json")
    @State var selectedMember: Int = 0
    @State var showingMember = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(text: "Member Directory")
                List(members) { member in
                    Button(action: {
                        self.selectedMember = member.id
                        self.showingMember = true
                    }) {
                        HStack {
                            Text("\(member.firstName) \(member.lastName)")
                            Spacer()
                            Text(member.pledgeClass.rawValue.toGreekCharacter())
                        }
                    }
                }
            }
            .sheet(isPresented: $showingMember) {
                MemberView(member: self.members.first { member in
                    member.id == self.selectedMember
                }!)
            }
            .navigationBarTitle("Minutes")
        }
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static let members: MemberDirectory = Bundle.main.decode("users.json")
    
    static var previews: some View {
        DirectoryView(members: members)
    }
}

extension String {
    func toGreekCharacter() -> String {
        switch self {
        case "Alpha":
            return "Α"
        case "Beta":
            return "B"
        case "Gamma":
            return "Γ"
        case "Delta":
            return "Δ"
        case "Epsilon":
            return "E"
        case "Zeta":
            return "Z"
        case "Eta":
            return "H"
        case "Theta":
            return "Θ"
        case "Iota":
            return "I"
        case "Kappa":
            return "K"
        case "Lambda":
            return "Λ"
        case "Mu":
            return "M"
        case "Nu":
            return "N"
        default:
            return "-"
        }
    }
}
