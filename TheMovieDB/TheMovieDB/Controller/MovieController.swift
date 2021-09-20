//
//  MovieController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import Foundation

protocol MovieControllerProtocol
{
    var networkingController: NetworkingProtocol { get }
    var singleMovie: MovieProtocol? { get }
    var topRatedMovies: [MovieProtocol]? { get }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    func loadTopRated(completion: @escaping TopRatedResult)
}

class MovieControllerImplementation: MovieControllerProtocol
{
    var networkingController: NetworkingProtocol
    var singleMovie: MovieProtocol?
    var topRatedMovies: [MovieProtocol]? = []
    
    init(networkingController: NetworkingProtocol) {
        self.networkingController = networkingController
    }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        networkingController.getSingleMovie(movieId: movieId) {
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
    
    func loadTopRated(completion: @escaping TopRatedResult) {
        networkingController.getTopRated(page: 1) {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let myMovies):
                            self?.topRatedMovies = myMovies.results
                            completion(result)
                        case .failure(_):
                            self?.topRatedMovies = nil
                            completion(result)
                    }
                }
        }
    }
    
    
}
