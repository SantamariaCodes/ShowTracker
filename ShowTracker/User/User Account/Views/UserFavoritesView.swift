//
//  UserFavoritesView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//


import SwiftUI

struct UserFavoritesView: View {
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel

    var body: some View {
        VStack {
            Text("Here is a list of your favorite shows!")
                .font(.headline)
                .padding()

            if let accountDetails = userAccountViewModel.accountDetails {
                if userAccountViewModel.favorites.isEmpty {
                    Text("Loading your favorite shows...")
                        .onAppear {
                            let accountID = accountDetails.id
                            userAccountViewModel.getFavorites(accountID: String(accountID), page: 1)
                        }
                } else {
                    GridDisplay(title: "Favorites", tvShows: convertFavoritesToTvShows(favorites: userAccountViewModel.favorites))
                }

                if let errorMessage = userAccountViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            } else {
                Text("You are not signed in! Please sign in to see your favorite shows.")
            }
        }
        .onAppear {
            if userAccountViewModel.accountDetails == nil {
                userAccountViewModel.fetchAccountDetails()
            } else {
                if let accountID = userAccountViewModel.accountDetails?.id {
                    userAccountViewModel.getFavorites(accountID: String(accountID), page: 1)
                }
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
    UserFavoritesView()
        .environmentObject(UserAccountViewModel.make())
}
