//
//  ShowDetailRowView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 28/8/24.
//

import SwiftUI

struct ShowDetailRowView: View {
    let tvShow: TvShowDetail
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let voteAverage = tvShow.voteAverage {
                    Text("Vote average: \(String(format: "%.1f", voteAverage))")
                        .font(.caption)
                } else {
                    Text("Vote average: N/A")
                    
                }
                Divider().customSeparatorStyle()

                
                Text("AirDate \(tvShow.firstAirDate ?? "N/A")" )
                    .font(.caption)
                Divider().customSeparatorStyle()

                
                if let episodeCount = tvShow.numberOfSeasons {
                    Text("Episodes: \( episodeCount)")
                        .font(.caption)
                } else {
                    Text("Episodes: N/A")
                    
                }
                Divider().customSeparatorStyle()

                
                if let seasons = tvShow.numberOfSeasons {
                    Text("Seasons: \( seasons)")
                        .font(.caption)
                } else {
                    Text("Seasons: N/A")
                    
                }
            }
            .padding(.horizontal)
        }
    }
    
    
}
