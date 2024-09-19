//
//  LoginExistingUserView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import SwiftUI

struct LoginExistingUserView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome back! Glad to see you, Again!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                TextField("Enter your email", text: $email)
                    .customTextFieldStyle()
                    .padding(.bottom, 16)
                
                SecureField("Enter your password", text: $password)
                    .customTextFieldStyle()
                
                
                HStack {
                    // this should change with networking
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Forgot password?")
                            .foregroundColor(.cyan)
                    }
                    
                }
                .padding(.vertical, 8)
                
                
                HStack {
                    Spacer()
                    VStack {
                        LoginRegisterBlackButton(title: "Login")
                            .padding(.vertical, 20)
                        LoginDivider(type: .login)
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
                        type: .register,
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
    LoginExistingUserView()
}
