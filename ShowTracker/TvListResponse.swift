//
//  TvListResponse.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//


struct TvShow: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case title = "name"
        case posterPath = "poster_path"
    }
}

struct ListOfTvShowsResponse: Codable {
    let results: [TvShow]
}
