//
//  AuthenticationService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import Foundation
import Moya

protocol AuthenticationServiceProtocol {
    func getRequestToken(completion: @escaping (Result<String, Error>) -> Void)
    func createSession(requestToken: String, completion: @escaping (Result<String, Error>) -> Void)
}

class AuthenticationService: AuthenticationServiceProtocol {
    private let networkManager: NetworkManager<AuthenticationTarget>
    
    init(networkManager: NetworkManager<AuthenticationTarget>) {
        self.networkManager = networkManager
    }
    
    func getRequestToken(completion: @escaping (Result<String, Error>) -> Void) {
        networkManager.request(target: .requestToken) { (result: Result<RequestTokenResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.requestToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createSession(requestToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        networkManager.request(target: .createSession(requestToken: requestToken)) { (result: Result<SessionResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.sessionID))
            case .failure(let error):
                if let moyaError = error as? MoyaError, case let .underlying(_, response) = moyaError,
                   let response = response,
                   let responseBody = try? response.mapString() {
                    print("Response Body: \(responseBody)")
                }
                print("Failed to create session: \(error.localizedDescription)")

            }
        }
    }
}

