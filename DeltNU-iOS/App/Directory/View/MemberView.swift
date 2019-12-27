//
//  MemberView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI
import Contacts

struct MemberView: View {
    private let pictureSize = UIScreen.main.bounds.width / 2
    private let member: Member
    private let addVisible: Bool
    
    //Saving contacts stuff
    let store = CNContactStore()
    @State private var showSavedMessage = false
    @State private var saveSuccessful = true
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(maxWidth: self.pictureSize, maxHeight: self.pictureSize)
                    .padding(50)
            }
            
            
            Text("\(member.firstName) \(member.lastName)")
                .font(.largeTitle)
                .padding()
                
            Text(member.pledgeClass.rawValue)
                .padding()
            
            Text(member.phoneNumber)
                .padding()
        
            Text(member.email)
                .padding()
            
            Spacer()
            
            if (addVisible) {
                Button(action: {
                    self.saveContact()
                }) {
                    HStack {
                        Text("Add to contacts ")
                        Image(systemName: "person.badge.plus")
                    }.foregroundColor(Color("colorCTA"))
                }.padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .alert(isPresented: $showSavedMessage) {
            Alert(title: self.saveSuccessful ? Text("Saved") : Text("Error"),
                  message: self.saveSuccessful ? Text("Success! The contact was saved.") : Text("There was an error saving the contact."),
                  dismissButton: .default(Text("Done")))
        }
    }
    
    init(member: Member, addVisible: Bool = true) {
        self.member = member
        self.addVisible = addVisible
    }
    
    private func saveContact() {
        let saveRequest = CNSaveRequest()
        let contact = CNMutableContact()
        contact.givenName = self.member.firstName
        contact.familyName = self.member.lastName
        let phoneNumberField = CNLabeledValue(label: CNLabelPhoneNumberMain,
                                              value: CNPhoneNumber(stringValue: self.member.phoneNumber))
        contact.phoneNumbers = [phoneNumberField]
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        do {
            try self.store.execute(saveRequest)
            saveSuccessful = true
        } catch {
            saveSuccessful = false
        }
        showSavedMessage = true
    }
}

struct MemberView_Previews: PreviewProvider {
    static let members: MemberDirectory = Bundle.main.decode("users.json")

    static var previews: some View {
        MemberView(member: members[0])
    }
}
