//
//  MovieController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import Foundation

protocol MovieManagerProtocol
{
    var networkingManager: NetworkingManagerProtocol { get }
    var singleMovie: MovieProtocol? { get }
    var topRatedMovies: [MovieProtocol]? { get }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    func loadTopRated(completion: @escaping MovieListResult)
}

class MovieManager: MovieManagerProtocol
{
    var networkingManager: NetworkingManagerProtocol
    var singleMovie: MovieProtocol?
    var topRatedMovies: [MovieProtocol]? = []
    
    init(networkingController: NetworkingManagerProtocol) {
        self.networkingManager = networkingController
    }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        networkingManager.getSingleMovie(movieId: movieId) {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let myMovie):
                            self?.singleMovie = myMovie
                            completion(result)
                        case .failure(_):
                            self?.singleMovie = nil
                            completion(result)
                    }
                }
        }
    }
    
    func loadTopRated(completion: @escaping MovieListResult) {
        networkingManager.getTopRated(page: 1) {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let myMovies):
                            self?.topRatedMovies = myMovies
                            completion(result)
                        case .failure(_):
                            self?.topRatedMovies = nil
                            completion(result)
                    }
                }
        }
    }
    
    
}
