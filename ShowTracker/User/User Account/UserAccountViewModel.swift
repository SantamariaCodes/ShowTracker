//
//  UserAccountViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation

class UserAccountViewModel: ObservableObject {
    @Published var accountDetails: AccountDetails?
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
}
