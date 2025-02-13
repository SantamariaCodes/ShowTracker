//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//


import SwiftUI

struct UserFavoritesView: View {
    
   
    @StateObject var viewModel: UserFavoritesViewModel

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
                GridDisplayView(
                    title: "Favorites",
                    tvShows: convertFavoritesToTvShows(favorites: viewModel.favorites)
                )
            }

        }
       
        .onAppear {
            if viewModel.accountID != nil {
                viewModel.getFavorites(page: 1)
            }
        }
        .padding()
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
    UserFavoritesView(viewModel: UserFavoritesViewModel.make())
}
