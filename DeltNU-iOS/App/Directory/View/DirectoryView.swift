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
                SearchBar(text: $viewModel.searchText).padding(.horizontal)
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
                            Button(action: {
                                UIApplication.shared.open(URL(string: "sms:\(member.phoneNumber)")!, options: [:], completionHandler: nil)
                            }) {
                                Image(systemName: "message.circle").foregroundColor(Color("CTA"))
                            }
                            Button(action: {
                                UIApplication.shared.open(URL(string: "tel:\(member.phoneNumber)")!, options: [:], completionHandler: nil)
                            }) {
                                Image(systemName: "phone.circle").foregroundColor(Color("CTA")).padding()
                            }
                            Button(action: {
                                UIApplication.shared.open(URL(string: "mailto:\(member.email)")!, options: [:], completionHandler: nil)
                            }) {
                                Image(systemName: "envelope.circle").foregroundColor(Color("CTA"))
                            }
                        }
                    }
                }
                .resignKeyboardOnDragGesture()
            }
            .sheet(isPresented: $showingMember) {
                if let brother = self.viewModel.members.first(where: { member in
                    member.id == self.selectedMember
                }) {
                    MemberView(member: brother)
                }
            }
            .navigationBarTitle("Directory")
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: viewModel.getMembers)
    }
    
    init(viewModel: DirectoryViewModel) {
        self.viewModel = viewModel
        viewModel.getMembers()
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static let members: MemberDirectory = Bundle.main.decode("users.json")
    
    static var previews: some View {
        DirectoryView(viewModel: DirectoryViewModel(repository: DefaultDirectoryRepository()))
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
