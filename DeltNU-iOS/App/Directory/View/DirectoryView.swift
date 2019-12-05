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
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.searchText).foregroundColor(Color("secondary"))
                }
                .foregroundColor(Color("secondary"))
                .background(Color("colorOnSecondary"))
                .cornerRadius(appStyle.cornerRadius)
                .padding(.horizontal)
                .padding(.top)
                
                //Member list - hide if not loaded
                List(viewModel.members.filter {
                    $0.firstName.hasPrefix(viewModel.searchText) ||
                    $0.lastName.hasPrefix(viewModel.searchText) ||
                    "\($0.firstName) \($0.lastName)".hasPrefix(viewModel.searchText) ||
                    viewModel.searchText == ""
                }) { member in
                        Button(action: {
                            self.selectedMember = member.id
                            self.showingMember = true
                        }) {
                            HStack {
                                Text("\(member.firstName) \(member.lastName)")
                                Spacer()
                                Text(member.gradYear ?? "-")
                            }
                    }
                }
                .resignKeyboardOnDragGesture()
            }
            .sheet(isPresented: $showingMember) {
                MemberView(member: self.members.first { member in
                    member.id == self.selectedMember
                    }!)
            }
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static let members: MemberDirectory = Bundle.main.decode("users.json")

    static var previews: some View {
        DirectoryView(viewModel: DirectoryViewModel(directoryFetcher: MockDirectoryFetcher()))
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
