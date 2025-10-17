//
//  AccountService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 9/10/25.
//

import Foundation

protocol AccountServiceProtocol {
    func modifyFavorite(
        request: ModifyFavoriteRequest,
        completion: @escaping (Result<ModifyFavoriteResponse, Error>) -> Void
    )
}

class AccountService: AccountServiceProtocol {
    
    private let networkManager: NetworkManager<AccountTarget>
    private let keychainManager = KeychainManager()
    
    init(networkManager: NetworkManager<AccountTarget>) {
        self.networkManager = networkManager
    }
    
    func modifyFavorite(
        request: ModifyFavoriteRequest,
        completion: @escaping (Result<ModifyFavoriteResponse, Error>) -> Void
    ) {
        guard
            let accountId = keychainManager.getAccountID(),
            let sessionId = keychainManager.getSessionID()
        else {
            completion(.failure(NSError(
                domain: "AccountService",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "Missing accountId or sessionId in Keychain"]
            )))
            return
        }
        
        let target = AccountTarget.modifyFavorite(
            request: request,
            accountId: accountId,
            sessionId: sessionId
        )
        
        networkManager.request(target: target) { (result: Result<ModifyFavoriteResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
