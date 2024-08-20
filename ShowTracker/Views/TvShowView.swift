import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedGenre: TvShowListTarget?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CustomGenrePicker(selectedGenre: $selectedGenre)

                    VStack(spacing: 20) {
                        if let genre = selectedGenre {
                            // Display shows for the selected genre
                            DashboardRow(title: genre.title, tvShows: viewModel.tvShows)
                        } else {
                            // Handle "All" by combining results from all genres
                            ForEach(TvShowListTarget.allCases, id: \.self) { genre in
                                DashboardRow(title: genre.title, tvShows: viewModel.tvShows)
                            }
                        }
                    }
                    .padding()
                    .preferredColorScheme(.dark)
                }
            }
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
        } else {
            // Load or combine data for all genres here
           // viewModel.loadAllGenres()
        }
    }
}

struct TvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TvShowView(viewModel: TvShowListViewModel(tvService: TvShowListService(networkManager: NetworkManager<TvShowListTarget>())))
    }
}
