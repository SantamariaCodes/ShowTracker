//
//  UserFavoritesViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 21/10/24.
// 

import Foundation

class UserFavoritesViewModel: ObservableObject {
    
    @Published var favorites: [FavoritesModel.TVShow] = []
    @Published var errorMessage: String?
    @Published var accountID: String?
    @Published var sessionID: String?

    private let keychainManager = KeychainManager()
    private let userAccountService: UserAccountService

    
    init(userAccountService: UserAccountService) {
        self.userAccountService = userAccountService
    }
    
    
    func getFavorites(page: Int) {
        userAccountService.getFavorites(accountID: self.accountID ?? "N/A", sessionID: self.sessionID ?? "N/A", page: page) { [weak self] (result: Result<FavoritesModel, Error>) in
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
    
    func updateAccountIDandSessionID() {
        self.accountID = keychainManager.getAccountID()
        self.sessionID = keychainManager.getSessionID()
    }
    
  

}

extension UserFavoritesViewModel {
    static func make() -> UserFavoritesViewModel {
        let userFavoritesNetworkManager = NetworkManager<UserAccountTarget>()
        let userAccountService  = UserAccountService(networkManager: userFavoritesNetworkManager)
        return UserFavoritesViewModel(userAccountService: userAccountService)
    }
}

