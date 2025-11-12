//
//  tmdbAccessView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 5/2/25.
//

import SwiftUI

struct TmdbAccessView: View {
    @StateObject var viewModel: AuthViewModel
    @State private var showAlert = false
    
    var body: some View {
        if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
                .multilineTextAlignment(.center)
                .transition(.opacity)
        } else if let requestToken = viewModel.requestToken {
            tmdbLoginButton(alert: $showAlert, requestToken: requestToken)
        } else {
            ProgressView("Fetching request token...")
                .padding()
        }
    }
    
    private func tmdbLoginButton(alert: Binding<Bool>, requestToken: String?) -> some View {
        Button(action: {
            alert.wrappedValue = true
        }) {
            Text("Authenticate with TMDB")
                .fontWeight(.semibold)
                .padding()
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)
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

}


