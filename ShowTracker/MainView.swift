//
//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//
// Add implementation for guest to have favorite shows list
// Add navigation to favorite shows
// Add ability to view details on saved favorites
// Unify objects? on details and tvShow?


import SwiftUI

struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))
    @StateObject private var userAccountViewModel = UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))
    
    var body: some View {
        ZStack {
            TabView {
                TvShowView(viewModel: TvShowListViewModel.make())
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                UserFavoritesView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }
                
                UserDetailsView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            // Injecting the view models into the environment
            .environmentObject(authViewModel)
            .environmentObject(userAccountViewModel)
        }
    }
}


