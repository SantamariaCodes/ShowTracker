//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//
// Add implementation for guest to have favorite shows list
// Add navigation to favorite shows
// Add ability to view details on saved favorites
// Unify objects? on details and tvShow?
// Favorites shares Target from UserAccountView is that according best practices?
// Add to watchList/ favorites button does nothing. Add local save later



import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            TvShowView(viewModel: TvShowViewModel.make())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            UserFavoritesView(userFavoritesViewModel: UserFavoritesViewModel.make())
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }

            UserDetailsView(userAccountViewModel: UserAccountViewModel.make())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}



