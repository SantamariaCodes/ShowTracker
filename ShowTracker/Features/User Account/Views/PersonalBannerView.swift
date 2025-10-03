//
//  PersonalBannerView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 6/4/25.
//

import SwiftUI

struct PersonalBannerView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("© 2025 ShowTracker")
                .font(.footnote)
                .foregroundColor(.gray.opacity(0.9))
            
            Text("Built by Diego Santamaria")
                .font(.footnote)
                .foregroundColor(.gray.opacity(0.9))
            
            Text("This product uses the TMDB API but is not endorsed or certified by TMDB.")
                .font(.caption2)
                .foregroundColor(.gray.opacity(0.9))
                .multilineTextAlignment(.center)

            Link("Powered by TMDB", destination: URL(string: "https://www.themoviedb.org/")!)
                .font(.caption2)
                .foregroundColor(.cyan)
        }
        .padding(.top, 40)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
    }
}
