//
//  MovieProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/09/2021.
//

import Foundation
import UIKit

protocol MovieProtocol: Codable
{
    var id: Int { get }
    var title: String { get }
    var originalTitle: String { get }
    var posterPath: String { get }
    var releaseDate: String { get }
    var overview: String { get }
}
