//
//  SignupView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 23/1/25.
//

import Foundation
import SwiftUI
import Combine

private enum FocusableField: Hashable {
  case email
  case password
  case confirmPassword
}

struct SignupView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel
  @Environment(\.dismiss) var dismiss

  @FocusState private var focus: FocusableField?

  private func signUpWithEmailPassword() {
    Task {
      if await viewModel.signUpWithEmailPassword() == true {
        dismiss()
      }
    }
  }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Sign up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Image(systemName: "at")
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .password
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 4)
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $viewModel.password)
                        .focused($focus, equals: .password)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .confirmPassword
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Confirm password", text: $viewModel.confirmPassword)
                        .focused($focus, equals: .confirmPassword)
                        .submitLabel(.go)
                        .onSubmit {
                            signUpWithEmailPassword()
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
                
                
                if !viewModel.errorMessage.isEmpty {
                    VStack {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color(UIColor.systemRed))
                    }
                }
                
                Button(action: signUpWithEmailPassword) {
                    if viewModel.authenticationState != .authenticating {
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)

                    }
                    else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!viewModel.isValid)
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Already have an account?")
                    Button(action: { viewModel.switchFlow() }) {
                        Text("Log in")
                            .fontWeight(.semibold)
                            .foregroundColor(.cyan)
                    }
                }
                .padding([.top, .bottom], 50)
                
            }
            .listStyle(.plain)
            .padding()
        }
        .foregroundColor(.white) 
    }
}

//struct SignupView_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//      SignupView()
//      SignupView()
//        .preferredColorScheme(.dark)
//    }
//    .environmentObject(AuthenticationViewModel())
//  }
//}
