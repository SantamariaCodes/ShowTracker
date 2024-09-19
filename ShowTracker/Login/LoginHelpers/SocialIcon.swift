//
//  SocialIcon.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import SwiftUI

struct SocialIcon: View {
    let iconName: String
    let backgroundColor: Color
    
    var body: some View {
        Rectangle()
            .fill(backgroundColor)
            .frame(width: 100, height: 60)
            .overlay(
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            )
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}

struct SocialIconsView: View {
    var body: some View {
        HStack {
            SocialIcon(iconName: "f.square.fill", backgroundColor: .black)
            SocialIcon(iconName: "g.square.fill", backgroundColor: .black)
            SocialIcon(iconName: "applelogo", backgroundColor: .black)
        }
        .frame(maxWidth: .infinity) // Take full width

    }
}


#Preview {
    SocialIconsView()

}
