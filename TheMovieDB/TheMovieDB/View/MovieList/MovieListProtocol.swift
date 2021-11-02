//
//  ListViewProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 24/09/2021.
//

import Foundation
import UIKit

enum MovieListError: Error {
    case CellNotFound
}

protocol MovieListProtocol
{
    var movieListDataSource: MovieListDataSourceProtocol { get }
    var movieListDelegate: MovieListDelegateProtocol { get }
    var view: UIView? { get }
    
    init(movieListDelegate: MovieListDelegateProtocol, movieListDataSource: MovieListDataSourceProtocol)
    
    func reloadData()
}

protocol MovieListDataSourceProtocol
{
    var movieManager: MovieManagerProtocol { get }
    
    func numberOfSections() -> Int
    func numberOfMoviesInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) throws -> MovieProtocol
}

protocol MovieListDelegateProtocol
{
    func loadDetailView(index: Int)
}
