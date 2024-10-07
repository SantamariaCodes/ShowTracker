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

    @State private var showLoginMessage: Bool = false
    @State private var loginMessage: String = "Successfully Logged In!"
    
    @State private var amountOfTimesLoginMessageHasBeenDisplayed: Int  = 0

    var body: some View {
        VStack {
            if let sessionID = authViewModel.sessionID {
                UserAccountView(viewModel: userAccountViewModel, sessionID: sessionID)
                    .onAppear {
                        displayLoginSuccessMessageOnce()
                    }
            } else {
                AuthView()
                    .onOpenURL { url in
                        if url.absoluteString.lowercased().hasSuffix("&approved=true") {
                            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                               let queryItems = components.queryItems,
                               let requestToken = queryItems.first(where: { $0.name == "request_token" })?.value {
                                print("Request Token: \(requestToken)")
                                authViewModel.createSession(requestToken: requestToken)
                            } else {
                                displayLoginFailureMessage()
                            }
                        } else {
                            displayLoginFailureMessage()
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        print("App became active again")
                    }
            }

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
//This might be improved with userDefaults?
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
