//
//  MovieList.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 11/11/2021.
//

import Foundation

protocol MovieListProtocol
{
    var page: Int { get }
    var results: [MovieProtocol] { get }
}
