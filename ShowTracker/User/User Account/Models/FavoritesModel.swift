//
//  FavoritesModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/10/24.
//

import Foundation

struct FavoritesModel: Codable {
    let page: Int
    let results: [TVShow]  // This represents the array of TV shows
    let totalPages: Int
    let totalResults: Int
    
    struct TVShow: Codable {
        let id: Int
        let name: String
        let overview: String
        let firstAirDate: String
        let voteAverage: Double
        let posterPath: String?
        let backdropPath: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case firstAirDate = "first_air_date"
            case voteAverage = "vote_average"
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
