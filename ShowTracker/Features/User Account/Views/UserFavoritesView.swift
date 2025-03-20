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
            Text("Here is a list of your favorite shows!")
                .font(.headline)

            if viewModel.favorites.isEmpty {
                Text("It appears you are not logged in or you dont have favorites yet!")
                    .onAppear {
                        viewModel.updateAccountIDandSessionID()
                        viewModel.getFavorites(page: 1)
                    }
                    
            } else {
                NavigationStack{
                    FavoritesGridDisplayView(
                        title: "Favorites",
                        tvShows: $favoriteShows)
                }
            }

        }
       
        .onAppear {
            if viewModel.accountID != nil {
                viewModel.getFavorites(page: 0)
            }
            favoriteShows = convertFavoritesToTvShows(favorites: viewModel.favorites)
        }
        .padding()
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


