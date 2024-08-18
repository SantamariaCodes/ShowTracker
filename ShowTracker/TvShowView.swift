import SwiftUI

struct TVShowsView: View {
    @StateObject var viewModel: TvShowListViewModel
    @State private var selectedListType: TvShowListTarget = .topRated

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select List Type", selection: $selectedListType) {
                    Text("Popular").tag(TvShowListTarget.popular)
                    Text("Airing Today").tag(TvShowListTarget.airingToday)
                    Text("On The Air").tag(TvShowListTarget.onTheAir)
                    Text("Top Rated").tag(TvShowListTarget.topRated)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(viewModel.tvShows, id: \.id) { tvShow in
                    NavigationLink(destination: TvShowDetailView(viewModel: TvShowDetailViewModel(tvShowId: tvShow.id, tvShowDetailsService: TvShowDetailsService(networkManager: NetworkManager<TvShowListTarget>())))) {
                        VStack(alignment: .leading) {
                            Text(tvShow.title)
                                .font(.headline)
                            Text(tvShow.overview)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarTitle("TV Shows")
            .onAppear {
                viewModel.loadTvShows(listType: selectedListType)
            }
            .onChange(of: selectedListType) { newValue in
                viewModel.loadTvShows(listType: newValue)
            }
        }
    }
}

// Example preview for TVShowsView
struct TVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsView(viewModel: TvShowListViewModel(tvService: TvShowListService(networkManager: NetworkManager<TvShowListTarget>())))
    }
}
