//
//  DirectoryView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct DirectoryView: View {
    //View model
    @ObservedObject var viewModel: DirectoryViewModel
    //Member detail bottom sheet state
    @State var selectedMember: Int = 0
    @State var showingMember = false
    @State var showCancelButton = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("colorOnPrimaryAccent"))
                        
                        TextField("Search", text: $viewModel.searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            //print("onCommit")
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.viewModel.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(viewModel.searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.viewModel.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color("colorOnPrimaryAccent"))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                
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
                MemberView(member: self.viewModel.members.first { member in
                    member.id == self.selectedMember
                    }!)
            }
            .navigationBarTitle("Directory")
        }.onAppear(perform: viewModel.getMembers)
    }
    
    init(viewModel: DirectoryViewModel) {
        self.viewModel = viewModel
        viewModel.getMembers()
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
