//
//  UserFavoritesViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 21/10/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class UserFavoritesViewModel: ObservableObject {
    
    // MARK: - Published state
    @Published var favorites: [FavoritesModel.TVShow] = []
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var accountID: String?
    @Published var sessionID: String?
    @Published var isLoading = false
    

    private let authManager: AuthManager
    private let keychainManager = KeychainManager()
    private let userAccountService: UserAccountService
    private let accountService: AccountService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        userAccountService: UserAccountService,
        accountService: AccountService = AccountService(networkManager: NetworkManager<AccountTarget>()),
        authManager: AuthManager = AuthManager.shared
    ) {
        self.userAccountService = userAccountService
        self.accountService = accountService
        self.authManager = authManager
        
        authManager.$authMethod
            .sink { [weak self] newAuthMethod in
                if newAuthMethod == .none {
                    self?.userLoggedOut()
                }
            }
            .store(in: &cancellables)
    }
    
    func getFavorites(page: Int) {
        guard let accountID = accountID, let sessionID = sessionID else {
            errorMessage = "Missing credentials"
            return
        }
        
        isLoading = true
        userAccountService.getFavorites(accountID: accountID, sessionID: sessionID, page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let favoritesModel):
                    self.favorites = favoritesModel.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func toggleFavorite(mediaType: String, mediaId: Int, currentlyFavorite: Bool) {
        isLoading = true
        
        let request = ModifyFavoriteRequest(
            mediaType: mediaType,
            mediaId: mediaId,
            favorite: !currentlyFavorite
        )
        
        accountService.modifyFavorite(request: request) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.successMessage = response.statusMessage
                print("✅ Favorite updated:", response.statusMessage)
                
                // Refresh local favorites if needed
                self.getFavorites(page: 1)
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("❌ Error modifying favorite:", error)
            }
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

extension UserFavoritesViewModel {
    static func make() -> UserFavoritesViewModel {
        let userFavoritesNetworkManager = NetworkManager<UserAccountTarget>()
        let userAccountService = UserAccountService(networkManager: userFavoritesNetworkManager)
        let accountService = AccountService(networkManager: NetworkManager<AccountTarget>())
        return UserFavoritesViewModel(
            userAccountService: userAccountService,
            accountService: accountService,
            authManager: AuthManager.shared
        )
    }
}
