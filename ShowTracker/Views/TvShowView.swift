import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedGenre: TvShowListTarget? = nil
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CarouselContentView()
                    CustomGenrePicker(selectedGenre: $selectedGenre)
                    
                    if searchText.isEmpty {
                        VStack(spacing: 20) {
                            if let genre = selectedGenre {
                                if let tvShows = viewModel.filteredTvShows(for: genre, with: searchText) {
                                    DashboardRow(title: genre.title, tvShows: tvShows)
                                } else {
                                    Text("No data available for \(genre.title)")
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
        .onChange(of: selectedGenre) {  oldValue, newValue in
            loadTvShows()
        }
    }
    
    private func loadTvShows() {
        if let genre = selectedGenre {
            viewModel.loadTvShows(listType: genre)
        } else {
            viewModel.loadAllGenres()
        }
    }
}

struct TvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TvShowView(viewModel: TvShowListViewModel(tvService: TvShowListService(networkManager: NetworkManager<TvShowListTarget>())))
    }
}
