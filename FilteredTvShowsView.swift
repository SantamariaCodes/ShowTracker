import SwiftUI

struct FilteredTvShowsView: View {
    @StateObject private var viewModel = TvShowListViewModel.make()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Popular TV Shows by Genre")
                    .font(.largeTitle)
                    .padding()

                if let genres = viewModel.genres, !genres.isEmpty {
                    ForEach(genres, id: \.self) { genre in
                        if let filteredShows = viewModel.tvShowsBySubGenres(for: .popular)[genre], !filteredShows.isEmpty {
                            Text(genre.name)
                                .font(.headline)
                                .padding(.top)

                            ForEach(filteredShows, id: \.id) { tvShow in
                                Text(tvShow.title)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                } else {
                    Text("Loading genres...")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .onAppear {
                viewModel.loadGenres()
                viewModel.loadTvShows(listType: .popular)
            }
            .padding()
        }
    }
}

struct FilteredTvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTvShowsView()
    }
}
