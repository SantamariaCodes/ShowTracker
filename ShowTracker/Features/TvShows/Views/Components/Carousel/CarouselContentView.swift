//
//  CarouselContentView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//



import SwiftUI

struct CarouselContentView: View {
    var shows: [TvShow]

    var body: some View {
        ZStack {
            CarouselView(views: getChildViews())
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
    }

    func getChildViews() -> [CarouselViewChild] {
        var tempViews: [CarouselViewChild] = []

        for (index, show) in shows.prefix(5).enumerated() {
            tempViews.append(CarouselViewChild(id: index, content: {
                carouselCardView(for: show)
            }))
        }
        return tempViews
    }

    @ViewBuilder
    private func carouselCardView(for show: TvShow) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ZStack {
                if let posterURL = show.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: height)
                            .cornerRadius(18)
                            .overlay(
                                ZStack(alignment: .leading) {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: width, height: height)
                                        .cornerRadius(18)
                                        .blur(radius: 20)
                                        .mask(
                                            Rectangle()
                                                .frame(width: width / 1.6, height: height)
                                                .offset(x: -width / 4)
                                        )

                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("NEW")
                                            .font(.caption)
                                            .bold()
                                            .padding(5)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text(show.title)
                                            .font(.callout)
                                            .foregroundColor(.white)
                                        
                                        Text("Vote average: \(String(format: "%.1f", show.voteAverage))")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                        
                                        NavigationLink(value: show) {
                                            Text("Show Details")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .padding(6)
                                                .background(Color.cyan)
                                                .cornerRadius(10)
                                        }
                                    }
                                    .padding(.leading, 10)
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                },
                                alignment: .leading
                            )
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.gray // Fallback for missing image
                        .frame(width: width, height: height)
                        .cornerRadius(18)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(radius: 10)
        }
        .frame(width: 250, height: 150)
    }

}


//import SwiftUI
//
//struct CarouselContentView: View {
//    var body: some View {
//        ZStack {
//            CarouselView(views: getChildViews())
//        }
//        .ignoresSafeArea()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .preferredColorScheme(.dark)
//    }
//    func getChildViews() -> [CarouselViewChild] {
//        var tempViews: [CarouselViewChild] = []
//        
//        for i in (1...3) {
//            tempViews.append(CarouselViewChild(id: i, content: {
//                ZStack {
//                    GeometryReader { geometry in
//                        let width = geometry.size.width
//                        let height = geometry.size.height
//                        
//                        Image("random\(i)")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: width, height: height)
//                            .cornerRadius(18)
//                            .overlay(
//                                ZStack(alignment: .leading) {
//                               
//                                    Image("random\(i)")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: width, height: height)
//                                        .blur(radius: 10)
//                                        .mask(
//                                            Rectangle()
//                                                .frame(width: width / 2, height: height)
//                                                .offset(x: -width / 4)
//                                        )
//                                        .clipped()
//                                    
//                                    VStack(alignment: .leading, spacing: 5) {
//                                        Button(action: {
//                                        }) {
//                                            Text("New")
//                                                
//                                                .font(.caption)
//                                                  .foregroundColor(.black)
//                                                  .padding(5)
//                                                  .background(Color.white)
//                                                  .cornerRadius(10)
//                                        }
//                                        .padding(.leading, 10)
//                                       
//                                        
//                                        Text("Movie Title")
//                                            .font(.headline)
//                                            .foregroundColor(.white)
//                                            .padding(.leading, 10)
//                                        Text("Vote average: 7.0")
//                                            .foregroundColor(.white)
//                                            .font(.caption)
//                                            .padding(.leading, 10)
//                                        Text("Horror")
//                                            .foregroundColor(.white)
//                                            .font(.caption)
//                                            .padding(.leading, 10)
//                                        Button(action: {
//                                        }) {
//                                            Text("Movie Details")
//                                                .font(.caption)
//                                                .foregroundColor(.white)
//                                                .padding(6)
//                                                .background(Color.red)
//                                                .cornerRadius(10)
//                                            
//                                        }
//                                        .padding(.leading, 10)
//                                        .padding(.vertical, 8)
//                                    }
//                                    
//                                },
//                                alignment: .leading
//                            )
//                            .mask(
//                                RoundedRectangle(cornerRadius: 18)
//                                    .frame(width: width, height: height)
//                            )
//                    }
//                }
//                .frame(width: 250, height: 150)
//                .shadow(radius: 10)
//            }))
//        }
//        return tempViews
//    }
//
//
//
//    
//    
//}
//
//#Preview {
//    CarouselContentView()
//}
