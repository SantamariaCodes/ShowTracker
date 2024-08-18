//
//  TvShowDetailView.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 21/2/24.
//


import SwiftUI

struct TvShowDetailView: View {
    @ObservedObject var viewModel: TvShowDetailViewModel

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let tvShowDetail = viewModel.tvShowDetail {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tvShowDetail.name)
                        Text(tvShowDetail.overview)
                        Text(tvShowDetail.firstAirDate ?? "N/A")
                            .font(.title)
                        
                        // Display poster, overview, genres, and rating...
                    }
                    .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                }
            }
        }
        .navigationTitle("TV Show Details")
        .onAppear {
            viewModel.fetchTvShowDetails()
        }
    }
}

// Example usage, ensure you have a valid TV show ID and network service setup to use it
struct TvShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let service = TvShowDetailsService(networkManager: NetworkManager<TvShowListTarget>())
        let viewModel = TvShowDetailViewModel(tvShowId: 1399, tvShowDetailsService: service)
        TvShowDetailView(viewModel: viewModel)
    }
}
