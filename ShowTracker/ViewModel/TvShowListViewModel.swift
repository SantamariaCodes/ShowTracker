//
//  TvShowListViewModel.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.


import Foundation

class TvShowListViewModel: ObservableObject {
    @Published var genreTvShows: [TvShowListTarget: [TvShow]] = [:]
    @Published var subGenres: [SubGenres]?
    
    private let tvService: TvShowListService
    private let subgenreService: SubGenreTypesService
    
    init(tvService: TvShowListService, subgenreService: SubGenreTypesService) {
        self.tvService = tvService
        self.subgenreService = subgenreService
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
    
    func loadSubGenres() {
        subgenreService.fetchGenres(listType: .retrieveSubGenreList) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let subGenres):
                    self?.subGenres = subGenres
                case .failure(let error):
                    print("Error loading subgenres: \(error)")
                }
            }
        }
    }
    
    func tvShowsBySubGenres(for genre: TvShowListTarget) -> [SubGenres: [TvShow]] {
        var tvShowsBySubGenre: [SubGenres: [TvShow]] = [:]
        
        guard let tvShows = genreTvShows[genre], let subGenres = subGenres else {
            return tvShowsBySubGenre
        }
        
        for subGenre in subGenres {
            // Corrected filtering to check if the TvShow's genreId contains the subGenre id
            let filteredShows = tvShows.filter { $0.genreId.contains(subGenre.id) }
            tvShowsBySubGenre[subGenre] = filteredShows
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
        let subgenreService = SubGenreTypesService(networkManager: tvShowNetworkManager)
        return TvShowListViewModel(tvService: tvShowService, subgenreService: subgenreService)
    }
}
