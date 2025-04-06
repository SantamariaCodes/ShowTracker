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
                .foregroundColor(.gray.opacity(0.7))
            
            Text("Built by Diego Santamaria")
                .font(.footnote)
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(.top, 40)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
    }
}
