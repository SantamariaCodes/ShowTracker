//
//  UserDetails.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI
// this works
struct UserDetailsView: View {
    @StateObject private var viewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))
    
    var body: some View {
        if let sessionID = viewModel.sessionID {
            UserAccountView(sessionID: sessionID)
        } else {
            AuthView()
                .onOpenURL { url in
                    if url.absoluteString.lowercased().hasSuffix("&approved=true") {
                        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                           let queryItems = components.queryItems {
                            if let requestToken = queryItems.first(where: { $0.name == "request_token" })?.value {
                                print("Request Token: \(requestToken)")
                                viewModel.createSession(requestToken: requestToken)
                            } else {
                                print("Request token not found.")
                            }
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("App became active again")
                }
        }
    }
}

#Preview {
    UserDetailsView()
}

