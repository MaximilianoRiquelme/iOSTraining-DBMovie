//
//  MovieCollectionViewDataSource.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 30/09/2021.
//

import Foundation

class MovieListDataSource: MovieListDataSourceProtocol
{
    var movieManager: MovieManagerProtocol
    
    init (movieManager: MovieManagerProtocol) {
        self.movieManager = movieManager
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfMoviesInSection(section: Int) -> Int {
        return self.movieManager.topRatedMovies?.count ?? Int.zero
    }
    
    func cellForItemAt(indexPath: IndexPath) throws -> MovieProtocol {
        //Change the cell with the proper information
        guard let movie = movieManager.topRatedMovies?[indexPath.row]
        else {
            throw MovieListError.CellNotFound
        }
        return movie
    }
}

