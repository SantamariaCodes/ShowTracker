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
                    LoginMessageView(message: loginMessage, isSuccess: loginMessage == "Successfully Logged In!")
                }
        }
    }

    @ViewBuilder
    private var viewContent: some View {
        ZStack {
            if viewModel.isLoggedIn {
                UserAccountView(viewModel: viewModel)
                    .onAppear { displayLoginSuccessMessageOnce() }
            } else {
                AuthViewContainer(viewModel: viewModel)
            }

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
}
