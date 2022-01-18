//
//  MovieManagerProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 22/10/2021.
//

import Foundation

typealias APIClientResult = (Result<TopRatedList, Error>) -> Void

enum APIClientError: Error
{
    case serverError
    case urlError
    case parsingError
}

protocol APIClientProtocol
{
    func loadTopRated(page: Int, completion: @escaping APIClientResult)
}
