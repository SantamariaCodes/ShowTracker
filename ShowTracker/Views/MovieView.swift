////
////  MovieView.swift
////  MovieScope
////
////  Created by Diego Santamaria on 16/7/24.
//// command + Shift + 0
//// add transitions 
//
//import SwiftUI
//
//struct MovieView: View {
//    
//    let movies: [Movie] = Movie.allMovies
//    
//    @State private var selectedGenre = "All"
//    @State private var searchText = ""
//    @FocusState private var isSearching: Bool
//    
//    let allGenres: [String] = ["All", "Anotherone"] + Movie.uniqueGenres()
//    let allCategoryTypes: [String] = Movie.uniqueCategories()
//    
//    var filteredMovies: [Movie] {
//        let genreFilteredMovies = selectedGenre == "All" ? movies : movies.filter { $0.genre == selectedGenre }
//        
//        if searchText.isEmpty {
//            return genreFilteredMovies
//        } else {
//            return genreFilteredMovies.filter { $0.title.localizedStandardContains(searchText) }
//        }
//    }
//    
//    var filteredCategoryMovies: [String: [Movie]] {
//        var categoryDict: [String: [Movie]] = [:]
//        for category in allCategoryTypes {
//            let moviesForCategory = movies.filter { $0.category == category && $0.genre == selectedGenre }
//            categoryDict[category] = moviesForCategory
//        }
//        return categoryDict
//    }
//    
//    var body: some View {
//                NavigationStack {
//            
//            ScrollView {
//                VStack(spacing: 0) {
//                    if !isSearching {
//                        CarouselContentView()
//                            .padding(.top, 10)
//                        
//                        CustomGenrePicker(selectedGenre: $selectedGenre, genres: allGenres)
//                        
//                        VStack(spacing: 20) {
//                            if selectedGenre == "All" {
//                                ForEach(allGenres, id: \.self) { genre in
//                                    let genreMovies = filteredMovies.filter { $0.genre == genre }
//                                    if !genreMovies.isEmpty {
//                                        DashboardRow(title: genre, movies: genreMovies)
//                                    }
//                                }
//                            } else {
//                                ForEach(allCategoryTypes, id: \.self) { category in
//                                    if let categoryMovies = filteredCategoryMovies[category], !categoryMovies.isEmpty {
//                                        DashboardRow(title: category, movies: categoryMovies)
//                                    }
//                                }
//                            }
//                        }
//                        
//                        .navigationTitle("Movies")
//                        .padding()
//                        .preferredColorScheme(.dark)
//                    } else {
//                        GridDisplay(genre: "Search Results", movies: movies)
//                            .navigationTitle("Search Results")
//                            .padding()
//                    }
//                }
//            }
//      
//        
//                    
//        }
//                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
//                .focused($isSearching, equals: true)
//    }
//}
//
//#Preview {
//    MovieView()
//}
