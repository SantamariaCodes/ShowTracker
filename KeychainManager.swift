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
        print("current session id is \(keychain.get("Session_ID"))")
        return keychain.get("Session_ID")
    }

    func deleteSessionID() {
        print("session deleted")
        keychain.delete("Session_ID")
        
    }
}
