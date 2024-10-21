//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//


import SwiftUI

struct UserFavoritesView: View {
    
   
    @StateObject var userFavoritesViewModel: UserFavoritesViewModel

    var body: some View {
        VStack {
            Text("Here is a list of your favorite shows from your TMDB account!")
                .font(.headline)
                .padding()

            if userFavoritesViewModel.favorites.isEmpty {
                Text("It appears you are not logged in. Please log in to see your favorites...")
                    .onAppear {
                        userFavoritesViewModel.updateAccountIDandSessionID()
                        userFavoritesViewModel.getFavorites(page: 1)
                    }
            } else {
                GridDisplay(
                    title: "Favorites",
                    tvShows: convertFavoritesToTvShows(favorites: userFavoritesViewModel.favorites)
                )
            }

        }
        .onAppear {
            if userFavoritesViewModel.accountID != nil {
                userFavoritesViewModel.getFavorites(page: 1)
            }
        }
    }
    
    private func convertFavoritesToTvShows(favorites: [FavoritesModel.TVShow]) -> [TvShow] {
        return favorites.map { favorite in
            TvShow(
                id: favorite.id,
                title: favorite.name,
                overview: favorite.overview,
                posterPath: favorite.posterPath,
                popularity: 0.0, // Replace with actual data if available
                genreId: [], // Replace with actual data if available
                voteAverage: favorite.voteAverage
            )
        }
    }
}

#Preview {
    UserFavoritesView(userFavoritesViewModel: UserFavoritesViewModel.make())
}
