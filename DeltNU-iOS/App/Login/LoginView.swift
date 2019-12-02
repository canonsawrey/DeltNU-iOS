//
//  LoginView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var session: Session
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            VStack {
                Text("ΔTΔ").font(.system(size: 40))
                    .padding(.vertical)
                    .foregroundColor(Color("colorOnPrimary"))
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .cornerRadius( appStyle.cornerRadius).padding()
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .cornerRadius( appStyle.cornerRadius).padding()
                Button(
                    action: {
                        self.viewModel.loggingIn = true
                        self.viewModel.login()
                        }
                ) {
                    HStack {
                        Spacer()
                        Text(viewModel.loggingIn ? "Logging in..." : "Login")
                        Spacer()
                    }.padding().padding(.horizontal)
                        .background(viewModel.loggingIn ? Color("primary"): Color("secondary"))
                    .foregroundColor(viewModel.loggingIn ? Color("colorOnPrimary") : Color("colorOnSecondary"))
                    .cornerRadius(appStyle.cornerRadius)
                }
                .disabled(viewModel.loggingIn).padding()
                .animation(.default)
                Text(viewModel.error)
                    .foregroundColor(Color("negative"))
                    .padding()
                    .animation(.default)
                Spacer()
            }.padding()
        }
    }
    
    init(session: Session) {
        self.session = session
        self.viewModel = LoginViewModel(session: self.session)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(session: Session())
    }
}
