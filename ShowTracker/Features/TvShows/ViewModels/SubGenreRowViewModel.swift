//
//  SubGenreRowViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 14/5/25.
//

import Foundation

class SubGenreRowViewModel: ObservableObject {
        
    let tvShowTarget: TvShowTarget
    let subGenre : Genre
    private let tvService: TvShowService

    @Published var genreTvShows: [TvShowTarget: [TvShow]]
    = [:]
    @Published var genres: [Genre]?
    @Published var isLoadingMore = false
    
    
    
    init(tvShowTarget: TvShowTarget, subGenre: Genre, tvService: TvShowService) {
        self.tvShowTarget = tvShowTarget
        self.subGenre = subGenre
        self.tvService = tvService
        
        loadTvShows(listType: tvShowTarget)
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
        let key = listType.withUpdatedPage(1)
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
    
     func loadMoreIfNeeded() {
        if !isLoadingMore {
            isLoadingMore = true

            let storageKey = tvShowTarget.withUpdatedPage(1)
            let currentCount = genreTvShows[storageKey]?.count ?? 0
            let currentPage = currentCount / 20 + 1

            print("Loading page \(currentPage + 1) for \(tvShowTarget)")
           loadMoreShows(listType: tvShowTarget.withUpdatedPage(currentPage + 1))

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoadingMore = false
            }
        }
    }
    func filteredShows() -> [TvShow] {
         var filteredShows: [TvShow] {
            genreTvShows[tvShowTarget]?.filter {
                $0.genreId.contains(subGenre.id)
            } ?? []
        }
        return filteredShows
    }
}

extension SubGenreRowViewModel {
    static func make(tvShowTarget: TvShowTarget, subGenre: Genre) -> SubGenreRowViewModel {
        let networkManager = NetworkManager<TvShowTarget>()
        let tvService = TvShowService(networkManager: networkManager, searchNetworkManager: NetworkManager<SearchShowTarget>())
        return SubGenreRowViewModel(tvShowTarget: tvShowTarget, subGenre: subGenre, tvService: tvService)
    }
}
