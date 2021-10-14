//
//  MovieProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/09/2021.
//

import Foundation
import UIKit

protocol MovieProtocol: Codable //, Equatable
{
    var id: Int { get }
    var title: String { get }
    var originalTitle: String { get }
    var posterPath: String { get }
    var releaseDate: String { get }
    var overview: String { get }
    
    //func isEqualTo(_ other: MovieProtocol) -> Bool
    //static func ==(lhs: MovieProtocol, rhs: MovieProtocol) -> Bool
}
/*
extension MovieProtocol where Self: Equatable
{
    func isEqualTo(_ other: MovieProtocol) -> Bool {
        guard let otherMovie = other as? Self
        else {
            return false
        }
        
        return self == otherMovie
    }
}

struct AnyEquatableMovie: MovieProtocol
{
    private let movie: MovieProtocol
    
    init(_ movie: MovieProtocol) {
        self.movie = movie
    }
    
    var id: Int {
        return movie.id
    }
    
    var title: String {
        return movie.title
    }
    
    var originalTitle: String {
        return movie.originalTitle
    }
    
    var posterPath: String {
        return movie.posterPath
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
    
    var overview: String {
        return movie.overview
    }
}

extension AnyEquatableMovie: Equatable {
    static func == (lhs: AnyEquatableMovie, rhs: AnyEquatableMovie) -> Bool {
        return lhs.movie.isEqualTo(rhs.movie)
    }
}
*/
