//
//  AccountResponses.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 9/10/25.
//

struct ModifyFavoriteRequest: Codable {
    let mediaType: String
    let mediaId: Int
    let favorite: Bool
}

struct ModifyFavoriteResponse: Codable {
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
