//
//  LogoutSheet.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct LogoutSheet: View {

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TileButton(
                action: {
                    print("Logged out!")
                    self.presentationMode.wrappedValue.dismiss() },
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
