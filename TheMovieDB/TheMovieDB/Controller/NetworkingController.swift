//
//  NetworkingTest.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 02/09/2021.
//

import Foundation

typealias SingleMovieResult = (Result<SingleMovie, Error>) -> Void
typealias TopRatedResult = (Result<TopRated, Error>) -> Void

enum NetworkingError: Error
{
    case urlError
    case serverError
    case parsingError
}

class NetworkingController
{
    static func parseSingleMovie(movieId: String, completion: @escaping SingleMovieResult)
    {
        guard let myUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=1f4d7de5836b788bdfd897c3e0d0a24b")
        else{
            completion(.failure(NetworkingError.urlError))
            return
        }
        
        //let sessionConfig = URLSessionConfiguration.default
        //let mySession = URLSession(configuration: sessionConfig)
        
        let myDataTask = URLSession.shared.dataTask(with: myUrl) { (data, urlResponse, error) in
            guard let myData = data, error == nil
            else {
                completion(.failure(NetworkingError.serverError))
                return
            }
            
            //If we have a response
            do
            {
                let myMovie = try JSONDecoder().decode(SingleMovie.self, from: myData)
                completion(.success(myMovie))
            }
            catch
            {
                completion(.failure(NetworkingError.parsingError))
            }
        }
        
        myDataTask.resume()
    }
    
    static func parseTopRated(completion: @escaping TopRatedResult)
    {
        guard let myUrl = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=1f4d7de5836b788bdfd897c3e0d0a24b")
        else{
            completion(.failure(NetworkingError.urlError))
            return
        }
        
        //let sessionConfig = URLSessionConfiguration.default
        //let mySession = URLSession(configuration: sessionConfig)
        
        let myDataTask = URLSession.shared.dataTask(with: myUrl) { (data, urlResponse, error) in
            guard let myData = data, error == nil
            else {
                completion(.failure(NetworkingError.serverError))
                return
            }
            
            //If we have a response
            do
            {
                let myMovies = try JSONDecoder().decode(TopRated.self, from: myData)
                completion(.success(myMovies))
            }
            catch
            {
                completion(.failure(NetworkingError.parsingError))
            }
        }
        
        myDataTask.resume()
    }
}
