//
//  TvShowDetailsViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 21/2/24.
//

import Foundation

class TvShowDetailViewModel: ObservableObject {
    @Published var tvShowDetail: TvShowDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let tvShowDetailsService: TvShowDetailsService
    private let tvShowId: Int

    init(tvShowId: Int, tvShowDetailsService: TvShowDetailsService) {
        self.tvShowId = tvShowId
        self.tvShowDetailsService = tvShowDetailsService
    }

    func fetchTvShowDetails() {
        isLoading = true
        tvShowDetailsService.fetchTvShowDetails(tvShowId: tvShowId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let details):
                    self?.tvShowDetail = details
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
