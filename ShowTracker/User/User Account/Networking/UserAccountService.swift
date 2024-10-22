//
//  UserAccountService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation

protocol UserAccountServiceProtocol {
    func getAccountDetails(sessionID: String, completion: @escaping (Result<AccountDetailsModel, Error>) -> Void)
    func getFavorites(accountID: String, sessionID: String, page: Int, completion: @escaping (Result<FavoritesModel, Error>) -> Void)
}


class UserAccountService: UserAccountServiceProtocol {
    private let networkManager: NetworkManager<UserAccountTarget>
    
    init(networkManager: NetworkManager<UserAccountTarget>) {
        self.networkManager = networkManager
    }
    
    func getAccountDetails(sessionID: String, completion: @escaping (Result<AccountDetailsModel, any Error>) -> Void) {
        networkManager.request(target: .getAccountDetails(sessionID: sessionID)) { (result: Result<AccountDetailsModel, Error>) in
            switch result {
            case .success(let accountDetails):
                completion(.success(accountDetails))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
    
    
    func getFavorites(accountID: String, sessionID: String, page: Int, completion: @escaping (Result<FavoritesModel, Error>) -> Void) {
        networkManager.request(target: .getFavorites(accountID: accountID, sessionID: sessionID, page: page)) { (result: Result<FavoritesModel, Error>) in
            switch result {
            case .success(let favoritesModel):
                completion(.success(favoritesModel))
            case .failure(let error):
                print("Failed to get favorites: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    
    
    
    
}
