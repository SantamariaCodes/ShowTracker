//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//

import SwiftUI

struct UserFavoritesView: View {
//    @StateObject private var authViewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))
//    @StateObject private var userAccountViewModel = UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))

    var body: some View {
        VStack {
         Text("placeholder this breaks production with it commented out it works fine")
//
//            Text("Here is a list of your favorite shows!")
//                .font(.headline)
//                .padding()
//
//            if let sessionID = authViewModel.sessionID {
//                if userAccountViewModel.favorites.isEmpty {
//                    Text("Loading your favorite shows...")
//                        .onAppear {
//                            // Assuming accountID is fetched elsewhere or passed in
//                            let accountID = "12345"
//                            userAccountViewModel.getFavorites(accountID: accountID, sessionID: sessionID, page: 1)
//                        }
//                } else {
//                    List(userAccountViewModel.favorites, id: \.id) { favorite in
//                        VStack(alignment: .leading) {
//                            Text(favorite.name)
//                                .font(.headline)
//                            Text(favorite.overview)
//                                .font(.subheadline)
//                                .lineLimit(2)
//                        }
//                    }
//                }
//
//                if let errorMessage = userAccountViewModel.errorMessage {
//                    Text("Error: \(errorMessage)")
//                        .foregroundColor(.red)
//                }
//            } else {
//                Text("Authenticating...")
//                    .onAppear {
//                        // Ensure that the request token and session creation are triggered here
//                        if let requestToken = authViewModel.requestToken {
//                            authViewModel.createSession(requestToken: requestToken)
//                        } else {
//                            authViewModel.fetchRequestToken()
//                        }
//                    }
//            }
        }
    }
}

#Preview {
    UserFavoritesView()
}
