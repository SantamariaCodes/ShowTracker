//
//  SubGenreRowView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 14/5/25.
//

import SwiftUI

struct SubGenreRowView: View {
    @StateObject var viewModel: SubGenreRowViewModel
    @State private var isLoadingMore = false
    
    private var title: String {
        viewModel.subGenre.name
    }
    private var filteredShows: [TvShow] {
        viewModel.filteredShows()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(   viewModel.filteredShows().indices, id: \.self) { index in
                        let tvShow = filteredShows[index]
                        
                        NavigationLink(value: tvShow) {
                            tvShowBanner(tvShow: tvShow)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .onChange(of: geo.frame(in: .global).minX) { _, _ in
                                                detectIfEndItemVisible(index: index, geo: geo)
                                            }
                                    }
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    if isLoadingMore {
                        ProgressView()
                            .padding()
                            .frame(width: 130, height: 150)
                    }
                }
                
                .onAppear {
                    if filteredShows.count < 5 && !isLoadingMore {
                        viewModel.loadMoreIfNeeded()
                    }
                }
            }
        }
    }
    
    private func tvShowBanner(tvShow: TvShow) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
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
    
    private func detectIfEndItemVisible(index: Int, geo: GeometryProxy) {
        let screenWidth = UIScreen.main.bounds.width
        let frame = geo.frame(in: .global)
        
        if index == filteredShows.count - 2 &&
            frame.minX < screenWidth &&
            frame.maxX > 0 &&
            !isLoadingMore {
            print("Detected last visible item via GeometryReader.")
            viewModel.loadMoreIfNeeded()
        }
    }
}
//#Preview {
//    SubGenreRowView()
//}
