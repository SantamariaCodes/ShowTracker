//
//  AccountDetails.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation

struct AccountDetails: Codable {
    struct Avatar: Codable {
        struct Gravatar: Codable {
            let hash: String
        }
        struct TMDB: Codable {
            let avatar_path: String?
        }
        let gravatar: Gravatar
        let tmdb: TMDB
    }

    let avatar: Avatar
    let id: Int
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let include_adult: Bool
    let username: String
}
