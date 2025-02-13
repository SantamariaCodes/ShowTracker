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
                    
                
                    // 1)Check if the user is loged in on firebase with the AuthManager.shared.2) Send the TvShowDetail model just like on this case (if let tvShowDetailExist = viewModel.tvShowDetail { ShowDetailRowView(tvShow: tvShowDetailExist)}) Since it has all the qualities of the detail.Since it has all the variables of the show we can pick what we need to send to add the favorites. 3) Once clicked the button adds to the localFavorites through the LocalFavoriteService. 4) I dont know how or where it should be checked if the favorites are there already to avoid duplicates and display it to the user somehow.
                    
                    if AuthManager.shared.authMethod == .firebase {
                        if let tvShowDetailExist = viewModel.tvShowDetail {
                            AddToFavoritesButton(tvShow: tvShowDetailExist)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 20)
                             
                        }
                    }
                    
                 
                    
                    
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
