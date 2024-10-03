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

                if viewModel.favorites.isEmpty {
                    Text("Loading your favorite shows...")
                        .onAppear {
                            let accountID = accountDetails.id
                            viewModel.getFavorites(accountID: String(accountID), sessionID: sessionID, page: 1)
                        }
                } else {
                    List(viewModel.favorites, id: \.id) { favorite in
                        VStack(alignment: .leading) {
                            Text(favorite.name)
                                .font(.headline)
                            Text(favorite.overview)
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
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

#Preview {
    UserAccountView(sessionID: "your-session-id")
}
