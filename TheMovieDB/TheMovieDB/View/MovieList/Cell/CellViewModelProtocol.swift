//
//  CellViewModelProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 26/10/2021.
//

import Foundation

protocol CellViewModelProtocol
{
    var englishTitle: String { get }
    var posterPath: URL? { get }
}
