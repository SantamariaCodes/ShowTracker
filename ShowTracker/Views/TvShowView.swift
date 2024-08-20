import SwiftUI

struct TvShowView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedListType: TvShowListTarget = .popular

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    CarouselContentView()
                    CustomGenrePicker(selectedGenre: $selectedListType)

                    VStack(spacing: 20) {
                        DashboardRow(title: selectedListType.title, tvShows: viewModel.tvShows)
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
