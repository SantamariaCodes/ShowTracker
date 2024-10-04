//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//


import SwiftUI

struct UserFavoritesView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var userAccountViewModel: UserAccountViewModel

    var body: some View {
        VStack {
            Text("Here is a list of your favorite shows!")
                .font(.headline)
                .padding()

            if let sessionID = authViewModel.sessionID, let accountDetails = userAccountViewModel.accountDetails {
                if userAccountViewModel.favorites.isEmpty {
                    Text("Loading your favorite shows...")
                        .onAppear {
                            let accountID = accountDetails.id
                            userAccountViewModel.getFavorites(accountID: String(accountID), sessionID: sessionID, page: 1)
                        }
                } else {
                    List(userAccountViewModel.favorites, id: \.id) { favorite in
                        VStack(alignment: .leading) {
                            Text(favorite.name)
                                .font(.headline)
                            Text(favorite.overview)
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                    }
                }

                if let errorMessage = userAccountViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }

            } else {
             // user not signed in
                Text("You are not signed in! Please sign in to see your favorite shows.")
            }
        }
    }
}

#Preview {
    UserFavoritesView(
        authViewModel: AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>())),
        userAccountViewModel: UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))
    )
}
