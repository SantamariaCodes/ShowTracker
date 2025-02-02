//
//  AuhtView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

//  AuhtView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import SwiftUI
// agregar boton nuevo aqui login with email y en authViewModel logica
struct AuthView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var viewModel: AuthViewModel

    @State private var showAlert = false

    var body: some View {
        NavigationStack{
            VStack {
                emailLoginButton()
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                } else if let requestToken = viewModel.requestToken {

                    tmdbLoginButton(alert: $showAlert, requestToken: viewModel.requestToken)
                    
                } else {
                    ProgressView("Fetching request token...")
                        .padding()
                }
            }
            .padding()
        }
    }
}


private func emailLoginButton() -> some View {
    
    NavigationView {
      AuthenticatedView {
      } content: {
          Welcome()
      }
    }
  }

private func tmdbLoginButton(alert: Binding<Bool>, requestToken: String?) -> some View {
    Button(action: {
        alert.wrappedValue = true
    }) {
        Text("Authenticate with TMDB")
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
    .padding()
    .alert(isPresented: alert) {
        Alert(
            title: Text("Redirect to TMDB"),
            message: Text("You are about to be redirected to the TMDB website for authentication. Do you want to continue?"),
            primaryButton: .default(Text("Continue")) {
                if let token = requestToken,
                   let url = URL(string: "https://www.themoviedb.org/authenticate/\(token)?redirect_to=ShowTracker://approved") {
                    UIApplication.shared.open(url)
                }
            },
            secondaryButton: .cancel()
        )
    }
}
