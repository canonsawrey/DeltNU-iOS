//
//  LogoutSheet.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI


struct LogoutSheet: View {
    private let credentialRepository = DefaultCredentialRepository()
    private let session = Session.shared
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TileButton(
                action: {
                    withAnimation {
                        self.session.clearSession()
                    }
                    self.credentialRepository.clearCredentials()
                    self.presentationMode.wrappedValue.dismiss()
                },
                text: "Confirm logout",
                color: Color("negative"),
                textColor: Color("colorOnSecondary")
            )
            TileButton(
                action: { self.presentationMode.wrappedValue.dismiss() },
                text: "Cancel",
                color: Color("primary"),
                textColor: Color("colorOnPrimary")
            )
        }
    }
}

struct LogoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        LogoutSheet()
    }
}
