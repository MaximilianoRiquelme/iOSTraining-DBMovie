//
//  DetailVIewModelProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 26/10/2021.
//

import Foundation

protocol DetailViewModelProtocol
{
    var englishTitle: String { get }
    var originalTitle: String { get }
    var posterPath: URL? { get }
    var releaseDate: String { get }
    var overview: String { get }
}
