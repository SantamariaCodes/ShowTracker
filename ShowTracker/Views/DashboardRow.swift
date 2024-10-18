//
//  DashboardRow.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//


import SwiftUI

struct DashboardRow: View {
    let title: String
    let tvShows: [TvShow]
    let listType: TvShowTarget
    @ObservedObject var viewModel: TvShowViewModel
    @State private var isLoadingMore = false
    
    let threshold = 1

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(tvShows.indices, id: \.self) { index in
                        let tvShow = tvShows[index]
                        
                        NavigationLink(destination: ShowDetailView(viewModel: TvShowDetailViewModel(tvShowId: tvShow.id, tvShowDetailsService: TvShowDetailsService(networkManager: NetworkManager<TvShowTarget>())))) {
                            tvShowBanner(tvShow: tvShow)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onAppear {
                            if index >= tvShows.count - threshold && !isLoadingMore {
                                loadMoreIfNeeded()
                            }
                        }
                    }
                    
                if isLoadingMore {
                        ProgressView()
                            .padding()
                            .frame(width: 130, height: 150)
                    }
                }
            }
        }
        .onAppear {
            if tvShows.isEmpty {
                loadMoreIfNeeded()
            }
        }
    }
//
    private func loadMoreIfNeeded() {
        if !isLoadingMore {
            isLoadingMore = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //Consider creating a constant for Key widUpdatedPage(1) sounds confusing.Perhaps .withKey or .listTypeKey
                let currentPage = (viewModel.genreTvShows[listType.withUpdatedPage(1)]?.count ?? 0) / 20 + 1
                print("Loading page \(currentPage + 1) for \(listType)")

                viewModel.loadMoreShows(listType: listType.withUpdatedPage(currentPage + 1))
                // not sure this enhances the user experience
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isLoadingMore = false
                }
            }
        }
    }

    private func tvShowBanner(tvShow: TvShow) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 130, height: 150)
                    .shadow(color: .black, radius: 3)

                if let posterURL = tvShow.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 150)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.gray
                        .frame(width: 130, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Text(tvShow.title)
                .lineLimit(1)
                .frame(width: 90)
        }
        .padding(3)
    }
}
