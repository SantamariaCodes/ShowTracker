//
//  Genres.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/8/24.
//
// this could be deleted and should

import Foundation

struct Genre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct GenreListResponse: Codable {
    let genres: [Genre]
}

