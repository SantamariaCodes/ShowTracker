//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//


import SwiftUI

struct UserFavoritesView: View {
    
    @StateObject var viewModel: UserFavoritesViewModel
    @State var favoriteShows: [TvShow] = []
    
    
    var body: some View {
        VStack {
            Text("Favorites")
                .font(.headline)
                .foregroundColor(Color.cyan)
                renderUI()
        }
       
        .onAppear {
            if viewModel.accountID != nil {
                viewModel.getFavorites(page: 0)
            }
            favoriteShows = convertFavoritesToTvShows(favorites: viewModel.favorites)
        }
        .padding()
    }
    
    @ViewBuilder
    private func renderUI() -> some View {
        if viewModel.favorites.isEmpty {
            Text("It appears you are not logged in or you don’t have favorites yet!")
                .onAppear {
                    viewModel.updateAccountIDandSessionID()
                    viewModel.getFavorites(page: 1)
                }
        } else {
            // @Binding when using Firebase to ensure UI responsiveness. Plain array from view model when using TMDB.
            NavigationStack {
                if viewModel.FirebaseTrue == true {
                    FavoritesGridDisplayView(
                        title: "Favorites",
                        tvShows: $favoriteShows
                    )
                } else {
                    FavoritesGridDisplayView(
                        title: "Favorites",
                        tvShows: convertFavoritesToTvShows(favorites: viewModel.favorites)
                    )
                }
            }
        }
    }
    private func convertFavoritesToTvShows(favorites: [FavoritesModel.TVShow]) -> [TvShow] {
        let convertFavoriteTvModelToTvShow = favorites.map { favorite in
            TvShow(
                id: favorite.id,
                title: favorite.name,
                overview: favorite.overview,
                posterPath: favorite.posterPath,
                popularity: 0.0,
                genreId: [],
                voteAverage: favorite.voteAverage
            )
        }
        print("This is the conversion happening on UserFavoritesView \(convertFavoriteTvModelToTvShow)")
        return convertFavoriteTvModelToTvShow
    }
}


