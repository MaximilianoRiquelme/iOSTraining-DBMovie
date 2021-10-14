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
    init(movieListDelegate: MovieListDelegateProtocol, movieListDataSource: MovieListDataSourceProtocol)
    
    var movieListDataSource: MovieListDataSourceProtocol { get }
    var movieListDelegate: MovieListDelegateProtocol { get }
    var view: UIView? { get }
    
    func reloadData()
}

protocol MovieListDataSourceProtocol
{
    var movieManager: MovieManagerProtocol { get }
    
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) throws -> MovieProtocol
}

protocol MovieListDelegateProtocol
{
    var movieManager: MovieManagerProtocol { get }
    var navigationController: UINavigationController? { get }
    
    func loadDetailView(index: Int)
}
