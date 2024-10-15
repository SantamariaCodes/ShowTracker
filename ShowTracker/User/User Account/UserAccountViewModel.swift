//
//  UserAccountViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
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
    @Published var showUserDetails: Bool?
    @Published var showLoginView: Bool?
    

    private let keychainManager = KeychainManager()
    private let userAccountService: UserAccountServiceProtocol

    init(userAccountService: UserAccountServiceProtocol) {
        self.userAccountService = userAccountService
    }

        
    func logout() {
            keychainManager.deleteSessionID()
            sessionID = nil  // Clear the sessionID property to update the UI
        }
    
    func fetchAccountDetails() {
        userAccountService.getAccountDetails(sessionID: self.sessionID ?? "N/A") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let accountDetails):
                    self?.accountDetails = accountDetails
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
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
