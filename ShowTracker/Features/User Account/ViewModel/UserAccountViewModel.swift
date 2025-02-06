//
//  UserAccountViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation
import KeychainSwift

class UserAccountViewModel: ObservableObject {
    @Published var accountDetails: AccountDetailsModel?
    @Published var favorites: [FavoritesModel.TVShow] = []
    @Published var errorMessage: String?
    @Published var sessionID: String?
    @Published var isLoggedIn: Bool = false
    
    private let keychainManager = KeychainManager()
    private let userAccountService: UserAccountService
    private let authenticationService: AuthenticationService

    init(userAccountService: UserAccountService, authenticationService: AuthenticationService) {
        self.userAccountService = userAccountService
        self.authenticationService = authenticationService
        self.isLoggedIn = sessionID != nil
    }

    func logout() {
        keychainManager.deleteSessionID()
        sessionID = nil
        isLoggedIn = false
        AuthManager.shared.logout()
    }

    func fetchAccountDetails() {
        guard let sessionID = sessionID else { return }
        userAccountService.getAccountDetails(sessionID: sessionID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let accountDetails):
                    self?.accountDetails = accountDetails
                    self?.keychainManager.saveAccountID(accountDetails.id)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func createSession(requestToken: String) {
        authenticationService.createSession(requestToken: requestToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sessionID):
                    self?.sessionID = sessionID
                    self?.keychainManager.saveSessionID(sessionID)
                    self?.isLoggedIn = true
                    AuthManager.shared.loginWithTMDB() 
                case .failure(let error):
                    self?.errorMessage = "Failed to create session: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getFavorites(accountID: String, page: Int) {
        userAccountService.getFavorites(accountID: accountID, sessionID: self.sessionID ?? "N/A", page: page) { [weak self] (result: Result<FavoritesModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let favoritesModel):
                    self?.favorites = favoritesModel.results
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func updateSessionID() {
        sessionID = keychainManager.getSessionID()
    }
}

extension UserAccountViewModel {
    static func make() -> UserAccountViewModel {
        let userAccountNetworkManager = NetworkManager<UserAccountTarget>()
        let userAccountService = UserAccountService(networkManager: userAccountNetworkManager)
        let authenticationService = AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>())
        return UserAccountViewModel(userAccountService: userAccountService, authenticationService: authenticationService)
    }
}
