//
//  AuthenticationView.swift
//  FireTest
//
//  Created by Diego Santamaria on 19/12/24.
//


import SwiftUI
import Combine

struct AuthenticationView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      switch viewModel.flow {
      case .login:
        LoginView()
          .environmentObject(viewModel)
      case .signUp:
        SignupView()
          .environmentObject(viewModel)
      }
    }
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
      .environmentObject(AuthenticationViewModel())
  }
}


