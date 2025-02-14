//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//

import SwiftUI



struct MainView: View {
    @EnvironmentObject var localFavoriteService: LocalFavoriteService

    var body: some View {
        TabView {
            TvShowView(viewModel: TvShowViewModel.make())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            UserFavoritesView(viewModel: UserFavoritesViewModel.make(localFavoriteService: localFavoriteService))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            
            UserDetailsView(viewModel: UserAccountViewModel.make())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}




