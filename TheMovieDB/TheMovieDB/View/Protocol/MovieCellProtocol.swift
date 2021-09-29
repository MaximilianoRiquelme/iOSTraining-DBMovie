//
//  MovieCellProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 24/09/2021.
//

import Foundation
import UIKit

protocol MovieCellProtocol
{
    func restoreCell()
    func updateCell(movie: MovieProtocol)
}
