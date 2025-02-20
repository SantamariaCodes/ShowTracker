//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var localFavoriteService: LocalFavoriteService
    @State private var selectedTab: Int = 0
    @State private var homePath = NavigationPath()

    var body: some View {
        TabView(selection: $selectedTab) {
            TvShowView(viewModel: TvShowViewModel.make(), path: $homePath)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            UserFavoritesView(viewModel: UserFavoritesViewModel.make(localFavoriteService: localFavoriteService))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
                .tag(1)
            
            UserDetailsView(viewModel: UserAccountViewModel.make())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
        }
        .onChange(of: selectedTab) {_, newValue in
            if newValue == 0 {
                // Reset the navigation path when Home is reselected.
                homePath = NavigationPath()
            }
        }
    }
}





