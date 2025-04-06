//
//  GridDisplay.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.

import SwiftUI

struct GridDisplayView: View {
    let title: String
    let tvShows: [TvShow]
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]

    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(tvShows) { tvShow in
                    NavigationLink(value: tvShow) {
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
                .frame(width: 120, height: 130)
            
                .shadow(color: .black, radius: 3)
            
            
            if let posterURL = tvShow.posterURL {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 130)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.gray
                    .frame(width: 120, height: 130)
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
