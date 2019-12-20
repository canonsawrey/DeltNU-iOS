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
    var signInButtonDisabled: Bool {
        viewModel.email == "" || viewModel.password == "" || viewModel.signingIn
    }
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Sign in to DeltNU").font(.system(size: 40))
                    .padding(.vertical)
                    .foregroundColor(Color("colorOnPrimary"))
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .cornerRadius( appStyle.cornerRadius).padding()
                    .autocapitalization(UITextAutocapitalizationType.none)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .cornerRadius( appStyle.cornerRadius).padding()
                Button(
                    action: {
                        UIApplication.shared.endEditing()
                        self.viewModel.login()
                    }
                ) {
                    HStack {
                        Spacer()
                        Text(viewModel.signingIn ? "Signing in..." : "Sign in")
                        Spacer()
                    }
                    }.buttonStyle(MainButtonStyle())
                    .opacity(signInButtonDisabled ? 0.5 : 1.0)
                    .disabled(signInButtonDisabled).padding()
                    .animation(.spring())
                Text(viewModel.error)
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
