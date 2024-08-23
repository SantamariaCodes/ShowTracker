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
        }
    }
    
}



extension TvShowListViewModel {
    static func make() -> TvShowListViewModel {
    
        let tvShowNetworkManager = NetworkManager<TvShowListTarget>()
        let tvShowService = TvShowListService(networkManager: tvShowNetworkManager)
      return TvShowListViewModel(tvService: tvShowService)
    }
}
