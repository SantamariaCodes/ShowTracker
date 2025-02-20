//
//  TvListResponse.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//


import Foundation

struct TvShow: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let popularity: Double
    let genreId: [Int]
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity
        case title = "name"
        case posterPath = "poster_path"
        case genreId = "genre_ids"
        case voteAverage = "vote_average"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

struct ListOfTvShowsResponse: Codable {
    let results: [TvShow]
}
