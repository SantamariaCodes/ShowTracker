//
//  KeychainManager.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 14/10/24.
//

import Foundation
import KeychainSwift

class KeychainManager {
    private let keychain = KeychainSwift()
    
    func saveSessionID(_ sessionID: String) {
        keychain.set(sessionID, forKey: "Session_ID")
    }
    
    func getSessionID() -> String? {
        return keychain.get("Session_ID")
    }
    
    func deleteSessionID() {
        keychain.delete("Session_ID")
        
    }
    
    func saveAccountID(_ accountID: Int) {
          keychain.set(String(accountID), forKey: "Account_ID")
      }
    func getAccountID() -> String? {
        return keychain.get("Account_ID")

        
      }
    func deleteAccountID() {
        keychain.delete("Account_ID")
        
    }

    
}
