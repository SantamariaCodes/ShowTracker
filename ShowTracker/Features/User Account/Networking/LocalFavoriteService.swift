//
//  LocalFavoriteService.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 9/2/25.
//

import Foundation

@MainActor
class LocalFavoriteService: ObservableObject {
    @Published private(set) var favorites: [FavoritesModel.TVShow]
    private var saveKey = "LocalFavorites"

    init() {
        
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                let decoded = try JSONDecoder().decode([FavoritesModel.TVShow].self, from: data)
                favorites = decoded
            } catch {
                print("Error decoding favorites: \(error)")
                favorites = []
            }
        } else {
            favorites = []
        }
    }
    
    func updateUserID(_ userID: String) {
          saveKey = "LocalFavorites-\(userID)"
          loadFavorites()
      }
    
    private func loadFavorites() {
         if let data = UserDefaults.standard.data(forKey: saveKey) {
             do {
                 let decoded = try JSONDecoder().decode([FavoritesModel.TVShow].self, from: data)
                 favorites = decoded
             } catch {
                 print("Error decoding favorites: \(error)")
                 favorites = []
             }
         } else {
             favorites = []
         }
     }
   
    func add(_ tvShow: FavoritesModel.TVShow) {
        if favorites.contains(where: { $0.id == tvShow.id }) {
        } else {
            favorites.append(tvShow)
            save()
        }
    }
    
    func checkIfFavorite(_ tvShow: FavoritesModel.TVShow) -> Bool {
        return favorites.contains(where: { $0.id == tvShow.id })
    }
    func remove(_ tvShow: FavoritesModel.TVShow) {
        if let index = favorites.firstIndex(where: { $0.id == tvShow.id }) {
            favorites.remove(at: index)
            save()
            loadFavorites()
        }
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encoded, forKey: saveKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }
}

