//
//  ShowDetailView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 30/7/24.
//

import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: TvShowDetailViewModel
    @StateObject private var favoritesViewModel = UserFavoritesViewModel.make()
    @State private var isFavorite: Bool = false
    @State private var showFeedback: Bool = false
  

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let tvShowDetail = viewModel.tvShowDetail {
                VStack(alignment: .leading, spacing: 0) {

                    if let posterURL = tvShowDetail.posterURL {
                        AsyncImage(url: posterURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 400)
                                .cornerRadius(10)
                                .padding(20)
                                .frame(maxWidth: .infinity)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Color.gray
                            .frame(width: 130, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    ShowDetailRowView(tvShow: tvShowDetail)
                        .padding(.bottom, 8)

                    Group {
                        Text(tvShowDetail.name)
                            .font(.headline)
                            .padding(.bottom, 10)
                        Text(tvShowDetail.overview)
                            .font(.body)
                    }
                    .padding(.horizontal)

                    favoriteButton(for: tvShowDetail)

                    Spacer()
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            }
        }
        .navigationTitle("TV Show Details")
        .onAppear {
            viewModel.fetchTvShowDetails()
            favoritesViewModel.updateAccountIDandSessionID()
            favoritesViewModel.getFavorites(page: 1)
        }
        .onReceive(favoritesViewModel.$favorites) { favorites in
            if let id = viewModel.tvShowDetail?.id {
                isFavorite = favorites.contains { $0.id == id }
            }
        }
    }

    @ViewBuilder
    private func favoriteButton(for tvShow: TvShowDetail) -> some View {
        HStack {
            Spacer()
            Button {
                favoritesViewModel.toggleFavorite(
                    mediaType: "tv",
                    mediaId: tvShow.id,
                    currentlyFavorite: isFavorite
                )
                isFavorite.toggle()
                showFeedback = true
            } label: {
                Label(
                    isFavorite ? "Remove Favorite" : "Add to Favorites",
                    systemImage: isFavorite ? "heart.fill" : "heart"
                )
                .foregroundColor(.red)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.2))
                )
            }
            Spacer()
        }
        .padding(.vertical)
    }
    
    struct ShowDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let service = TvShowDetailsService(networkManager: NetworkManager<TvShowTarget>())
            let viewModel = TvShowDetailViewModel(tvShowId: 1399, tvShowDetailsService: service)
            ShowDetailView(viewModel: viewModel)
        }}
}
