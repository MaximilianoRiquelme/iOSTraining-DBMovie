//
//  NetworkingProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation

typealias NetworkingResult = (Result<Data, Error>) -> Void

enum NetworkingError: Error
{
    case serverError
}

protocol NetworkingManagerProtocol
{
    func getData(url: URL ,completion: @escaping NetworkingResult)
}
