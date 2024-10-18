//
//  SearchService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 8/10/24.
//

//import Foundation
//
//protocol SearchShowServiceProtocol {
//    func searchTvShow(showName: String, completion: @escaping (Result<[TvShow], Error>) -> Void)
//}
//
//class SearchShowService: SearchShowServiceProtocol {
//    private let networkManager: NetworkManager<SearchShowTarget>
//    
//    init(networkManager: NetworkManager<SearchShowTarget>) {
//        self.networkManager = networkManager
//    }
//    func searchTvShow(showName: String, completion: @escaping (Result<[TvShow], Error>) -> Void) {
//        networkManager.request(target: .searchTvShow(showName: showName)) { (result: Result<ListOfTvShowsResponse, Error>) in
//            switch result {
//            case .success(let response):
//                completion(.success(response.results))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    
//}
