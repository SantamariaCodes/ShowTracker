//
//  GridDisplay.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//
//import SwiftUI
//
//struct GridDisplay: View {
//    let genre: String
//    let movies: [Movie]
//
//    let columns = [
//        GridItem(.adaptive(minimum: 100))
//    ]
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(movies) { movie in
//                    NavigationLink(value: movie) {
//                        movieBanner(movie: movie)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                }
//            }
//        }
//
//    }
//}
//
//private func movieBanner(movie: Movie) -> some View {
//    VStack {
//        ZStack {
//             RoundedRectangle(cornerRadius: 20)
//                 .fill(Color.white)
//                 .shadow(color: .black, radius: 3)
//
//             Image(movie.image)
//                 .resizable()
//                 .scaledToFit()
//                 .clipShape(RoundedRectangle(cornerRadius: 10))
//         }
//        VStack {
//            Text(movie.title)
//                .font(.caption)
//                .lineLimit(1)
//        }
//    }
//    .padding(2)
//}
//#Preview {
//    GridDisplay(genre: "Action", movies: Movie.exampleArray)
//}
