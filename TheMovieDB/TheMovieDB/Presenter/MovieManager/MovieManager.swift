//
//  MovieController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import Foundation

class MovieManager: MovieManagerProtocol
{
    private var networkingManager: NetworkingManagerProtocol
    
    var topRatedMovies: [MovieProtocol]? = []
    
    init(networkingController: NetworkingManagerProtocol) {
        self.networkingManager = networkingController
    }
    
    func loadTopRated(page: Int, completion: @escaping MovieListResult) {
        networkingManager.getTopRated(page: page) {
            [weak self] (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let myMovies):
                            self?.topRatedMovies = myMovies
                            completion(result)
                        case .failure(_):
                            self?.topRatedMovies = nil
                            completion(result)
                    }
                }
        }
    }
    
    
}
