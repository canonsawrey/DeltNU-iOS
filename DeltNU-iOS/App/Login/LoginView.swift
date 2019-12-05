//
//  LoginView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 12/1/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var session = Session.shared
    
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
                        UIApplication.shared.endEditing()
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
                Text(viewModel.textChangedSincePreviousRequest ? "" : viewModel.error)
                    .foregroundColor(Color("negative"))
                    .padding()
                    .animation(.default)
                Spacer()
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
