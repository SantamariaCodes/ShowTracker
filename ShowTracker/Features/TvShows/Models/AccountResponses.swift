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
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case favorite
    }
}
