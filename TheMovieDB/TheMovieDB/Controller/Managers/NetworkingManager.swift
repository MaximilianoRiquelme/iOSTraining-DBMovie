//
//  NetworkingTest.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 02/09/2021.
//

import Foundation

typealias SingleMovieResult = (Result<MovieProtocol, Error>) -> Void
typealias MovieListResult = (Result<[MovieProtocol], Error>) -> Void

enum NetworkingError: Error
{
    case urlError
    case serverError
    case parsingError
}

protocol NetworkingManagerProtocol
{
    func getSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    func getTopRated(page: Int ,completion: @escaping MovieListResult)
}

class NetworkingManager: NetworkingManagerProtocol
{
    static let shared = NetworkingManager()
    
    private init() {
        
    }
    
    func getSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        //Sets the URL
        guard let myUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=1f4d7de5836b788bdfd897c3e0d0a24b")
        else{
            completion(.failure(NetworkingError.urlError))
            return
        }
        
        //Starts a DataTask
        let myDataTask = URLSession.shared.dataTask(with: myUrl) {
            (data, urlResponse, error) in
            
            guard let myData = data, error == nil
            else {
                completion(.failure(NetworkingError.serverError))
                return
            }
            
            //If we have a response, we try to decode the JSON
            do {
                let myMovie = try JSONDecoder().decode(SingleMovie.self, from: myData)
                completion(.success(myMovie))
            }
            catch {
                completion(.failure(NetworkingError.parsingError))
            }
        }
        
        myDataTask.resume()
    }
    
    func getTopRated(page: Int ,completion: @escaping MovieListResult) {
        //Sets the URL
        guard let myUrl = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&page=\(page))")
        else {
            completion(.failure(NetworkingError.urlError))
            return
        }
        
        //Starts a DataTask
        let myDataTask = URLSession.shared.dataTask(with: myUrl) {
            (data, urlResponse, error) in
            
            guard let myData = data, error == nil
            else {
                completion(.failure(NetworkingError.serverError))
                return
            }
            
            //If we have a response, we try to decode the JSON
            do {
                let myMovies = try JSONDecoder().decode(TopRatedList.self, from: myData)
                completion(.success(myMovies.results))
            }
            catch {
                completion(.failure(NetworkingError.parsingError))
            }
        }
        
        myDataTask.resume()
    }
}
