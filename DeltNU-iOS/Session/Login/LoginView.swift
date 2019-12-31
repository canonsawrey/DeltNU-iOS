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
    private let pictureSize = UIScreen.main.bounds.width * 3 / 4
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        ZStack {
            VStack {
                    VStack {
                        Spacer()
                            Image("Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: pictureSize)
                        Spacer()
                    }.frame(maxHeight: keyboard.currentHeight == 0.0 ? .infinity : 100)
                        .animation(.default)
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .cornerRadius( appStyle.cornerRadius)
                    .autocapitalization(UITextAutocapitalizationType.none)
                    .padding()
                    .animation(.default)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .cornerRadius(appStyle.cornerRadius)
                    .padding()
                    .animation(.default)
                ZStack {
                    Text("Success. Retrieving data...").opacity(viewModel.signedIn ? 1.0 : 0.0)
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
                        .opacity(viewModel.signedIn ? 0.0 : (signInButtonDisabled ? 0.5 : 1.0))
                        .animation(.default)
                        .disabled(signInButtonDisabled)
                }.padding()//.frame(alignment: .center)
                Text(viewModel.error)
                    .foregroundColor(Color("negative"))
                    .animation(.default)
                    .padding()
                Spacer()
                Button(action: {
                    guard let url = URL(string: EndpointApi.resetPassword) else { return }
                        UIApplication.shared.open(url)
                    }) {
                    Text("Forgot password")
                }.foregroundColor(Color("colorCTA")).padding()
                }
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
