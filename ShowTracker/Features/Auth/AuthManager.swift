//
//  AuthManager.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/2/25.
//

import Foundation

enum AuthMethod {
  case tmdb
  case firebase
}


class AuthManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var authMehod: AuthMethod? = nil
    
    static let shared = AuthManager()
        
   private init() {}
    
    func loginState() -> AuthMethod? {
        return authMehod
    }

}
