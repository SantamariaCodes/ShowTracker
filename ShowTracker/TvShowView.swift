import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedListType: TvShowListTarget = .topRated

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CustomGenrePicker(
                        selectedGenre: $selectedListType,
                        genres: [.popular, .airingToday, .onTheAir, .topRated]
                    )

                    VStack(spacing: 20) {
                        DashboardRow(title: titleFor(selectedListType), tvShows: viewModel.tvShows)
                    }
                    .padding()
                    .preferredColorScheme(.dark)
                }
            }
        }
        .onAppear {
            viewModel.loadTvShows(listType: selectedListType)
        }
        .onChange(of: selectedListType) { oldValue, newValue in
            viewModel.loadTvShows(listType: newValue)
        }

    }
}

struct TvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TvShowView(viewModel: TvShowListViewModel(tvService: TvShowListService(networkManager: NetworkManager<TvShowListTarget>())))
    }
}
