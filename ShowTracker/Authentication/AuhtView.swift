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

struct AuthView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel

    @State private var showAlert = false

    var body: some View {
        VStack {
            // Display the error message if it exists
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .multilineTextAlignment(.center)
                    .transition(.opacity) // Smooth appearance for error messages
            } else if let requestToken = viewModel.requestToken {
                Text("Hi! It appears you aren't signed in. We need to redirect you to the TMDB authentication page. If you wish to continue, please click the button below.")
                    .padding()
                    .multilineTextAlignment(.center)

                Button(action: {
                    showAlert = true
                }) {
                    Text("Authenticate with TMDB")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Redirect to TMDB"),
                        message: Text("You are about to be redirected to the TMDB website for authentication. Do you want to continue?"),
                        primaryButton: .default(Text("Continue")) {
                            if let url = URL(string: "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=PortfolioApp://approved") {
                                UIApplication.shared.open(url)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            } else {
                ProgressView("Fetching request token...")
                    .padding()
            }
        }
        .padding()
    }
}
