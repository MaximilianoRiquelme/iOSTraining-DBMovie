//
//  ListViewProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 24/09/2021.
//

import Foundation
import UIKit

typealias MovieResult = (Result<Data, Error>) -> Void

enum MovieListError: Error
{
    case CellNotFound
    case ListNotFound
}

protocol MovieListViewProtocol
{
    var movieListDataSource: MovieListDataSourceProtocol { get }
    var movieListDelegate: MovieListDelegateProtocol { get }
    var view: UIView? { get }
    
    init(movieListDelegate: MovieListDelegateProtocol, viewModel: MovieListViewModelProtocol)
    
    func reloadData()
    func getMovieAt(index: Int) -> MovieProtocol?
}
