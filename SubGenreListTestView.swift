import SwiftUI

struct SubGenreListTestView: View {
    @StateObject private var viewModel = TvShowListViewModel.make()

    var body: some View {
        VStack {
            Text("SubGenres List")
                .font(.largeTitle)
                .padding()

            // Display list of subgenres
            if let subGenres = viewModel.genres, !subGenres.isEmpty {
                List(subGenres) { subGenre in
                    Text(subGenre.name)
                }
            } else {
                Text("No SubGenres Loaded")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            print("thisline")
            viewModel.loadGenres()
            print("otherLine")
        }
        .padding()
    }
}

struct SubGenreListTestView_Previews: PreviewProvider {
    static var previews: some View {
        SubGenreListTestView()
    }
}
