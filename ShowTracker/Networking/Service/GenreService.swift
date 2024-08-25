//
//  GenreService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/8/24.
//

import Foundation

protocol SubGenreServiceProtocol {
    func fetchGenres(listType: TvShowListTarget, completion: @escaping (Result<[SubGenres], Error>) -> Void)
}

class SubGenreTypesService: SubGenreServiceProtocol {
    private var networkManager: NetworkManager<TvShowListTarget>
    
    init(networkManager: NetworkManager<TvShowListTarget>) {
        self.networkManager = networkManager
    }
    
    func fetchGenres(listType: TvShowListTarget, completion: @escaping (Result<[SubGenres], Error>) -> Void) {
        networkManager.request(target: listType) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                print("Raw Data:", String(data: data, encoding: .utf8) ?? "Failed to decode data")
                // Attempt to decode the JSON
                do {
                    let subGenreResponse = try JSONDecoder().decode(listOfSubGenres.self, from: data)
                    completion(.success(subGenreResponse.genres)) // Use "genres" array from decoded object
                } catch {
                    print("Decoding error:", error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Network error:", error)
                completion(.failure(error))
            }
        }
    }



}

