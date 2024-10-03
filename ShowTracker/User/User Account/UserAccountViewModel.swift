//
//  UserAccountViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation

class UserAccountViewModel: ObservableObject {
    @Published var accountDetails: AccountDetailsModel?
    @Published var favorites: [FavoritesModel.TVShow] = []
    @Published var errorMessage: String?

    private let userAccountService: UserAccountServiceProtocol

    init(userAccountService: UserAccountServiceProtocol) {
        self.userAccountService = userAccountService
    }

    func fetchAccountDetails(sessionID: String) {
        userAccountService.getAccountDetails(sessionID: sessionID) { [weak self] result in
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

    func getFavorites(accountID: String, sessionID: String, page: Int) {
        userAccountService.getFavorites(accountID: accountID, sessionID: sessionID, page: page) { [weak self] (result: Result<FavoritesModel, Error>) in
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

}
