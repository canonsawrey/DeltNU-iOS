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
    //Searchbar stuff
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(appStyle.secondary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(appStyle.secondary)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                    .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                
                List {
                    ForEach(self.members.filter{$0.firstName.hasPrefix(searchText) || searchText == ""}) { member in
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
                .resignKeyboardOnDragGesture()
            }
            .navigationBarTitle("Member Directory", displayMode: .inline)
            .sheet(isPresented: $showingMember) {
                MemberView(member: self.members.first { member in
                    member.id == self.selectedMember
                    }!)
            }
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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
