//
//  MovieManagerProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 22/10/2021.
//

import Foundation

typealias MovieManagerResult = (Result<TopRatedList, Error>) -> Void

enum MovieManagerError: Error
{
    case urlError
    case parsingError
}

protocol MovieManagerProtocol
{
    func loadTopRated(page: Int, completion: @escaping MovieManagerResult)
}
