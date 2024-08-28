//
//  ShowDetailView.swift
//
//  Created by Diego Santamaria on 30/7/24.
//

import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: TvShowDetailViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let tvShowDetail = viewModel.tvShowDetail{
                VStack(alignment: .leading, spacing: 0) {
//                    Image(decorative: movie.image)
//                        .resizable()
//                        .scaledToFit()
                    
//                    ShowDetailRowView(movie: movie)
//                        .padding()
                    
                    
                    
                    if let posterURL = viewModel.tvShowDetail?.posterURL {
                        AsyncImage(url: posterURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView() // Placeholder while loading
                        }
                    } else {
                        Color.gray // Fallback for missing image
                            .frame(width: 130, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    if let tvShowDetailExist = viewModel.tvShowDetail {
                        ShowDetailRowView(tvShow: tvShowDetailExist)
                         
                    }
                    
                    
                    Group {
                        Text(tvShowDetail.name)
                            .font(.headline)
                        Text(tvShowDetail.overview)
                    }
                    .padding(.horizontal)
                    
                    AddToFavoritesButton()
                        .padding()
                    
                }
            }
            else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            }
            
        }
        .navigationTitle("TV Show Details")
        .onAppear {
            viewModel.fetchTvShowDetails()
        }
    }
}



struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let service = TvShowDetailsService(networkManager: NetworkManager<TvShowListTarget>())
        let viewModel = TvShowDetailViewModel(tvShowId: 1399, tvShowDetailsService: service)
        ShowDetailView(viewModel: viewModel)
    }
}


struct AddToFavoritesButton: View {
    var body: some View {
        Button(action: {
            // Action to add to favorites
            print("Add to Favorites tapped")
        }) {
            Text("Add to Favorites")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(25)
        }
        .padding(.horizontal)
    }
}
