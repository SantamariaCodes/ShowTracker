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
        Button(action: {
            
            let convertedShow = convertToFavorite(tvShowDetail: tvShow)
            localFavoriteService.add(convertedShow)
        }) {
            Text("Add to Favorites")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 200)
                .background(Color.red)
                .cornerRadius(25)
        }
    }
    
    private func convertToFavorite(tvShowDetail: TvShowDetail) -> FavoritesModel.TVShow {
        return FavoritesModel.TVShow(
            id: tvShowDetail.id,
            name: tvShowDetail.name,
            overview: tvShowDetail.overview,
            firstAirDate: tvShowDetail.firstAirDate ?? "",
            voteAverage: tvShowDetail.voteAverage ?? 0.0,
            posterPath: tvShowDetail.posterPath,
            backdropPath: nil
        )
    }
}

//struct AddToFavoritesButton_Previews: PreviewProvider {
//    static var previews: some View {
//        let dummyShow = TvShowDetail(
//            id: 1,
//            name: "Dummy Show",
//            overview: "This is a dummy show for testing the add-to-favorites functionality.",
//            firstAirDate: "2023-01-01",
//            numberOfEpisodes: 10,
//            numberOfSeasons: 1,
//            seasons: nil,
//            homepage: nil,
//            posterPath: "/dummyPoster.jpg",
//            voteAverage: 7.5
//        )
//        AddToFavoritesButton(tvShow: dummyShow)
//            .environmentObject(AuthManager.shared)
//            .environmentObject(UserAccountViewModel.make())
//    }
//}

