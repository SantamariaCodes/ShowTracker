//
//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//



import SwiftUI

struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))
    @StateObject private var userAccountViewModel = UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))

    var body: some View {
        TabView {
            TvShowView(viewModel: TvShowListViewModel.make())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            UserFavoritesView(authViewModel: authViewModel, userAccountViewModel: userAccountViewModel)                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }

            UserDetailsView(authViewModel: authViewModel, userAccountViewModel: userAccountViewModel)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainView()
}
