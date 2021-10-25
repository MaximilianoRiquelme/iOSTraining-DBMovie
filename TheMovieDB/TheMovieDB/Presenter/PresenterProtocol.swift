//
//  PresenterProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation

enum MovieListType {
    case list
    case grid
}

protocol PresenterProtocol
{
    func getMovieList(type: MovieListType) -> MovieListProtocol
    func getViewModel(index: Int) -> DetailViewModelProtocol
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    func loadTopRated(completion: @escaping MovieListResult)
}
