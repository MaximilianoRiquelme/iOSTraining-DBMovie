//
//  NetworkingProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation

typealias MovieListResult = (Result<[MovieProtocol], Error>) -> Void

enum NetworkingError: Error
{
    case urlError
    case serverError
    case parsingError
}

protocol NetworkingManagerProtocol
{
    func getTopRated(page: Int ,completion: @escaping MovieListResult)
}
