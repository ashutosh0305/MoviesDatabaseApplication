//
//  DataFetcher.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 27/07/24.
//

import Foundation
import UIKit

class DataFetcher {
    static let shared = DataFetcher()
    private var movieData: [Movie] = []
    private let imageCache = NSCache<NSString, UIImage>()

    private init() {}

    func loadMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            fatalError("Movies JSON file not found")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            movieData = try decoder.decode([Movie].self, from: data)
            downloadMovieImages {
                completion(self.movieData)
            }
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }

    private func getImage(posterLink: String?, completion: @escaping (UIImage?) -> Void) {
        guard let posterLink = posterLink, let url = URL(string: posterLink) else {
            completion(nil)
            return
        }

        let cacheKey = NSString(string: posterLink)

        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.imageCache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }

    private func downloadMovieImages(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for movie in movieData {
            dispatchGroup.enter()
            getImage(posterLink: movie.poster) { [weak self] image in
                if let image = image, let index = self?.movieData.firstIndex(where: { $0.id == movie.id }) {
                    self?.movieData[index].posterImage = image
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }

    func getMovies() -> [Movie] {
        return movieData
    }
}
