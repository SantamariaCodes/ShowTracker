import SwiftUI

struct FilteredTvShowsView: View {
    @StateObject private var viewModel = TvShowListViewModel.make()
    @State private var selectedGenre: Genre?
    
    var body: some View {
        VStack {
            Text("Popular TV Shows by Genre")
                .font(.largeTitle)
                .padding()
            
            // Picker to select subgenre
            if let genres = viewModel.genres, !genres.isEmpty {
                Picker("Select Genre", selection: $selectedGenre) {
                    ForEach(genres, id: \.self) { genre in
                        Text(genre.name).tag(genre as Genre?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                // Display filtered TV shows
                if let selectedGenre = selectedGenre {
                    if let filteredShows = viewModel.tvShowsBySubGenres(for: .popular)[selectedGenre], !filteredShows.isEmpty {
                        List(filteredShows) { tvShow in
                            Text(tvShow.title)
                        }
                    } else {
                        Text("No TV shows available for \(selectedGenre.name)")
                            .foregroundColor(.red)
                            .padding()
                    }
                } else {
                    Text("Select a genre to see TV shows.")
                        .foregroundColor(.gray)
                        .padding()
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

struct FilteredTvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTvShowsView()
    }
}
