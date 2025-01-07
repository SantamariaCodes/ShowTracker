import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowViewModel
    @State private var selectedGenre: TvShowTarget? = nil

    private var airingTodayShows: [TvShow] {
        return viewModel.genreTvShows[.airingToday(page: 1)] ?? []
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    CarouselContentView(shows: airingTodayShows)
                    CustomGenrePickerView(selectedGenre: $selectedGenre)
                    
                    if viewModel.searchText.isEmpty {
                        LazyVStack(spacing: 20) {
                            if let genre = selectedGenre {
                                let showsBySubGenre = viewModel.tvShowsBySubGenres(for: genre)
                                
                                ForEach(showsBySubGenre.keys.sorted(by: { $0.name < $1.name }), id: \.self) { subGenre in
                                    if let tvShows = showsBySubGenre[subGenre], !tvShows.isEmpty {
                                        DashboardRowView(title: subGenre.name, tvShows: tvShows, listType: genre) { listType in
                                            viewModel.loadMoreShows(listType: listType)
                                        }
                                    }
                                }
                            } else {
                                ForEach(TvShowTarget.allCases, id: \.self) { genre in
                                    if let tvShows = viewModel.filteredTvShows(for: genre, with: viewModel.searchText) {
                                        DashboardRowView(title: genre.title, tvShows: tvShows, listType: genre) { listType in
                                            viewModel.loadMoreShows(listType: listType)
                                        }
                                    } else {
                                        Text("No data available for \(genre.title)")
                                    }
                                }
                            }
                        }
                        .padding()
                        .preferredColorScheme(.dark)
                    } else {
                        GridDisplayView(title: "Search Results", tvShows: viewModel.retrievedShows)
                    }
                }
            }
            .navigationTitle("ShowSeeker")
            .searchable(text: $viewModel.searchText, prompt: "Search for a TV show")
        }
        .onAppear {
            loadTvShows()
        }
        .onChange(of: selectedGenre) { _, _ in
            loadTvShows()
        }
    }

    private func loadTvShows() {
        if let genre = selectedGenre {
            viewModel.loadTvShows(listType: genre)
            print("chibi test: \(genre)")
            viewModel.loadGenres()
        } else {
            viewModel.loadTvShows(listType: .airingToday(page: 1))
            viewModel.loadAllGenres()
        }
    }
}

struct TvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        let networkManager = NetworkManager<TvShowTarget>()
        let searchNetworkManager = NetworkManager<SearchShowTarget>()
        let tvShowService = TvShowService(networkManager: networkManager, searchNetworkManager: searchNetworkManager)
        let subgenreService = SubGenreTypesService(networkManager: networkManager)
        let viewModel = TvShowViewModel(tvService: tvShowService, genreService: subgenreService)
        
        return TvShowView(viewModel: viewModel)
    }
}
