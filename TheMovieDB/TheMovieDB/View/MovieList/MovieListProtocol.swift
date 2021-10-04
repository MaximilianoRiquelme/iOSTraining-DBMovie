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
    var movieListDataSource: MovieListDataSource? { get set }
    var view: UIView? { get }
    
    func reloadData()
}

protocol MovieListDataSourceProtocol
{
    var movieManager: MovieManagerProtocol? { get set }
    
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) throws -> MovieProtocol
}
