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
                    if let posterURL = viewModel.tvShowDetail?.posterURL {
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
                    if let tvShowDetailExist = viewModel.tvShowDetail {
                        ShowDetailRowView(tvShow: tvShowDetailExist)
                         
                    }
                    
                    Group {
                        Text(tvShowDetail.name)
                            .font(.headline)
                            .padding(.bottom, 10 )
                        Text(tvShowDetail.overview)
                    }
                    .padding(.horizontal)
                    
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
        let service = TvShowDetailsService(networkManager: NetworkManager<TvShowTarget>())
        let viewModel = TvShowDetailViewModel(tvShowId: 1399, tvShowDetailsService: service)
        ShowDetailView(viewModel: viewModel)
    }
}
