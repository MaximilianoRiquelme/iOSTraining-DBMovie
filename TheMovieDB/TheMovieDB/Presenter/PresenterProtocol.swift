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
    
    func getDetailViewModel(index: Int) -> DetailViewModelProtocol
    
    func loadTopRated(page: Int, completion: @escaping MovieListResult)
}
