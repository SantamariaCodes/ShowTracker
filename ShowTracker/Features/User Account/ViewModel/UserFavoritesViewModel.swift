//
//  UserFavoritesViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 21/10/24.
//

import Foundation
import SwiftUI
import Combine

class UserFavoritesViewModel: ObservableObject {
    
    private var authManager: AuthManager
    private var cancellables = Set<AnyCancellable>()

    @Published var favorites: [FavoritesModel.TVShow] = []
    @Published var errorMessage: String?
    @Published var accountID: String?
    @Published var sessionID: String?

    private let keychainManager = KeychainManager()
    private let userAccountService: UserAccountService
    private let localFavoriteService: LocalFavoriteService

    @MainActor
    init(userAccountService: UserAccountService, authManager: AuthManager = AuthManager.shared) {
        self.userAccountService = userAccountService
        self.authManager = authManager
        self.localFavoriteService = LocalFavoriteService()
        
        authManager.$authMethod
            .sink { [weak self] newAuthMethod in
                if newAuthMethod == .none {
                    self?.userLoggedOut()
                }
            }
            .store(in: &cancellables)
        
        localFavoriteService.$favorites
              .sink { [weak self] newFavorites in
                  if self?.authManager.authMethod == .firebase {
                      self?.favorites = newFavorites
                  }
              }
              .store(in: &cancellables)
    }
    
    
    
    
    
    @MainActor func getFavorites(page: Int) {
        if authManager.authMethod == .tmdb {
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
        } else if authManager.authMethod == .firebase {
            self.favorites = self.localFavoriteService.favorites
        }
    }
    
    func updateAccountIDandSessionID() {
        self.accountID = keychainManager.getAccountID()
        self.sessionID = keychainManager.getSessionID()
    }
    
    func userLoggedOut() {
        self.accountID = nil
        self.sessionID = nil
        self.favorites = []
    }
}
@MainActor
extension UserFavoritesViewModel {
    static func make() -> UserFavoritesViewModel {
        let userFavoritesNetworkManager = NetworkManager<UserAccountTarget>()
        let userAccountService  = UserAccountService(networkManager: userFavoritesNetworkManager)
        return UserFavoritesViewModel(userAccountService: userAccountService)
    }
}
