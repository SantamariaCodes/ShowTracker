//
//  SubGenres.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/8/24.
//

import Foundation

struct SubGenres: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct listOfSubGenres: Codable {
    let genres: [SubGenres]  // This matches the "genres" key in the JSON response
}
