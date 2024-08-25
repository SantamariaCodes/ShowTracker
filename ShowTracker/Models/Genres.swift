//
//  Genres.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/8/24.
//

import Foundation

struct Genres: Codable, Identifiable {
    let id: Int
    let name: String
    
}
struct listOfGenres: Codable {
    let results: [Genres]
}
