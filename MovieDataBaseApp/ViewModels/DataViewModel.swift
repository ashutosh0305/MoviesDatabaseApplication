//
//  DataViewModel.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 27/07/24.
//

import Foundation

class MoviesViewModel {
    var movies: [Movie]
    var filteredMovies: [Movie] = []
    
    init() {
        self.movies = []
    }
    
    private func fetchMovies(completion: @escaping() -> Void) {
        DataFetcher.shared.loadMovies() { movies in
            self.movies = movies
            completion()
        }
    }
    
    func getSectionData(completion: @escaping ([Section]) -> Void) {
        let createSectionData: () -> [Section] = {
            return [
                Section(title: .year, items: self.getUniqueYears(), isExpanded: false),
                Section(title: .genre, items: self.getUniqueGenres(), isExpanded: false),
                Section(title: .directors, items: self.getUniqueDirectors(), isExpanded: false),
                Section(title: .actors, items: self.getUniqueActors(), isExpanded: false),
                Section(title: .allMovies, items: self.movies, isExpanded: false)
            ]
        }
        
        if movies.isEmpty {
            fetchMovies() { [weak self] in
                guard self != nil else { return }
                completion(createSectionData())
            }
        } else {
            completion(createSectionData())
        }
    }
    
    
    func getMoviesByCategory(category: MovieCategory, filterByValue: String) -> [Movie] {
        switch category {
        case .year:
            return filterByYear(filterByValue)
        case .genre:
            return filterByGenre(filterByValue)
        case .directors:
            return filterByDirector(filterByValue)
        case .actors:
            return filterByActor(filterByValue)
        case .allMovies:
            return movies
        }
    }
    
    private func filterByGenre(_ genre: String) -> [Movie] {
        return movies.filter { $0.genre.contains(genre) }
    }
    
    private func filterByDirector(_ director: String) -> [Movie] {
        return movies.filter { $0.director.contains(director) }
    }
    
    private func filterByActor(_ actor: String) -> [Movie] {
        return movies.filter { $0.actors.contains(actor) }
    }
    
    private func filterByYear(_ year: String) -> [Movie] {
        return movies.filter { $0.year == year }
    }
    
    private func getUniqueGenres() -> [String] {
        let genres = movies.flatMap { $0.genre.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        return Array(Set(genres)).sorted()
    }
    
    private func getUniqueDirectors() -> [String] {
        let directors = Set(movies.map { $0.director })
        return Array(directors).sorted()
    }
    
    private func getUniqueActors() -> [String] {
        let actors = movies.flatMap { $0.actors.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        return Array(Set(actors)).sorted()
    }
    
    private func getUniqueYears() -> [String] {
        let years = Set(movies.map { $0.year })
        return Array(years).sorted()
    }
    
    func filterMovies(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.actors.lowercased().contains(searchText.lowercased()) ||
                $0.genre.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
