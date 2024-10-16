import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedGenre: TvShowListTarget? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Carousel for "Airing Today"
                    CarouselContentView(shows: viewModel.genreTvShows[.airingToday(page: 1)] ?? [])

                    // Custom Genre Picker
                    CustomGenrePicker(selectedGenre: $selectedGenre)

                    if viewModel.searchText.isEmpty {
                        // Display TV Shows based on selected or all genres
                        LazyVStack(spacing: 20) {
                            if let genre = selectedGenre {
                                let showsBySubGenre = viewModel.tvShowsBySubGenres(for: genre)
                                ForEach(showsBySubGenre.keys.sorted(by: { $0.name < $1.name }), id: \.self) { subGenre in
                                    if let tvShows = showsBySubGenre[subGenre], !tvShows.isEmpty {
                                        DashboardRow(
                                            title: subGenre.name,
                                            tvShows: tvShows,
                                            listType: genre,
                                            viewModel: viewModel
                                        )
                                        .id(subGenre.id) // Ensure the row identity stays intact
                                    }
                                }
                            } else {
                                ForEach(TvShowListTarget.allCases, id: \.self) { genre in
                                    if let tvShows = viewModel.filteredTvShows(for: genre, with: viewModel.searchText) {
                                        DashboardRow(
                                            title: genre.title,
                                            tvShows: tvShows,
                                            listType: genre,
                                            viewModel: viewModel
                                        )
                                        .id(genre.title) // Ensure unique identity for each row
                                    }
                                }
                            }
                        }

                        .padding()
                    } else {
                        // Display search results
                        GridDisplay(title: "Search Results", tvShows: viewModel.retrievedShows)
                    }
                }
            }
            .navigationTitle("ShowSeeker")
            .searchable(text: $viewModel.searchText, prompt: "Search for a TV show")
            .onAppear { loadTvShows() }
            .onChange(of: selectedGenre) { _ in loadTvShows() }
        }
    }

    private func loadTvShows() {
        if let genre = selectedGenre {
            viewModel.loadTvShows(listType: genre)
            viewModel.loadGenres()
        } else {
            // Load all genres when no specific genre is selected
            viewModel.loadAllGenres()
        }
    }
}
