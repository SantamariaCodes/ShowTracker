//
//  UserAccountView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI

struct UserAccountView: View {
    @StateObject private var viewModel = UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))

    var sessionID: String 

    var body: some View {
        VStack {
            if let accountDetails = viewModel.accountDetails {
                Text("Welcome, \(accountDetails.username)!")
                Text("Name: \(accountDetails.name)")
          
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Loading account details...")
                    .onAppear {
                        viewModel.fetchAccountDetails(sessionID: sessionID)
                    }
            }
        }
    }
}
