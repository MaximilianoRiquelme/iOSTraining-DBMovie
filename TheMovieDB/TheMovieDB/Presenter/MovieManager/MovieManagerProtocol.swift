//
//  MovieManagerProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 22/10/2021.
//

import Foundation

protocol MovieManagerProtocol
{
    var topRatedMovies: [MovieProtocol]? { get }
    
    func loadTopRated(page: Int, completion: @escaping MovieListResult)
}
