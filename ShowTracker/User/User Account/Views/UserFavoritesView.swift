//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//

import SwiftUI

struct UserFavoritesView: View {
//    @StateObject private var authViewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))
    @StateObject private var userAccountViewModel = UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))

    var body: some View {
        VStack {
            
            
            Text("Here is a list of your favorite shows!")
                .font(.headline)
                .padding()
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
    }
}

#Preview {
    UserFavoritesView()
}
