import SwiftUI

struct DashboardRowView: View {
    let title: String
    let tvShows: [TvShow]
    let listType: TvShowTarget
    @ObservedObject var viewModel: TvShowViewModel
    @State private var isLoadingMore = false
    let threshold = 2

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading)
                .fontWeight(.bold)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(tvShows.indices, id: \.self) { index in
                        let tvShow = tvShows[index]

                        NavigationLink(value: tvShow) {
                            tvShowBanner(tvShow: tvShow)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .onChange(of: geo.frame(in: .global).minX) { _ in
                                                detectIfEndItemVisible(index: index, geo: geo)
                                            }
                                    }
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    if isLoadingMore {
                        ProgressView()
                            .padding()
                            .frame(width: 130, height: 150)
                    }
                }
                
                .onAppear {
                    if tvShows.count < 5 && !isLoadingMore {
                        loadMoreIfNeeded()
                    }

                    // Fallback in case last item never triggers
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if !isLoadingMore && tvShows.count % 20 == 0 {
                            print("Retrying load as a fallback.")
                            loadMoreIfNeeded()
                        }
                    }
                }
            }
        }
    }

    private func detectIfEndItemVisible(index: Int, geo: GeometryProxy) {
        let screenWidth = UIScreen.main.bounds.width
        let frame = geo.frame(in: .global)

        if index == tvShows.count - threshold &&
            frame.minX < screenWidth &&
            frame.maxX > 0 &&
            !isLoadingMore {
            print("Detected last visible item via GeometryReader.")
            loadMoreIfNeeded()
        }
    }

    private func loadMoreIfNeeded() {
        if !isLoadingMore {
            isLoadingMore = true

            let storageKey = listType.withUpdatedPage(1)
            let currentCount = viewModel.genreTvShows[storageKey]?.count ?? 0
            let currentPage = currentCount / 20 + 1

            print("Loading page \(currentPage + 1) for \(listType)")
            viewModel.loadMoreShows(listType: listType.withUpdatedPage(currentPage + 1))

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isLoadingMore = false
            }
        }
    }

    private func tvShowBanner(tvShow: TvShow) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .frame(width: 130, height: 150)
                    .shadow(color: .black, radius: 3)

                if let posterURL = tvShow.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 150)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Color.gray
                        .frame(width: 130, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Text(tvShow.title)
                .lineLimit(1)
                .frame(width: 90)
        }
        .padding(3)
    }
}
