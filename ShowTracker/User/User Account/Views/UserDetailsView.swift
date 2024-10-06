//
//  UserDetails.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var userAccountViewModel: UserAccountViewModel
    var onLoginSuccess: () -> Void

    var body: some View {
        if let sessionID = authViewModel.sessionID {
            UserAccountView(viewModel: userAccountViewModel, sessionID: sessionID)
        } else {
            AuthView()
                .onOpenURL { url in
                    if url.absoluteString.lowercased().hasSuffix("&approved=true") {
                        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                           let queryItems = components.queryItems {
                            if let requestToken = queryItems.first(where: { $0.name == "request_token" })?.value {
                                print("Request Token: \(requestToken)")
                                authViewModel.createSession(requestToken: requestToken)
                            } else {
                                print("Request token not found.")
                            }
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    if authViewModel.sessionID != nil {
                        onLoginSuccess()
                    }
                    print("App became active again")
                }
        }
    }
}



