//
//  AuthViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var requestToken: String? = nil
    @Published var sessionID: String? = nil  
    @Published var errorMessage: String? = nil
    
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
                    self?.requestToken = token
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch token: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func createSession(requestToken: String) {
        authenticationService.createSession(requestToken: requestToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sessionID):
                    print("Session ID created??? it did?: \(sessionID)")   

                    self?.sessionID = sessionID
                case .failure(let error):
                    self?.errorMessage = "Failed to create session: \(error.localizedDescription)"
                    print("Error creating session: \(error.localizedDescription)")

                }
            }
        }
    }
}
