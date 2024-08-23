//
//  GridDisplay.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.

import SwiftUI

struct GridDisplay: View {
    let title: String
    let tvShows: [TvShow]

    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(tvShows) { tvShow in
                    NavigationLink(destination: TvShowDetailView(viewModel: TvShowDetailViewModel(tvShowId: tvShow.id, tvShowDetailsService: TvShowDetailsService(networkManager: NetworkManager<TvShowListTarget>())))) {
                        tvShowBanner(tvShow: tvShow)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }

    }
}

private func tvShowBanner(tvShow: TvShow) -> some View {
    VStack {
        ZStack {
             RoundedRectangle(cornerRadius: 20)
                 .fill(Color.white)
                 .shadow(color: .black, radius: 3)

            if let posterURL = tvShow.posterURL {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 130)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView() // Placeholder while loading
                }
            } else {
                Color.gray // Fallback for missing image
                    .frame(width: 130, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
         }
        VStack {
            Text(tvShow.title)
                .font(.caption)
                .lineLimit(1)
        }
    }
    .padding(2)
}
//#Preview {
//    GridDisplay(genre: "Action", movies: Movie.exampleArray)
//}

//
//    .resizable()
//    .scaledToFit()
//    .clipShape(RoundedRectangle(cornerRadius: 10))
