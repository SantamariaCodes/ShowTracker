//
//  UserDetails.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserAccountViewModel

    @State private var showLoginMessage: Bool = false
    @State private var loginMessage: String = "Successfully Logged In!"
    @State private var amountOfTimesLoginMessageHasBeenDisplayed: Int = 0

    var body: some View {
        VStack {
            viewContent

            if showLoginMessage {
                Text(loginMessage)
                    .foregroundColor(loginMessage == "Successfully Logged In!" ? .green : .red)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.top)
                    .transition(.opacity)
            }
        }
    }

    @ViewBuilder
    private var viewContent: some View {
        ZStack {
            if viewModel.isLoggedIn {
                
                UserAccountView(viewModel: viewModel)
                    .onAppear {
                        displayLoginSuccessMessageOnce()
                    }
            } else {
                AuthView(viewModel: AuthViewModel.make())
                    .onOpenURL { url in
                        handleOpenURL(url)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        viewModel.updateSessionID()
                        viewModel.isLoggedIn = viewModel.sessionID != nil
                    }
                
            }
        }
    }

    private func handleOpenURL(_ url: URL) {
        if url.absoluteString.lowercased().hasSuffix("&approved=true") {
            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
               let queryItems = components.queryItems,
               let requestToken = queryItems.first(where: { $0.name == "request_token" })?.value {
                // Print the token to debug its status
                print("Request Token Status: \(requestToken)")
                
                viewModel.createSession(requestToken: requestToken)
            } else {
                displayLoginFailureMessage()
            }
        } else {
            displayLoginFailureMessage()
        }
    }



    private func displayLoginSuccessMessageOnce() {
        if !showLoginMessage && amountOfTimesLoginMessageHasBeenDisplayed == 0 {
            showLoginMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showLoginMessage = false
                amountOfTimesLoginMessageHasBeenDisplayed = 1
            }
        }
    }

    private func displayLoginFailureMessage() {
        loginMessage = "Login Failed. Please try again."
        showLoginMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showLoginMessage = false
        }
    }
}
