//
//  GenreService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/8/24.
//

import Foundation

protocol GenreServiceProtocol {
    func fetchGenres(listType: TvShowListTarget, completion: @escaping (Result<[Genres], Error>) -> Void)
}

class GenreService: GenreServiceProtocol {
    private var networkManager: NetworkManager<TvShowListTarget>
    
    init(networkManager: NetworkManager<TvShowListTarget>) {
        self.networkManager = networkManager
    }
    
    func fetchGenres(listType: TvShowListTarget, completion: @escaping (Result<[Genres], Error>) -> Void) {
        networkManager.request(target: listType) { (result: Result<listOfGenres, Error>) in
            switch result {
            case .success(let tvListResponse):
                completion(.success(tvListResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
