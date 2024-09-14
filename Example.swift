//import Foundation
//
//class TvShowListViewModel: ObservableObject {
//    @Published var genreTvShows: [TvShowListTarget: [TvShow]] = [:]
//    private var currentPage: [TvShowListTarget: Int] = [:] // Track the current page for each genre
//    @Published var genres: [Genre]? // Changed from subGenres to genres
//
//    private let tvService: TvShowListService
//    private let genreService: SubGenreTypesService
//    
//    init(tvService: TvShowListService, genreService: SubGenreTypesService) {
//        self.tvService = tvService
//        self.genreService = genreService
//    }
//
//    func loadTvShows(listType: TvShowListTarget, append: Bool = false) {
//        let nextPage = (currentPage[listType] ?? 2)
//        tvService.fetchListOfTvShows(listType: listType) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let shows):
//                    if append {
//                        // Append new data to the existing list
//                        self.genreTvShows[listType, default: []] += shows
//                    } else {
//                        // Replace the current data
//                        self.genreTvShows[listType] = shows
//                    }
//                    self.currentPage[listType] = nextPage
//                case .failure(let error):
//                    print("Error loading shows: \(error)")
//                }
//            }
//        }
//    }
//
//    // Function to load more shows when pagination is triggered
//    func loadMoreTvShows(listType: TvShowListTarget) {
//        // Increment the page number for this listType
//        let nextPage = (currentPage[listType] ?? 2) + 2
//        let newTarget = updateTargetWithPage(listType, page: nextPage)
//        
//        // Fetch the next page and append it to the existing results
//        loadTvShows(listType: newTarget, append: true)
//    }
//
//    // Helper function to update the target with the new page number
//    private func updateTargetWithPage(_ target: TvShowListTarget, page: Int) -> TvShowListTarget {
//        switch target {
//        case .popular:
//            return .popular(page: page)
//        case .airingToday:
//            return .airingToday(page: page)
//        case .onTheAir:
//            return .onTheAir(page: page)
//        case .topRated:
//            return .topRated(page: page)
//        default:
//            return target
//        }
//    }
//
//    // Load all genres as before
//    func loadAllGenres() {
//        let group = DispatchGroup()
//        
//        for genre in TvShowListTarget.allCases {
//            group.enter()
//            tvService.fetchListOfTvShows(listType: genre) { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let shows):
//                        self.genreTvShows[genre] = shows
//                    case .failure(let error):
//                        print("Error loading shows for genre \(genre): \(error)")
//                    }
//                    group.leave()
//                }
//            }
//        }
//        
//        group.notify(queue: .main) {
//            // All genres are loaded
//        }
//    }
//    
//    // Load genres as before
//    func loadGenres() {
//        genreService.fetchGenres(listType: .retrieveSubGenreList) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let genres):
//                    self?.genres = genres
//                case .failure(let error):
//                    print("Error loading genres: \(error)")
//                }
//            }
//        }
//    }
//
//    // Existing method to filter TV shows by sub-genres
//    func tvShowsBySubGenres(for genre: TvShowListTarget) -> [Genre: [TvShow]] {
//        var tvShowsBySubGenre: [Genre: [TvShow]] = [:]
//        
//        guard let tvShows = genreTvShows[genre], let genres = genres else {
//            return tvShowsBySubGenre
//        }
//        
//        for genre in genres {
//            let filteredShows = tvShows.filter { $0.genreId.contains(genre.id) }
//            tvShowsBySubGenre[genre] = filteredShows
//        }
//        
//        return tvShowsBySubGenre
//    }
//
//    // Filtered TV shows based on search text
//    func filteredTvShows(for genre: TvShowListTarget, with searchText: String) -> [TvShow]? {
//        guard let tvShows = genreTvShows[genre] else {
//            return nil
//        }
//        
//        if searchText.isEmpty {
//            return tvShows
//        } else {
//            return tvShows.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//
//    // General search function across all TV shows
//    func filteredTvShows(for searchText: String) -> [TvShow] {
//        return genreTvShows.values.flatMap { $0 }.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//    }
//}
//extension TvShowListViewModel {
//    static func make() -> TvShowListViewModel {
//        let tvShowNetworkManager = NetworkManager<TvShowListTarget>()
//        let tvShowService = TvShowListService(networkManager: tvShowNetworkManager)
//        let genreService = SubGenreTypesService(networkManager: tvShowNetworkManager)
//        return TvShowListViewModel(tvService: tvShowService, genreService: genreService)
//    }
//}
