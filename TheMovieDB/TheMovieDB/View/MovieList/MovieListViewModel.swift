//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 03/11/2021.
//

import Foundation

class MovieListViewModel: MovieListViewModelProtocol
{
    var movies: [MovieProtocol]?
     
    init(movies: [MovieProtocol]) {
        self.movies = movies
    }
}
