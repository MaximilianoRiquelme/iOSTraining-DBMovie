//
//  MovieController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import Foundation

class APIClient: APIClientProtocol
{
    let baseURL: String //api.themoviedb.org
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func loadTopRated(page: Int, completion: @escaping APIClientResult) {
        //Sets the URL
        guard let myUrl = URL(string: "https://\(baseURL)/3/movie/top_rated?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&page=\(page)")
        else {
            completion(.failure(APIClientError.urlError))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: myUrl) {
            (data, urlResponse, error) in
            
            guard let myData = data, let myResponse = urlResponse as? HTTPURLResponse, myResponse.statusCode == 200, error == nil
            else {
                completion(.failure(APIClientError.serverError))
                return
            }
            
            do {
                let myMovies = try JSONDecoder().decode(TopRatedList.self, from: myData)
                completion(.success(myMovies))
            }
            catch {
                completion(.failure(APIClientError.parsingError))
            }
        }
        
        dataTask.resume()
    }
}
