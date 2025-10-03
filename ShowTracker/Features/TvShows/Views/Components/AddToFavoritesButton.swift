//
//  AddToFavoritesButton.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 10/10/24.
//

import SwiftUI

struct AddToFavoritesButton: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    @EnvironmentObject var localFavoriteService: LocalFavoriteService

    let tvShow: TvShowDetail
    
    var body: some View {
        let convertedShow = convertToFavorite(tvShowDetail: tvShow)
        
        if localFavoriteService.checkIfFavorite(convertedShow) {
            Button(action: {
                localFavoriteService.remove(convertedShow)
            }) {
                Text("Remove from Favorites")
                    .fontWeight(.semibold)
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 4)
            }
            .padding(.bottom, 20)
            
            
        } else {
            Button(action: {
                localFavoriteService.add(convertedShow)
            }) {
                Text("Add to Favorites")
                    .fontWeight(.semibold)
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)
            }
            .padding(.bottom, 20)

        }
    }
    
    private func convertToFavorite(tvShowDetail: TvShowDetail) -> FavoritesModel.TVShow {
        let favorite = FavoritesModel.TVShow(
            id: tvShowDetail.id,
            name: tvShowDetail.name,
            overview: tvShowDetail.overview,
            firstAirDate: tvShowDetail.firstAirDate ?? "",
            voteAverage: tvShowDetail.voteAverage ?? 0.0,
            posterPath: tvShowDetail.posterPath,
            backdropPath: nil
        )
        print("Converted tvShowDetail: \(tvShowDetail) into favorite: \(favorite)")
        return favorite
    }
}
