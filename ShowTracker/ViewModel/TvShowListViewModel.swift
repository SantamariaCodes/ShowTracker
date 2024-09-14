//
//  TvShowListViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.

import Foundation

class TvShowListViewModel: ObservableObject {
    // genreTvShow should be refactored into Category or showCategory
    @Published var genreTvShows: [TvShowListTarget: [TvShow]] = [:]
    @Published var genres: [Genre]? // Changed from subGenres to genres
    
    private let tvService: TvShowListService
    private let genreService: SubGenreTypesService
    
    init(tvService: TvShowListService, genreService: SubGenreTypesService) {
        self.tvService = tvService
        self.genreService = genreService
    }
    
    func loadTvShows(listType: TvShowListTarget) {
        tvService.fetchListOfTvShows(listType: listType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self.genreTvShows[listType] = shows
                case .failure(let error):
                    print("Error loading shows: \(error)")
                }
            }
        }
    }
    
 
    
    func loadMoreShows(listType: TvShowListTarget) {
        let key = listType.withUpdatedPage(1) // General key for the list type
        
        tvService.fetchListOfTvShows(listType: listType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    if var existingShows = self.genreTvShows[key] {
                        // Append new shows and log it
                        existingShows += shows
                        self.genreTvShows[key] = existingShows
                        print("Appended shows for \(key), total shows: \(existingShows.count)")
                    } else {
                        // If no shows exist, add them for the first time
                        self.genreTvShows[key] = shows
                        print("First batch of shows for \(key), total shows: \(shows.count)")
                    }

                    // Debugging: Print the total number of shows after appending
                    print("Total number of shows for \(key): \(self.genreTvShows[key]?.count ?? 0)")
                case .failure(let error):
                    print("Error loading shows: \(error)")
                }
            }
        }
    }





    
    
    

    func loadAllGenres() {
        let group = DispatchGroup()
        
        for genre in TvShowListTarget.allCases {
            group.enter()
            tvService.fetchListOfTvShows(listType: genre) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let shows):
                        self.genreTvShows[genre] = shows
                    case .failure(let error):
                        print("Error loading shows for genre \(genre): \(error)")
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            // All genres are loaded
        }
    }
    
    func loadGenres() {
        genreService.fetchGenres(listType: .retrieveSubGenreList) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self?.genres = genres // Changed from subGenres to genres
                case .failure(let error):
                    print("Error loading genres: \(error)")
                }
            }
        }
    }
    
    func tvShowsBySubGenres(for genre: TvShowListTarget) -> [Genre: [TvShow]] {
        var tvShowsBySubGenre: [Genre: [TvShow]] = [:]
        
        guard let tvShows = genreTvShows[genre], let genres = genres else {
            return tvShowsBySubGenre
        }
        
        for genre in genres {
            let filteredShows = tvShows.filter { $0.genreId.contains(genre.id) }
            tvShowsBySubGenre[genre] = filteredShows
        }
        
        return tvShowsBySubGenre
    }

    func filteredTvShows(for genre: TvShowListTarget, with searchText: String) -> [TvShow]? {
        guard let tvShows = genreTvShows[genre] else {
            return nil
        }
        
        if searchText.isEmpty {
            return tvShows
        } else {
            return tvShows.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func filteredTvShows(for searchText: String) -> [TvShow] {
        return genreTvShows.values.flatMap { $0 }.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
}

extension TvShowListViewModel {
    static func make() -> TvShowListViewModel {
        let tvShowNetworkManager = NetworkManager<TvShowListTarget>()
        let tvShowService = TvShowListService(networkManager: tvShowNetworkManager)
        let genreService = SubGenreTypesService(networkManager: tvShowNetworkManager)
        return TvShowListViewModel(tvService: tvShowService, genreService: genreService)
    }
}


