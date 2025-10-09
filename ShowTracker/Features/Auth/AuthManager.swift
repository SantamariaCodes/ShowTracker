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
}

final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var authMethod: AuthMethod = .none
    
    

    
    func loginWithTMDB() {
        authMethod = .tmdb
        isLoggedIn = true
    }
    
    func loginWithFirebase() {
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


