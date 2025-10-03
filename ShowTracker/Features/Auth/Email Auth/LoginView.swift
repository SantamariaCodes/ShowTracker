//
//  LoginView.swift
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
}

struct LoginView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel

  @Environment(\.dismiss) var dismiss

  @FocusState private var focus: FocusableField?

  private func signInWithEmailPassword() {
    Task {
      if await viewModel.signInWithEmailPassword() == true {
        dismiss()
      }
    }
  }

    var body: some View {
      ZStack {
        Color.black.ignoresSafeArea() 

        VStack {
          Text("Login")
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
              .onSubmit { self.focus = .password }
          }
          .padding(.vertical, 6)
          .background(Divider(), alignment: .bottom)
          .padding(.bottom, 4)

          HStack {
            Image(systemName: "lock")
            SecureField("Password", text: $viewModel.password)
              .focused($focus, equals: .password)
              .submitLabel(.go)
              .onSubmit { signInWithEmailPassword() }
          }
          .padding(.vertical, 6)
          .background(Divider(), alignment: .bottom)
          .padding(.bottom, 8)

          if !viewModel.errorMessage.isEmpty {
            Text(viewModel.errorMessage)
              .foregroundColor(Color.red)
          }

          Button(action: signInWithEmailPassword) {
            if viewModel.authenticationState != .authenticating {
              Text("Login")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)
            } else {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
            }
          }
          .disabled(!viewModel.isValid)

          HStack {
            VStack { Divider() }
            Text("or")
            VStack { Divider() }
          }

          HStack {
            Text("Don't have an account yet?")
            Button(action: { viewModel.switchFlow() }) {
              Text("Sign up")
                .fontWeight(.semibold)
                .foregroundColor(Color.cyan)
            }
          }
          .padding(.vertical, 50)
        }
        .foregroundColor(.white)
        .padding()
      }
    }

}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LoginView()
      LoginView()
    }
    .environmentObject(AuthenticationViewModel())
  }
}
