//
//  AuthenticationModels.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import Foundation

struct RequestTokenResponse: Decodable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}


struct SessionResponse: Decodable {
    let success: Bool
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
