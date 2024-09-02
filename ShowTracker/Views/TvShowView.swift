import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedGenre: TvShowListTarget? = nil
    @State private var searchText: String = ""

    private var airingTodayShows: [TvShow] {
        return viewModel.genreTvShows[.airingToday] ?? []
    }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CarouselContentView(shows: airingTodayShows)
                    CustomGenrePicker(selectedGenre: $selectedGenre)
                    
                    if searchText.isEmpty {
                        VStack(spacing: 20) {
                            if let genre = selectedGenre {
                                // Directly use the non-optional dictionary returned by tvShowsBySubGenres(for:)
                                let showsBySubGenre = viewModel.tvShowsBySubGenres(for: genre)
                                
                                ForEach(showsBySubGenre.keys.sorted(by: { $0.name < $1.name }), id: \.self) { subGenre in
                                    if let tvShows = showsBySubGenre[subGenre], !tvShows.isEmpty {
                                      
                                        DashboardRow(title: subGenre.name, tvShows: tvShows)
                                    }
                                }
                            } else {
                                ForEach(TvShowListTarget.allCases, id: \.self) { genre in
                                    if let tvShows = viewModel.filteredTvShows(for: genre, with: searchText) {
                                        DashboardRow(title: genre.title, tvShows: tvShows)
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
        .onChange(of: selectedGenre) { oldValue, newValue in
            loadTvShows()
        }
    }
    
    private func loadTvShows() {
        if let genre = selectedGenre {
            viewModel.loadTvShows(listType: genre)
            viewModel.loadGenres()
        } else {
            viewModel.loadTvShows(listType: .airingToday)

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
