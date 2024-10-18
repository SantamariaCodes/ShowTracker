//
//  SearchShowViewModel.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 8/10/24.
//
//import Foundation
//import Combine
//
//class SearchShowViewModel: ObservableObject {
//    @Published var searchText: String = ""
//    @Published var retrievedShows: [TvShow] = []
//
//    private let searchShowService: SearchShowService
//    private var cancellables = Set<AnyCancellable>()
//
//    init(searchShowService: SearchShowService) {
//        self.searchShowService = searchShowService
//        $searchText
//            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
//            .removeDuplicates()
//            .sink { [weak self] newText in
//                guard let self = self else { return }
//                if !newText.isEmpty {
//                    self.searchTvShow(searchText: newText)
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    func searchTvShow(searchText: String) {
//        searchShowService.searchTvShow(showName: searchText) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let shows):
//                    self.retrievedShows = shows
//                case .failure(let error):
//                    print("Error retrieving shows: \(error)")
//                }
//            }
//        }
//    }
//}

