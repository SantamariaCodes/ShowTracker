//
//  RegisterUserView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import SwiftUI

struct RegisterUserView: View {
    
    @State private var username:String = ""
    @State private var email:String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Hello! Register to get started")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                TextField("Username", text: $username)
                    .customTextFieldStyle()
                TextField("Email", text: $email)
                    .customTextFieldStyle()
                SecureField("Password", text: $password)
                    .customTextFieldStyle()
                SecureField("Confirm password", text: $confirmPassword)
                    .customTextFieldStyle()
                
                
                
                HStack {
                    
                    VStack {
                        LoginRegisterBlackButton(title: "Register")
                            .padding(.vertical, 20)
                        LoginDivider(type: .register)
                            .padding(.top, 20)
                        SocialIconsView()
                            .padding(.top,5)
                        
                    }
                    Spacer()
                }
                Spacer()
                // There must be a better way
                HStack {
                    
                    Spacer()
                    AuthLinkView(
                        type: .login,
                        destination: AnyView(RegisterUserView())
                    )
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegisterUserView()
}
