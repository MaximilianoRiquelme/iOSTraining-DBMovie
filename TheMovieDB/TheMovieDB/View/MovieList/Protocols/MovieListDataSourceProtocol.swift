//
//  MovieListDataSourceProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 03/11/2021.
//

import Foundation

protocol MovieListDataSourceProtocol
{
    init(viewModel: MovieListViewModelProtocol)
    
    func numberOfSections() -> Int
    func numberOfMoviesInSection(section: Int) -> Int
    func movieForItemAt(index: Int) throws -> MovieProtocol
}
