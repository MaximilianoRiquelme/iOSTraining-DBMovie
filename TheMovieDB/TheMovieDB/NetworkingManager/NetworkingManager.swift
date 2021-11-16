//
//  NetworkingManager.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 02/09/2021.
//

import Foundation

class NetworkingManager: NetworkingManagerProtocol
{
    static let shared = NetworkingManager()
    
    private init() {
        
    }
    
    func getData(url: URL, completion: @escaping NetworkingResult) {
        //Starts a DataTask
        let myDataTask = URLSession.shared.dataTask(with: url) {
            (data, urlResponse, error) in
            
            guard let myData = data, error == nil
            else {
                completion(.failure(NetworkingError.serverError))
                return
            }
            completion(.success(myData))
        }
        
        myDataTask.resume()
    }
}
