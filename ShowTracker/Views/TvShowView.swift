import SwiftUI


struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedGenre: TvShowListTarget? = nil
    @State private var searchText: String = ""

    private var airingTodayShows: [TvShow] {
        return viewModel.genreTvShows[.airingToday(page: 1)] ?? []
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    CarouselContentView(shows: airingTodayShows)
                    CustomGenrePicker(selectedGenre: $selectedGenre)
                    
                    if searchText.isEmpty {
                        LazyVStack(spacing: 20) {
                            if let genre = selectedGenre {
                                let showsBySubGenre = viewModel.tvShowsBySubGenres(for: genre)
                                
                                ForEach(showsBySubGenre.keys.sorted(by: { $0.name < $1.name }), id: \.self) { subGenre in
                                    if let tvShows = showsBySubGenre[subGenre], !tvShows.isEmpty {
                                        DashboardRow(title: subGenre.name, tvShows: tvShows, listType: genre, viewModel: viewModel)
                                    }
                                }
                            } else {
                                ForEach(TvShowListTarget.allCases, id: \.self) { genre in
                                    if let tvShows = viewModel.filteredTvShows(for: genre, with: searchText) {
                                        DashboardRow(title: genre.title, tvShows: tvShows, listType: genre, viewModel: viewModel)
                                    } else {
                                        Text("No data available for \(genre.title)")
                                    }
                                }
                            }
                        }
                        .padding()
                        .preferredColorScheme(.dark)
                    } else {
                        let filteredShows = viewModel.filteredTvShows(for: searchText)
                        GridDisplay(title: "Search Results", tvShows: filteredShows)
                    }
                }
            }
            .navigationTitle("ShowSeeker")
            .searchable(text: $searchText, prompt: "Search for a TV show")
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
            viewModel.loadGenres()
        } else {
            viewModel.loadTvShows(listType: .airingToday(page: 1))
            viewModel.loadAllGenres()
        }
    }
}


struct TvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        let networkManager = NetworkManager<TvShowListTarget>()
        let tvShowService = TvShowListService(networkManager: networkManager)
        let subgenreService = SubGenreTypesService(networkManager: networkManager)
        let viewModel = TvShowListViewModel(tvService: tvShowService, genreService: subgenreService)
        
        return TvShowView(viewModel: viewModel)
    }
}
