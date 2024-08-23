
import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedGenre: TvShowListTarget? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CarouselContentView()
                    CustomGenrePicker(selectedGenre: $selectedGenre)

                    VStack(spacing: 20) {
                        if let genre = selectedGenre {
                            if let tvShows = viewModel.genreTvShows[genre] {
                                DashboardRow(title: genre.title, tvShows: tvShows)
                            } else {
                                Text("No data available for \(genre.title)")
                            }
                        } else {
                            ForEach(TvShowListTarget.allCases, id: \.self) { genre in
                                if let tvShows = viewModel.genreTvShows[genre] {
                                    DashboardRow(title: genre.title, tvShows: tvShows)
                                } else {
                                    Text("No data available for \(genre.title)")
                                }
                            }
                        }
                    }
                    .padding()
                    .preferredColorScheme(.dark)
                }
            }
            .navigationTitle("ShowSeeker")
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
            viewModel.loadAllGenres()
        }
    }
}

struct TvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TvShowView(viewModel: TvShowListViewModel(tvService: TvShowListService(networkManager: NetworkManager<TvShowListTarget>())))
    }
}

