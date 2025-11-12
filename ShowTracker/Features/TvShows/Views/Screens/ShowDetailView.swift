//
//  ShowDetailView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 30/7/24.
//

import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: TvShowDetailViewModel
    @EnvironmentObject var favoritesViewModel: UserFavoritesViewModel
    private var isFavorite: Bool {
        favoritesViewModel.isFavorite(viewModel.tvShowDetail?.id ?? 0)
    }
    
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
    }
    
    @ViewBuilder
    private func favoriteButton(for tvShow: TvShowDetail) -> some View {
        if favoritesViewModel.isLoggedIn  {
            HStack {
                Spacer()
                Button {
                    favoritesViewModel.toggleFavorite(
                        mediaType: "tv",
                        mediaId: tvShow.id,
                        currentlyFavorite: isFavorite
                    )
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
            
        } else {
            Label("Sign in from your Profile to add favorites.", systemImage: "info.circle.fill")
                .foregroundColor(.cyan)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.cyan.opacity(0.15))
                )
                .padding()
        }
    }
}
