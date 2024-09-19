//
//  LoginView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import SwiftUI

struct LoginView: View {

    var body: some View {
        NavigationView {
            
            VStack {
                Image(systemName: "film")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)
                
                Spacer()
                Spacer()

                NavigationLink(destination: LoginExistingUserView()) {
                    LoginRegisterBlackButton(title: "Login")
                }
                   .padding(.bottom, 10)
                
                NavigationLink(destination: RegisterUserView()) {
                    LoginRegisterWhiteButton(title: "Register")
                }
              
                Spacer()
                NavigationLink(destination: MainView()
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)) {
                    Text("Continue as Guest")
                        .foregroundColor(.cyan)
                }

                
             
            }
            .preferredColorScheme(.dark)


        }
    }
}

#Preview {
    LoginView()
}

