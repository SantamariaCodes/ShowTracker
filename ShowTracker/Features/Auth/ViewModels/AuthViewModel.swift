//  AuthViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import Foundation
import KeychainSwift

class AuthViewModel: ObservableObject {
    @Published var requestToken: String? = nil
    @Published var errorMessage: String? = nil
    @Published var sessionID: String? = nil

    let keychainManager = KeychainManager()
    
    private let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
        fetchRequestToken()
    }
    
    func fetchRequestToken() {
        authenticationService.getRequestToken { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    //future keychain
                    self?.requestToken = token
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch token: \(error.localizedDescription)"
                    print("AuthViewModel Error: Failed to fetch token - \(error.localizedDescription)")
                }
            }
        }
    }
    
    func createSession(requestToken: String) {
        authenticationService.createSession(requestToken: requestToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sessionID):
                    self?.keychainManager.saveSessionID(sessionID)
                case .failure(let error):
                    self?.errorMessage = "Failed to create session: \(error.localizedDescription)"
                    print("AuthViewModel Error: Failed to create session - \(error.localizedDescription)")
                }
            }
        }
    }
    func updateSessionID() {
        sessionID = "Contains"
    }

}

extension AuthViewModel {
    static func make() -> AuthViewModel {
        let AuthViewModelNetworkManager = NetworkManager<AuthenticationTarget>()
        let authViewModelService = AuthenticationService(networkManager: AuthViewModelNetworkManager)
        return AuthViewModel(authenticationService: authViewModelService)
    }
}
