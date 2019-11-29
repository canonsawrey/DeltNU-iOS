//
//  DirectoryView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct DirectoryView: View {
    //Mocked data
    var members: MemberDirectory = Bundle.main.decode("users.json")
    
    //View model
    @ObservedObject var viewModel: DirectoryViewModel
    //Member detail bottom sheet state
    @State var selectedMember: Int = 0
    @State var showingMember = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $viewModel.searchText, onEditingChanged: { isEditing in
                            self.viewModel.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(Color("secondary"))
                        
                        Button(action: {
                            self.viewModel.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(self.viewModel.searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(Color("secondary"))
                    .background(Color("colorOnSecondary"))
                    .cornerRadius(10.0)
                    
                    if viewModel.showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.viewModel.searchText = ""
                            self.viewModel.showCancelButton = false
                        }
                        .foregroundColor(Color("secondary"))
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                    .navigationBarHidden(viewModel.showCancelButton) // .animation(.default) // animation does not work properly
                
                //Member list - hide if not loaded
                List {
                    ForEach(viewModel.members.filter{$0.firstName.hasPrefix(viewModel.searchText) || viewModel.searchText == ""}) { member in
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

//struct DirectoryView_Previews: PreviewProvider {
//    static let members: MemberDirectory = Bundle.main.decode("users.json")
//    
//    static var previews: some View {
//        DirectoryView(members: members)
//    }
//}



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
