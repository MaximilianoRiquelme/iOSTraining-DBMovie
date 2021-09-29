//
//  ListViewProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 24/09/2021.
//

import Foundation
import UIKit

protocol MovieListProtocol
{
    var dataSource: MovieListDataSource { get set }
}

protocol MovieListDataSource
{
    func numberOfSections(in list: MovieListProtocol) -> Int
    func movieList(_ list: MovieListProtocol, numberOfItemsInSection section: Int) -> Int
    func movieList(_ list: MovieListProtocol, cellForItemAt indexPath: IndexPath) -> MovieCellProtocol
}
