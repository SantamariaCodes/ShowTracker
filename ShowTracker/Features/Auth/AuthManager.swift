//
//  AuthManager.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/2/25.
//

import Foundation
import FirebaseAuth

enum AuthMethod {
    case none
    case tmdb
    case firebase
}

final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var authMethod: AuthMethod = .none
    
    
    private init() {}
    
    
    func loginWithTMDB() {
        authMethod = .tmdb
        isLoggedIn = true
    }
    
    func loginWithFirebase() {
        authMethod = .firebase
        isLoggedIn = true
    }
    
    func logout() {
        authMethod = .none
        isLoggedIn = false
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out of Firebase: \(error)")
        }
    }
}

extension AuthManager {
    static func make() -> AuthManager {
        return AuthManager.shared
    }
}


