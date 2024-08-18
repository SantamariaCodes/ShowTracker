//
//  Movie&ShowDetails.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 21/2/24.
//


import Foundation

protocol TvShowDetailsProtocol {
    func fetchTvShowDetails(tvShowId: Int, completion: @escaping (Result<TvShowDetail, Error>) -> Void)
}

class TvShowDetailsService: TvShowDetailsProtocol {
    private var networkManager: NetworkManager<TvShowListTarget>
    
    init(networkManager: NetworkManager<TvShowListTarget>) {
        self.networkManager = networkManager
    }
    
    func fetchTvShowDetails(tvShowId: Int, completion: @escaping (Result<TvShowDetail, Error>) -> Void) {
        networkManager.request(target: .details(tvShowId: tvShowId)) { (result: Result<TvShowDetail, Error>) in
            switch result {
            case .success(let tvDetailsResponse):
                completion(.success(tvDetailsResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
