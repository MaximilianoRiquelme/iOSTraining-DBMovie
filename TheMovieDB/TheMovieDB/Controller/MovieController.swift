//
//  MovieController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import Foundation

protocol MovieController
{
    var singleMovie: SingleMovie? { get }
    var topRatedMovies: [TopRatedMovie]? { get }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    func loadTopRated(completion: @escaping TopRatedResult)
}

class MovieControllerImp: MovieController
{
    var singleMovie: SingleMovie?
    var topRatedMovies: [TopRatedMovie]? = []
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        NetworkingController.parseSingleMovie(movieId: movieId) {
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
        NetworkingController.parseTopRated {
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
