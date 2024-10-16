//
//  TvShowListViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.

import Foundation
import Combine

class TvShowListViewModel: ObservableObject {
    @Published var genreTvShows: [TvShowListTarget: [TvShow]] = [:]
    @Published var genres: [Genre]?
    @Published var searchText: String = ""
    @Published var retrievedShows: [TvShow] = []

    private let tvService: TvShowListService
    private let genreService: SubGenreTypesService
    private let searchService: SearchShowService
    private var cancellables = Set<AnyCancellable>()

    init(tvService: TvShowListService, genreService: SubGenreTypesService, searchService: SearchShowService) {
        self.tvService = tvService
        self.genreService = genreService
        self.searchService = searchService

        setupSearchBinding()
    }

    private func setupSearchBinding() {
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

    func searchTvShow(searchText: String) {
        searchService.searchTvShow(showName: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self?.retrievedShows = shows
                case .failure(let error):
                    print("Error retrieving shows: \(error)")
                }
            }
        }
    }

    func loadTvShows(listType: TvShowListTarget) {
        tvService.fetchListOfTvShows(listType: listType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self?.genreTvShows[listType] = shows
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
            tvService.fetchListOfTvShows(listType: genre) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let shows):
                        self?.genreTvShows[genre] = shows
                    case .failure(let error):
                        print("Error loading shows for genre \(genre): \(error)")
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            print("All genres loaded successfully.")
        }
    }

    func loadGenres() {
        genreService.fetchGenres(listType: .retrieveSubGenreList) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self?.genres = genres
                case .failure(let error):
                    print("Error loading genres: \(error)")
                }
            }
        }
    }

    func filteredTvShows(for genre: TvShowListTarget, with searchText: String) -> [TvShow]? {
        guard let tvShows = genreTvShows[genre] else { return nil }
        return searchText.isEmpty ? tvShows : tvShows.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    func tvShowsBySubGenres(for genre: TvShowListTarget) -> [Genre: [TvShow]] {
        var tvShowsBySubGenre: [Genre: [TvShow]] = [:]

        guard let tvShows = genreTvShows[genre], let genres = genres else { return tvShowsBySubGenre }

        let excludedGenres = ["War & Politics", "Sci-Fi & Fantasy", "Kidx1s", "Documentary", "Mystery"]
        let filteredGenres = genres.filter { !excludedGenres.contains($0.name) }

        for genre in filteredGenres {
            let filteredShows = tvShows.filter { $0.genreId.contains(genre.id) }
            tvShowsBySubGenre[genre] = filteredShows
        }

        return tvShowsBySubGenre
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
}

extension TvShowListViewModel {
    static func make() -> TvShowListViewModel {
        let tvShowNetworkManager = NetworkManager<TvShowListTarget>()
        let tvService = TvShowListService(networkManager: tvShowNetworkManager)
        let genreService = SubGenreTypesService(networkManager: tvShowNetworkManager)
        let searchService = SearchShowService(networkManager: NetworkManager<SearchShowTarget>())
        return TvShowListViewModel(tvService: tvService, genreService: genreService, searchService: searchService)
    }
}
