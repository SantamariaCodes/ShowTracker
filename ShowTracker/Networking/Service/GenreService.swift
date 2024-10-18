//
//  GenreService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/8/24.
//


import Foundation

protocol SubGenreServiceProtocol {
    func fetchGenres(listType: TvShowTarget, completion: @escaping (Result<[Genre], Error>) -> Void)
}

class SubGenreTypesService: SubGenreServiceProtocol {
    private var networkManager: NetworkManager<TvShowTarget>
    
    init(networkManager: NetworkManager<TvShowTarget>) {
        self.networkManager = networkManager
    }
    
    func fetchGenres(listType: TvShowTarget, completion: @escaping (Result<[Genre], Error>) -> Void) {
        networkManager.request(target: listType) { (result: Result<GenreListResponse, Error>) in
            switch result {
            case .success(let genreResponse):
                completion(.success(genreResponse.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }






}

