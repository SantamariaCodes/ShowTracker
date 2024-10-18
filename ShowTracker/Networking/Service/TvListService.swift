//
//  TvListService.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//

import Foundation

protocol TvShowServiceProtocol {
    func fetchListOfTvShows(listType: TvShowTarget, completion: @escaping (Result<[TvShow], Error>) -> Void)
    func searchTvShow(showName: String, completion: @escaping (Result<[TvShow], Error>) -> Void)
}

class TvShowService: TvShowServiceProtocol {
    private var networkManager: NetworkManager<TvShowTarget>
    private let searchNetworkManager: NetworkManager<SearchShowTarget>

    
    init(networkManager: NetworkManager<TvShowTarget>, searchNetworkManager: NetworkManager<SearchShowTarget>) {
        self.networkManager = networkManager
        self.searchNetworkManager = searchNetworkManager
    }
    
    func fetchListOfTvShows(listType: TvShowTarget, completion: @escaping (Result<[TvShow], Error>) -> Void) {
        networkManager.request(target: listType) { (result: Result<ListOfTvShowsResponse, Error>) in
            switch result {
            case .success(let tvListResponse):
                completion(.success(tvListResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchTvShow(showName: String, completion: @escaping (Result<[TvShow], Error>) -> Void) {
        searchNetworkManager.request(target: .searchTvShow(showName: showName)) { (result: Result<ListOfTvShowsResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
