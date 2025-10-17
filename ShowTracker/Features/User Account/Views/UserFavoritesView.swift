//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//

import SwiftUI

struct UserFavoritesView: View {
    @StateObject var viewModel: UserFavoritesViewModel
    @State private var favoriteShows: [TvShow] = []

    var body: some View {
        VStack {
            Text("Favorites")
                .font(.headline)
                .foregroundColor(.cyan)

            renderUI()
        }
        .padding()
        .onAppear {
            viewModel.updateAccountIDandSessionID()
            if let _ = viewModel.accountID {
                viewModel.getFavorites(page: 1)
            }
        }
        .onReceive(viewModel.$favorites) { favorites in
            favoriteShows = convertFavoritesToTvShows(favorites: favorites)
        }
    }

    @ViewBuilder
    private func renderUI() -> some View {
        if viewModel.isLoading {
            ProgressView("Loading favorites...")
                .tint(.cyan)
                .padding()
        } else if viewModel.favorites.isEmpty {
            VStack(spacing: 16) {
                Text("It appears you are not logged in or don’t have favorites yet!")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                PersonalBannerView()
                    .onAppear {
                        viewModel.updateAccountIDandSessionID()
                        viewModel.getFavorites(page: 1)
                    }
            }
            .padding(.top, 40)
        } else {
            NavigationStack {
                FavoritesGridDisplayView(
                    title: "Favorites",
                    tvShows: favoriteShows
                )
                .navigationTitle("Your Favorites")
            }
        }
    }

    private func convertFavoritesToTvShows(favorites: [FavoritesModel.TVShow]) -> [TvShow] {
        favorites.map { favorite in
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
    }
}
