//
//  TvShowListViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.

import Foundation
import Combine
import SwiftUI

class TvShowViewModel: ObservableObject {
    @Published var genreTvShows: [TvShowTarget: [TvShow]] = [:]
    @Published var genres: [Genre]?
    @Published var searchText: String = ""
    @Published var retrievedShows: [TvShow] = []
    
    @Published var selectedList: TvShowTarget?
    
    private let tvService: TvShowService
    private let genreService: SubGenreTypesService
    //look into this
    private var cancellables = Set<AnyCancellable>()
    
    init(tvService: TvShowService, genreService: SubGenreTypesService) {
        self.genreService = genreService
        self.tvService = tvService
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newText in
                guard let self = self else { return }
                if !newText.isEmpty {
                    self.searchTvShow(searchText: newText)
                }
            }
            .store(in: &cancellables)
  
    }
    
    func loadTvShows(listType: TvShowTarget) {
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
    
    func loadMoreShows(listType: TvShowTarget) {
        let key = listType.withUpdatedPage(1) // General key for the list type
        
        tvService.fetchListOfTvShows(listType: listType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    if var existingShows = self.genreTvShows[key] {
                        existingShows += shows
                        self.genreTvShows[key] = existingShows
                        print("Appended shows for \(key), total shows: \(existingShows.count)")
                    } else {
                        self.genreTvShows[key] = shows
                        print("First batch of shows for \(key), total shows: \(shows.count)")
                    }
                    
                    print("Total number of shows for \(key): \(self.genreTvShows[key]?.count ?? 0)")
                case .failure(let error):
                    print("Error loading shows: \(error)")
                }
            }
        }
    }
    
    func loadAllGenres() {
        let group = DispatchGroup()
        
        for genre in TvShowTarget.allCases {
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
    
    func tvShowsBySubGenres(for genre: TvShowTarget) -> [Genre: [TvShow]] {
        var tvShowsBySubGenre: [Genre: [TvShow]] = [:]
        
        guard let tvShows = genreTvShows[genre], let genres = genres else {
            return tvShowsBySubGenre
        }
        let excludedGenres = ["War & Politics", "Sci-Fi & Fantasy", "Kids", "Documentary", "Mystery"]
        let filteredGenres = genres.filter { !excludedGenres.contains($0.name) }
        
        for genre in filteredGenres {
            let filteredShows = tvShows.filter { $0.genreId.contains(genre.id) }
            tvShowsBySubGenre[genre] = filteredShows
        }
        return tvShowsBySubGenre
    }
    
    
    func filteredTvShows(for genre: TvShowTarget, with searchText: String) -> [TvShow]? {
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
    
    func searchTvShow(searchText: String) {
        tvService.searchTvShow(showName: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self.retrievedShows = shows
                case .failure(let error):
                    print("Error retrieving shows: \(error)")
                }
            }
        }
    }
    
    
    
}

extension TvShowViewModel {
    static func make() -> TvShowViewModel {
        let tvShowNetworkManager = NetworkManager<TvShowTarget>()
        let searchNetworkManager = NetworkManager<SearchShowTarget>()
        let tvShowService = TvShowService(networkManager: tvShowNetworkManager, searchNetworkManager: searchNetworkManager)
        let genreService = SubGenreTypesService(networkManager: tvShowNetworkManager)
        return TvShowViewModel(tvService: tvShowService, genreService: genreService)
    }
}

extension TvShowViewModel {
    var subgenreRows: [(subgenre: Genre, shows: [TvShow])] {
        guard let list = selectedList else { return [] }

        let groups = tvShowsBySubGenres(for: list)
        
        let nonEmpty = groups.filter { !$0.value.isEmpty }
        
        return nonEmpty.map { (subgenre, shows) in
          (subgenre: subgenre, shows: shows)
        }
    }
}



extension TvShowViewModel {
  var allRows: [(genre: TvShowTarget, shows: [TvShow])] {
    TvShowTarget.allCases.map { genre in
      (genre, genreTvShows[genre] ?? [])
    }
  }
}


