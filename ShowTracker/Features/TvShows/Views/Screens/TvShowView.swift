
import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowViewModel
    @Binding var path: NavigationPath

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    carouselAndGenrePickerSection
                
                    if viewModel.searchText.isEmpty {
                        dashboardRowsSection
                    } else {
                        GridDisplayView(title: "Search Results", tvShows: viewModel.retrievedShows)
                    }
                }
            }
            .navigationTitle("ShowTracker")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search for a TV show")
            .onAppear {
                loadTvShows()
            }
            .onChange(of: viewModel.selectedList) { _, _ in
                loadTvShows()
            }
            .navigationDestination(for: TvShow.self) { tvShow in
                ShowDetailView(viewModel: TvShowDetailViewModel(
                    tvShowId: tvShow.id,
                    tvShowDetailsService: TvShowDetailsService(networkManager: NetworkManager<TvShowTarget>())
                ))
            }
        }
    }
    
    private var carouselAndGenrePickerSection: some View {
        VStack {
            CarouselContentView(shows: viewModel.genreTvShows[.airingToday(page: 1)] ?? [])
            CustomGenrePickerView(selectedGenre: $viewModel.selectedList)
        }
    }
    
    private var dashboardRowsSection: some View {
        LazyVStack(spacing: 20) {
            if let list = viewModel.selectedList {
                ForEach(viewModel.subgenreRows, id: \.subgenre) { row in
                    SubGenreRowView(viewModel: SubGenreRowViewModel.make(tvShowTarget: list, subGenre: row.subgenre))
                }
            } else {
                ForEach(viewModel.allRows, id: \.genre) { row in
                    if row.shows.isEmpty {
                        Text("No data for \(row.genre.title)")
                    } else {
                        DashboardRowView(
                            title: row.genre.title,
                            tvShows: row.shows,
                            listType: row.genre,
                            viewModel: viewModel
                        )
                    }
                }
            }

            PersonalBannerView()
        }
        .padding()
    }




    private func loadTvShows() {
        if let genre = viewModel.selectedList {
            viewModel.loadTvShows(listType: genre)
            viewModel.loadGenres()
        } else {
            viewModel.loadTvShows(listType: .airingToday(page: 1))
            viewModel.loadAllGenres()
        }
    }
}

