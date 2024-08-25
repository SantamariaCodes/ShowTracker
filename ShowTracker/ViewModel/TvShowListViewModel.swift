//
//  TvShowListViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.


import Foundation
class TvShowListViewModel: ObservableObject {
    @Published var genreTvShows: [TvShowListTarget: [TvShow]] = [:]
    private let tvService: TvShowListService

    init(tvService: TvShowListService) {
        self.tvService = tvService
    }

    func loadTvShows(listType: TvShowListTarget) {
        tvService.fetchListOfTvShows(listType: listType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self.genreTvShows[listType] = shows
                case .failure(let error):
                    print("Error loading shows: \(error)")
                }
            }
        }
    }

    func loadAllGenres() {
        let group = DispatchGroup()

        for genre in TvShowListTarget.allCases {
            group.enter()
            tvService.fetchListOfTvShows(listType: genre) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let shows):
                        self.genreTvShows[genre] = shows
                    case .failure(let error):
                        print("Error loading shows for genre \(genre): \(error)")
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            // All genres are loaded
        }
    }

    func filteredTvShows(for genre: TvShowListTarget, with searchText: String) -> [TvShow]? {
        guard let tvShows = genreTvShows[genre] else {
            return nil
        }

        if searchText.isEmpty {
            return tvShows
        } else {
            return tvShows.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func filteredTvShows(for searchText: String) -> [TvShow] {
        // Aggregate all TV shows across all genres and filter based on searchText
        return genreTvShows.values.flatMap { $0 }.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    
}




extension TvShowListViewModel {
    static func make() -> TvShowListViewModel {
    
        let tvShowNetworkManager = NetworkManager<TvShowListTarget>()
        let tvShowService = TvShowListService(networkManager: tvShowNetworkManager)
      return TvShowListViewModel(tvService: tvShowService)
    }
}
