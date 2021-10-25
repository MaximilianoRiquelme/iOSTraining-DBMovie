//
//  MovieManagerProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 22/10/2021.
//

import Foundation

protocol MovieManagerProtocol
{
    var singleMovie: MovieProtocol? { get }
    var topRatedMovies: [MovieProtocol]? { get }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    func loadTopRated(completion: @escaping MovieListResult)
}
