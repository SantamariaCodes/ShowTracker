//
//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//



import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
   // SubGenreListTestView()
       TvShowView(viewModel: TvShowListViewModel.make())
    }
}

struct FavoritesView: View {
    var body: some View {
        
        UserFavoritesView()
    }
}

struct ProfileView: View {
    var body: some View {
        UserDetailsView()
        
    }
}

#Preview {
    MainView()
}
