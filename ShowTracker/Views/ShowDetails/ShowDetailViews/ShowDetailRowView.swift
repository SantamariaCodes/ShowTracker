//
//  ShowDetailRowView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 28/8/24.
//

//
//  DetailRowView.swift
//  MovieTracker
//
//  Created by Diego Santamaria on 30/7/24.
//

import SwiftUI

struct ShowDetailRowView: View {
    let tvShow: TvShowDetail
    
    var body: some View {
        HStack {
            Text(tvShow.name)
            
//            Text("4k")
                .font(.caption)
            Spacer(minLength: 2)
            
            Text("•")
                .font(.title)
                .fixedSize()
                .padding(.horizontal, -6)
            Spacer(minLength: 2)
            
            Text("2h 30m")
                .font(.caption)
            Spacer(minLength: 2)
            Text("•")
                .font(.title)
                .fixedSize()
                .padding(.horizontal, -6)
            
            Spacer(minLength: 2)
            
            Text("Action")
                .font(.caption)
            
            Spacer(minLength: 2)
            
            Text("•")
                .font(.title)
                .fixedSize()
                .padding(.horizontal, -6)
            
            Spacer(minLength: 2)
            
            Text("2023")
                .font(.caption)
        }
        .padding()
    }
    
    
}


//#Preview {
//    ShowDetailRowView(movie: M)
//}
//
