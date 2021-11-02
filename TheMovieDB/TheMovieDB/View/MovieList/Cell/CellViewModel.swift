//
//  CellViewModel.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 26/10/2021.
//

import Foundation

class CellViewModel: CellViewModelProtocol
{
    var englishTitle: String
    var posterPath: URL?
    
    init(movie: MovieProtocol) {
        englishTitle = movie.title
        posterPath = URL(string: "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)")
    }
}
