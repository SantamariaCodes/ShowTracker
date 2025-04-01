
import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowViewModel
    @Binding var path: NavigationPath
    @State private var selectedGenre: TvShowTarget? = nil

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Example: Carousel at the top (adjust as needed)
                    
                    CarouselContentView(shows: viewModel.genreTvShows[.airingToday(page: 1)] ?? [])
                    
                    CustomGenrePickerView(selectedGenre: $selectedGenre)
                    
                    if viewModel.searchText.isEmpty {
                        LazyVStack(spacing: 20) {
                            if let genre = selectedGenre {
                                let showsBySubGenre = viewModel.tvShowsBySubGenres(for: genre)
                                ForEach(showsBySubGenre.keys.sorted(by: { $0.name < $1.name }), id: \.self) { subGenre in
                                    if let tvShows = showsBySubGenre[subGenre], !tvShows.isEmpty {
                                        DashboardRowView(title: subGenre.name, tvShows: tvShows, listType: genre, viewModel: viewModel)
                                    }
                                }
                            } else {
                                ForEach(TvShowTarget.allCases, id: \.self) { genre in
                                    if let tvShows = viewModel.filteredTvShows(for: genre, with: viewModel.searchText) {
                                        DashboardRowView(title: genre.title, tvShows: tvShows, listType: genre, viewModel: viewModel)
                                    } else {
                                        Text("No data available for \(genre.title)")
                                    }
                                }
                            }
                        }
                        .padding()
                    } else {
                        GridDisplayView(title: "Search Results", tvShows: viewModel.retrievedShows)
                    }
                }
            }
            .navigationTitle("ShowSeeker")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search for a TV show")
            .onAppear {
                loadTvShows()
            }
            .onChange(of: selectedGenre) { _, _ in
                loadTvShows()
            }
            // Define a navigation destination for TvShow.
            .navigationDestination(for: TvShow.self) { tvShow in
                ShowDetailView(viewModel: TvShowDetailViewModel(
                    tvShowId: tvShow.id,
                    tvShowDetailsService: TvShowDetailsService(networkManager: NetworkManager<TvShowTarget>())
                ))
            }
        }
    }

    private func loadTvShows() {
        if let genre = selectedGenre {
            viewModel.loadTvShows(listType: genre)
            viewModel.loadGenres()
        } else {
            viewModel.loadTvShows(listType: .airingToday(page: 1))
            viewModel.loadAllGenres()
        }
    }
}
