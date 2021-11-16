//
//  MovieCollectionViewDataSource.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 30/09/2021.
//

import Foundation

class MovieListDataSource: MovieListDataSourceProtocol
{
    var movies: [MovieProtocol]?
    
    required init(viewModel: MovieListViewModelProtocol) {
        movies = viewModel.movies ?? [MovieProtocol]()
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfMoviesInSection(section: Int) -> Int {
        return self.movies?.count ?? Int.zero
    }
    
    func movieForItemAt(index: Int) throws -> MovieProtocol {
        //Change the cell with the proper information
        guard let movie = movies?[index]
        else {
            throw MovieListError.CellNotFound
        }
        return movie
    }
}

