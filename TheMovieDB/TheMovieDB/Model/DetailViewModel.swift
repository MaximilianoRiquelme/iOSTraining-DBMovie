//
//  DetailedMovieController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol
{
    var englishTitle: String
    var originalTitle: String
    var posterPath: URL?
    var releaseDate: String
    var overview: String
    
    init(movie: MovieProtocol) {
        englishTitle = movie.title
        originalTitle = movie.originalTitle
        posterPath = URL(string: "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)")
        releaseDate = "Release Date: \(movie.releaseDate)"
        overview = movie.overview
    }
}
