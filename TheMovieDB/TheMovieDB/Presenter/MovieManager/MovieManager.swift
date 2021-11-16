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
    
    init(networkingController: NetworkingManagerProtocol) {
        self.networkingManager = networkingController
    }
    
    func loadTopRated(page: Int, completion: @escaping MovieManagerResult) {
        //Sets the URL
        guard let myUrl = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&page=\(page))")
        else {
            completion(.failure(MovieManagerError.urlError))
            return
        }
        
        networkingManager.getData(url: myUrl) {
            (result) in
                switch result
                {
                    case .success(let data):
                        //If we have a response, we try to decode the JSON
                        do {
                            let myMovies = try JSONDecoder().decode(TopRatedList.self, from: data)
                                completion(.success(myMovies))
                        }
                    catch {
                            completion(.failure(MovieManagerError.parsingError))
                        }
                    case .failure(_):
                        completion(.failure(NetworkingError.serverError))
                }
        }
    }
}
