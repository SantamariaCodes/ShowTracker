import SwiftUI

struct FavoritesGridDisplayView: View {
    let title: String
    let tvShows: [TvShow]
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(tvShows) { tvShow in
                    NavigationLink(destination: ShowDetailView(viewModel: TvShowDetailViewModel(tvShowId: tvShow.id, tvShowDetailsService: TvShowDetailsService(networkManager: NetworkManager<TvShowTarget>())))) {
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
                // Append a dummy query parameter to force AsyncImage to refresh the image.
                let refreshedURLString = "\(posterURL.absoluteString)?refresh=\(UUID().uuidString)"
                if let refreshedURL = URL(string: refreshedURLString) {
                    AsyncImage(url: refreshedURL) { image in
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
                        .frame(width: 120, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            } else {
                Color.gray
                    .frame(width: 120, height: 150)
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
