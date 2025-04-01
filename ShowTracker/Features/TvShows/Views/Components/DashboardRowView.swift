import SwiftUI

struct DashboardRowView: View {
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
                    ForEach(tvShows, id: \.self) { tvShow in
                        NavigationLink(value: tvShow) {
                            tvShowBanner(tvShow: tvShow)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onAppear {
                            if tvShows.firstIndex(of: tvShow) == tvShows.count - threshold && !isLoadingMore {
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
    
    private func loadMoreIfNeeded() {
        if !isLoadingMore {
            isLoadingMore = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let currentPage = (viewModel.genreTvShows[listType.withUpdatedPage(1)]?.count ?? 0) / 20 + 1
                print("Loading page \(currentPage + 1) for \(listType)")
                viewModel.loadMoreShows(listType: listType.withUpdatedPage(currentPage + 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLoadingMore = false
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

}


