//
//  TvListService.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//

import Foundation

protocol TvShowListServiceProtocol {
    func fetchListOfTvShows(listType: TvShowListTarget, completion: @escaping (Result<[TvShow], Error>) -> Void)
}

class TvShowListService: TvShowListServiceProtocol {
    private var networkManager: NetworkManager<TvShowListTarget>
    
    init(networkManager: NetworkManager<TvShowListTarget>) {
        self.networkManager = networkManager
    }
    
    func fetchListOfTvShows(listType: TvShowListTarget, completion: @escaping (Result<[TvShow], Error>) -> Void) {
        networkManager.request(target: listType) { (result: Result<ListOfTvShowsResponse, Error>) in
            switch result {
            case .success(let tvListResponse):
                completion(.success(tvListResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
