//
//  TvShowListViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//

import Foundation

class TvShowListViewModel: ObservableObject {
    @Published var tvShows: [TvShow] = []
    private let tvService: TvShowListServiceProtocol

    init(tvService: TvShowListServiceProtocol) {
        self.tvService = tvService
    }
    func loadTvShows(listType: TvShowListTarget) {
        tvService.fetchListOfTvShows(listType: listType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tvShows):
                    self?.tvShows = tvShows
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
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

