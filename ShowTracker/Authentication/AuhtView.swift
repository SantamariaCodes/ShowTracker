//
//  AuhtView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))

    var body: some View {
        VStack {
            if let requestToken = viewModel.requestToken {
                Button("Authenticate with TMDB") {
                    if let url = URL(string: "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=PortfolioApp://approved") {
                        UIApplication.shared.open(url)
                  
                    }
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                Text("Fetching request token...")
            }
            
            
        }
    }
}

