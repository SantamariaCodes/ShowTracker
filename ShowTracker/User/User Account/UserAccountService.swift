//
//  UserAccountService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation

protocol UserAccountServiceProtocol {
    //problablemente el result no sea un string sino un objeto que todavia no hemos creado
    func getAccountDetails(sessionID: String, completion: @escaping (Result<AccountDetails, Error>) -> Void)
}

class UserAccountService: UserAccountServiceProtocol {
  
    
    private let networkManager: NetworkManager<UserAccountTarget>
    
    init(networkManager: NetworkManager<UserAccountTarget>) {
        self.networkManager = networkManager
    }
    
    func getAccountDetails(sessionID: String, completion: @escaping (Result<AccountDetails, any Error>) -> Void) {
        networkManager.request(target: .getAccountDetails(sessionID: sessionID)) { (result: Result<AccountDetails, Error>) in
            switch result {
            case .success(let accountDetails):
                completion(.success(accountDetails))
                print("Account Details: \(accountDetails)")
            case .failure(let error):
                print("Failed to get account details: \(error.localizedDescription)")
                completion(.failure(error))

            }
        }

        
    }
    
}
