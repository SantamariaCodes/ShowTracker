//import SwiftUI
//
//struct TvShowListViewModelTestView: View {
//    @StateObject private var viewModel = TvShowListViewModel.make()
//
//    var body: some View {
//        VStack {
//            Text("Popular TV Shows by SubGenres")
//                .font(.largeTitle)
//                .padding()
//
//            // Button to load popular TV shows
//            Button(action: {
//                viewModel.loadTvShows(listType: .popular)
//                viewModel.loadSubGenres()
//            }) {
//                Text("Load Popular TV Shows and SubGenres")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//
//            // Display TV shows for "Popular" genre, categorized by subgenres
//            if let subGenres = viewModel.subGenres {
//                List {
//                    ForEach(subGenres, id: \.id) { subGenre in
//                        Section(header: Text(subGenre.name)) {
//                            if let showsBySubGenre = viewModel.tvShowsBySubGenres(for: .popular)[subGenre], !showsBySubGenre.isEmpty {
//                                ForEach(showsBySubGenre) { tvShow in
//                                    Text(tvShow.title)
//                                }
//                            } else {
//                                Text("No shows available for \(subGenre.name)")
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//            } else {
//                Text("No SubGenres Loaded")
//            }
//        }
//        .onAppear {
//            viewModel.loadTvShows(listType: .popular)
//            viewModel.loadSubGenres()
//        }
//        .padding()
//    }
//}
//
//struct TvShowListViewModelTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TvShowListViewModelTestView()
//    }
//}
